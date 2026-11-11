// Amiga Zorro LAN IDE CP XT Ethernet bezel adaptor v0.2: 14 mm height test fitted, millimetres.
// PCB above blocks; connector and components below PCB.
// Each block: PCB bolt into side-loaded captive nut; bracket bolt
// through recessed well and lower slot into existing threaded metal lug.
height=14; // Height confirmed by user print test.
part="pair"; // left, right, pair
$fn=64;
block_width=18;
block_depth=14;
pcb_x=4.5;
tab_x=13;
tab_y=5;
travel=4; // Original travel
channel_extension=0.5; // Extend CLOSED end only, along +Y
nut_af=5.7;
nut_thickness=2.6;
roof=2;
module slot(d,z,h){
 translate([tab_x,tab_y,z]) hull(){
  translate([0,-travel/2,0]) cylinder(d=d,h=h);
  translate([0,travel/2+channel_extension,0]) cylinder(d=d,h=h);
 }
}
module block(pcb_y){
 difference(){
  cube([block_width,block_depth,height]);
  // Upper PCB fixing, M3 clearance.
  translate([pcb_x,pcb_y,-0.1]) cylinder(d=3.4,h=height+.2);
  // Side-loading nut channel, opening towards interior of case.
  translate([pcb_x,pcb_y,height-roof-nut_thickness])
   rotate([0,0,30]) cylinder(d=nut_af/cos(30),h=nut_thickness,$fn=6);
  translate([pcb_x-nut_af/2,pcb_y,height-roof-nut_thickness])
   cube([nut_af,block_depth, nut_thickness]);
  // Lower bracket fixing: 2 mm floor, recessed M3 head access.
  slot(3.4,-.1,height+.2);
  slot(7,2,height);
 }
}
// Same selected mounting hole index on each side; Gerber setback differs.
if(part=="left") block(4.61262);
if(part=="right") mirror([1,0,0]) block(5.12062);
if(part=="pair"){
 block(4.61262);
 translate([44,0,0]) mirror([1,0,0]) block(5.12062);
}
