/*
 USB-A female cable-tail, two-part compression mounting bracket
 REV 0.5 | 10 November 2026

 Two PRINTED parts only:
   (1) Reinforced base cradle, 28mm case fixing centres,
       2 side-insert captive M3 nuts for case mounting,
       2 rear-insert captive M3 nuts for lid fixing.
   (2) One-piece screw-down lid, with integral compression tongue.

 The METAL USB-A receptacle is nominally 13.84 wide x 6.26 high x
 14.00 long. The two-piece clamp captures THIS metal portion only.
 No oversized cavity for the black moulded cable housing.
 The back (z=14) is open so the moulding and cable can extend behind.

 Coordinates in assembled configuration:
   X = width (28mm mounting centres along X)
   Y = USB shell height (lid bolts enter down along -Y)
   Z = insertion length, front metal panel at Z=0, cable behind Z=14

 Change part below to export individual objects or test sample:
    "cradle_print", "lid_print", "test_cradle", "test_lid",
    "assembled", "exploded", "print_layout"

 All dimensions mm. Do not overtighten against metal USB shell.
*/
part = "exploded";
show_mock_usb = true;
show_mock_fasteners = false;
$fn = 56;

// USER MEASURED (do not substitute the old metal-case opening measurements)
usb_width = 13.84;
usb_height = 6.26;
usb_length = 14.00;
case_fixing_pitch = 28.00;

// FIT & PRINT CALIBRATION
// 0.10mm TOTAL width clearance => 13.94mm printed cavity in CAD.
// Small allowance is intentional: printed internal dimensions often undersize.
width_clearance_total = 0.10;
floor_height_clearance = 0.05;
// With lid fully tightened the flat tongue creates 0.08mm NOMINAL preload.
// Adjust towards 0.00 for less compression or 0.12 for more.
lid_preload = 0.08;
lid_tongue_side_clearance = 0.17;

// COMPACT 14MM-DEEP REINFORCED BODY
outer_half_w = 19.20;       // 38.4mm overall width, full solid side cheeks
base_bottom_y = -7.50;
base_top_y = 6.10;
lid_thickness = 3.00;
lid_top_y = base_top_y + lid_thickness;

cavity_width = usb_width + width_clearance_total;   // 13.94
cavity_half_x = cavity_width / 2;
cavity_bottom_y = -usb_height/2 - floor_height_clearance; // -3.18
// Flat lid tongue will be 0.08mm lower than a 6.26mm shell resting
// on the pocket floor. This is adjustable in the SCAD above.
tongue_bottom_y = cavity_bottom_y + usb_height - lid_preload; // 3.00
tongue_width = cavity_width - 2*lid_tongue_side_clearance;

// CASE M3 (2 bolts entering from FRONT + 2 side-fed M3 nuts)
case_bolt_x = case_fixing_pitch/2;  // +/-14.00
case_bore_d = 3.40;
case_nut_y_width = 5.90;
case_nut_z_start = 3.60;
case_nut_z_thickness = 2.90;
case_nut_inner_edge_x = 10.65;
case_bore_end_z = 7.00;

// LID M3 (2 bolts entering from TOP + 2 rear-fed M3 nuts)
lid_bolt_x = 14.80;
lid_bolt_z = 10.85;
lid_bore_d = 3.40;
lid_nut_width_x = 5.90;
lid_nut_y_start = 1.15;
lid_nut_y_thickness = 2.95;
lid_nut_z_entry_start = 7.70;

module cradle_assembled() {
    difference() {
        union() {
            // Full-width flat floor, all the way to the 14mm rear edge.
            translate([-outer_half_w,base_bottom_y,0])
                cube([2*outer_half_w,cavity_bottom_y-base_bottom_y,usb_length]);
            // Two SOLID square-sided cheeks, with integrated nut holders;
            // no thin standalone ears, round bosses or unwanted recesses.
            for (s=[-1,1])
                translate([s<0 ? -outer_half_w : cavity_half_x,
                           cavity_bottom_y,0])
                    cube([outer_half_w-cavity_half_x,
                          base_top_y-cavity_bottom_y,usb_length]);
        }

        // Case mounting screws: centres 28mm apart, front to rear (+Z).
        for (s=[-1,1])
            translate([s*case_bolt_x,0,-0.15])
                cylinder(h=case_bore_end_z+0.15,d=case_bore_d);

        // Slots for case M3 captive nuts enter from OUTER X edges.
        // 5.9mm across Y x 2.9mm along Z; M3 hex 5.5AF x ~2.4 thick.
        for (s=[-1,1])
            translate([s<0 ? -outer_half_w-0.2 : case_nut_inner_edge_x,
                       -case_nut_y_width/2,case_nut_z_start])
                cube([outer_half_w-case_nut_inner_edge_x+0.2,
                      case_nut_y_width,case_nut_z_thickness]);

        // Two M3 clearance bores for lid clamp, into M3 nut chambers.
        for (s=[-1,1])
            translate([s*lid_bolt_x,-3.15,lid_bolt_z])
                rotate([-90,0,0])
                    cylinder(h=base_top_y+3.15+0.2,d=lid_bore_d);

        // Rear-fed captive nut channels.  They terminate at the REAR EDGE;
        // nut flat faces lie perpendicular to each lid bolt (Y-axis).
        // They do not intersect the CASE mounting nut slots.
        for (s=[-1,1])
            translate([s*lid_bolt_x-lid_nut_width_x/2,
                       lid_nut_y_start,lid_nut_z_entry_start])
                cube([lid_nut_width_x,lid_nut_y_thickness,
                      usb_length-lid_nut_z_entry_start+0.2]);
    }
}

module lid_assembled() {
    difference() {
        union() {
            // Flat strengthening plate and integral central clamping tongue.
            translate([-outer_half_w,base_top_y,0])
                cube([2*outer_half_w,lid_thickness,usb_length]);
            // The tongue is the compression element (no loose shims).
            // It descends into the 13.94mm-wide pocket, closing around
            // the 6.26mm-high metal USB shell.
            translate([-tongue_width/2,tongue_bottom_y,0])
                cube([tongue_width,base_top_y-tongue_bottom_y,usb_length]);
        }
        for (s=[-1,1])
            translate([s*lid_bolt_x,base_top_y-0.15,lid_bolt_z])
                rotate([-90,0,0])
                    cylinder(h=lid_thickness+0.3,d=lid_bore_d);
    }
}

// Printing: base laid on large, perfectly flat FLOOR; lid on its OUTER face.
// No supports required for the USB channel itself.
module cradle_print() {
    translate([0,0,-base_bottom_y])
        rotate([90,0,0]) cradle_assembled();
}
module lid_print() {
    translate([0,0,lid_top_y])
        rotate([-90,0,0]) lid_assembled();
}

// Cheap short-slice interference test; two printed pieces, thumb-pressure
// fit only. If too tight or too loose, edit fit settings and re-export STLs.
module test_cradle() {
    intersection() {
        cradle_assembled();
        translate([-10.0,base_bottom_y-0.1,-0.1])
            cube([20.0,base_top_y-base_bottom_y+0.2,5.5]);
    }
}
module test_lid() {
    intersection() {
        lid_assembled();
        translate([-10.0,tongue_bottom_y-0.1,-0.1])
            cube([20.0,lid_top_y-tongue_bottom_y+0.2,5.5]);
    }
}
module test_cradle_print() {
    translate([0,0,-base_bottom_y])
        rotate([90,0,0]) test_cradle();
}
module test_lid_print() {
    translate([0,0,lid_top_y])
        rotate([-90,0,0]) test_lid();
}

module mock_usb() {
    // Illustrative USB-A female shell.  NOT a supplied print part.
    // Open slot and plastic contact tongue make the interface recognisable.
    color([0.68,0.72,0.78,0.96])
        difference() {
            translate([-usb_width/2,-usb_height/2,0.02])
                cube([usb_width,usb_height,usb_length-0.02]);
            translate([-usb_width/2+0.75,-usb_height/2+0.65,-0.08])
                cube([usb_width-1.5,usb_height-1.30,9.7]);
        }
    color([0.88,0.86,0.79,0.99])
        translate([-5.1,-1.55,0.16]) cube([10.2,1.9,9.2]);
    // Behind z=14 the user's existing moulded cable housing can extend
    // without entering the clamp.  This cube is schematic only.
    color([0.2,0.2,0.23,0.95])
        translate([-3.0,-3.0,usb_length+0.03]) cube([6,6,4.2]);
}

module mock_fasteners() {
    for (s=[-1,1]) {
        color([0.63,0.65,0.70]) {
            translate([s*case_bolt_x,0,-1.5]) cylinder(h=8.8,d=3.0);
            translate([s*case_bolt_x,0,-3.0]) cylinder(h=1.7,d=5.5);
            translate([s*lid_bolt_x,lid_top_y-10.0,lid_bolt_z])
                rotate([-90,0,0]) cylinder(h=10,d=3.0);
            translate([s*lid_bolt_x,lid_top_y,lid_bolt_z])
                rotate([-90,0,0]) cylinder(h=1.8,d=5.5);
        }
    }
}

if (part=="cradle_print") cradle_print();
else if (part=="lid_print") lid_print();
else if (part=="test_cradle") test_cradle_print();
else if (part=="test_lid") test_lid_print();
else if (part=="cradle_assembled") cradle_assembled();
else if (part=="lid_assembled") lid_assembled();
else if (part=="assembled") {
    color("#3B6B8C") cradle_assembled();
    color("#E4A449") lid_assembled();
    if(show_mock_usb) mock_usb();
    if(show_mock_fasteners) mock_fasteners();
}
else if (part=="exploded") {
    color("#3B6B8C") cradle_assembled();
    if(show_mock_usb) mock_usb();
    color("#E4A449") translate([0,7.2,0]) lid_assembled();
}
else if (part=="print_layout") {
    // ONLY the two production printable parts, already bed oriented.
    color("#3B6B8C") translate([-24,0,0]) cradle_print();
    color("#E4A449") translate([24,0,0]) lid_print();
}
