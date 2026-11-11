// Dual VGA bracket, alternative revision 0.7, millimetres. Front view: wide edge up.
// Flat print orientation; main plate z=0..2. Internal backing plate for 68 x 14 opening.
$fn=64;
thickness=2;
plate_width=84;
plate_height=18;
corner_radius=2;
case_pitch=76; // 68 + 4 + 4, user measurement
case_hole=3.4; // M3 clearance
port_pitch=34;
vga_screw_pitch=24.99;
vga_screw_clearance=3.4; // clearance only, NOT a thread specification
cutout_top=19;
cutout_bottom=15;
cutout_height=10;
cutout_corner_radius=0.75;
bottom_extension=2;
return_depth=3.6; // 2.6 mm nut depth + 1 mm rear wall
bar_height=2;
module outline(){union(){
 offset(r=corner_radius) square([plate_width-2*corner_radius,plate_height-2*corner_radius],center=true);
 // Extend downwards; overlap original lower rounded corners for full-width connection.
 translate([-plate_width/2,-plate_height/2-bottom_extension]) square([plate_width,bottom_extension+corner_radius]);
}}
module bottom_bar(){translate([-plate_width/2,-plate_height/2-bottom_extension,0])
 cube([plate_width,bar_height,thickness+return_depth]);}
module plate(){ linear_extrude(height=thickness) difference(){
 outline();

 for(c=[-port_pitch/2,port_pitch/2]){
 translate([c,0]) offset(r=cutout_corner_radius) offset(delta=-cutout_corner_radius) polygon([[-cutout_bottom/2,-cutout_height/2],[cutout_bottom/2,-cutout_height/2],[cutout_top/2,cutout_height/2],[-cutout_top/2,cutout_height/2]]);
 for(dx=[-vga_screw_pitch/2,vga_screw_pitch/2]) translate([c+dx,0]) circle(d=vga_screw_clearance);
 }
}
}

// DB23 fit: 5.7 mm across flats and 2.6 mm axial depth.
// Top means +Y (wide side of VGA openings), not rear +Z.
nut_af=5.7;
nut_depth=2.6;
rear_wall=1;
module nut_hex(){rotate([0,0,30]) circle(r=nut_af/sqrt(3),$fn=6);}
module nut_slot(){linear_extrude(height=nut_depth)
 hull(){nut_hex();translate([0,8]) nut_hex();}}
module boss(){difference(){
 translate([-4,-9.1,thickness-0.01]) cube([8,14.1,nut_depth+rear_wall+0.01]); // Extend down into bottom bar
 translate([0,0,thickness]) nut_slot();

}}
difference(){
 union(){plate();bottom_bar();for(x=[-case_pitch/2,case_pitch/2]) translate([x,0,0]) boss();}
 for(x=[-case_pitch/2,case_pitch/2]) translate([x,0,-0.1]) cylinder(d=case_hole,h=thickness+nut_depth+rear_wall+0.2);
}
