// BlueSCSI 2023.10a, A4000 test-fit tray v0.5, mm.
// Corrected top-side handedness. Source PCB Y increases downwards.
// +Y remains intended SD-access side; verify case orientation during fitting.
$fn=64;
part="tray"; // tray, spacers, assembly
clearance=18;
plate=3;
standoff=2;
caseholes=[[-47.625,41.28],[47.625,41.28],[-47.625,85.73],[47.625,85.73]];
// Actual drill centres, not footprint bounding-box origins.
pcbholes=[[123.1392,110.0328],[144.1704,69.6976],[136.0932,142.6464]];
function rot(p)=[p[1]-105.105,60+p[0]-144.6023];
module hex(h){rotate(30)cylinder(h=h,r=5.7/sqrt(3),$fn=6);}
module tray(){difference(){union(){
 translate([-50.8,15.3977,0])cube([101.6,89.2046,plate]);
 for(p=pcbholes)let(q=rot(p))translate([q[0],q[1],plate-0.01])cylinder(d=6,h=standoff+0.01);
 }
 for(p=caseholes){translate([p[0],p[1],-0.1])cylinder(d=3.4,h=9);
 translate([p[0],p[1],0.8])hex(3);}
 for(p=pcbholes)let(q=rot(p)){
 translate([q[0],q[1],-0.1])cylinder(d=3.4,h=10);
 // Screw head counterbore: board screws installed from underside.
 translate([q[0],q[1],-0.1])cylinder(d=6.2,h=2.1);
 }
 // Uniform honeycomb: 16 mm point-to-point, 3 mm webs.
 // Clip cells at a 4 mm perimeter and 6.5 mm fixing pads.
 intersection(){
  difference(){
   translate([-46.8,19.3977,-0.1])cube([93.6,81.2046,plate+0.2]);
   for(p=caseholes)translate([p[0],p[1],-1])cylinder(r=6.5,h=plate+2);
   for(p=pcbholes)let(q=rot(p))translate([q[0],q[1],-1])cylinder(r=6.5,h=plate+2);
  }
  union(){
   cell_r=8;
   lattice_r=cell_r+3/sqrt(3);
   for(col=[-4:4], row=[-4:4])
    translate([col*1.5*lattice_r,60+(row+(abs(col)%2)/2)*sqrt(3)*lattice_r,-0.1])
     cylinder(r=cell_r,h=plate+0.2,$fn=6);
  }
 }

}}
module spacer(){difference(){cylinder(d=6.2,h=clearance);translate([0,0,-0.1])cylinder(d=3.4,h=clearance+0.2);}}
if(part=="tray")tray();
if(part=="spacers")for(x=[0,10,20,30])translate([x,0,0])spacer();
if(part=="assembly"){translate([0,0,clearance])tray();for(p=caseholes)translate([p[0],p[1],0])spacer();}

