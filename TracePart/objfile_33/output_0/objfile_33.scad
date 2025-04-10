
$fn = 100;

// Parameters
hub_radius = 20;
hub_length = 20;
flange_thickness = 5;
bore_radius = 5;
jaw_length = 5;
jaw_width = 6;
jaw_height = 5;
bolt_radius = 2;
bolt_hole_offset = 15;
bolt_head_radius = 3.5;
bolt_head_height = 2;
spider_arm_width = 5;
spider_arm_length = 7;
spider_thickness = 5;

// Modules
module hub(is_left=true) {
    difference() {
        union() {
            // Main body
            cylinder(h=hub_length, r=hub_radius);
            // Flange
            translate([0, 0, hub_length])
                cylinder(h=flange_thickness, r=hub_radius);
            // Jaws
            for (i = [0:2]) {
                angle = i * 120;
                rotate([0, 0, angle])
                    translate([hub_radius - jaw_width/2, -jaw_width/2, hub_length - jaw_height])
                        cube([jaw_width, jaw_width, jaw_height + 0.01]);
            }
        }
        // Bore
        translate([0, 0, -1])
            cylinder(h=hub_length + flange_thickness + 2, r=bore_radius);
        // Bolt holes
        for (i = [0:2]) {
            angle = i * 120;
            rotate([0, 0, angle])
                translate([bolt_hole_offset, 0, hub_length + flange_thickness/2])
                    rotate([90, 0, 0])
                        cylinder(h=flange_thickness + 2, r=bolt_radius);
        }
    }
}

module spider() {
    union() {
        for (i = [0:5]) {
            angle = i * 60;
            rotate([0, 0, angle])
                translate([hub_radius - spider_arm_length, -spider_arm_width/2, 0])
                    cube([spider_arm_length, spider_arm_width, spider_thickness]);
        }
    }
}

module bolt() {
    union() {
        // Shaft
        cylinder(h=flange_thickness * 2 + 2, r=bolt_radius);
        // Head
        translate([0, 0, flange_thickness * 2 + 2])
            cylinder(h=bolt_head_height, r=bolt_head_radius);
    }
}

// Assembly
module coupling() {
    // Left hub
    translate([0, 0, hub_length + spider_thickness])
        hub(true);
    // Right hub (mirrored)
    mirror([0, 0, 1])
        hub(false);
    // Spider
    translate([0, 0, hub_length])
        spider();
    // Bolts
    for (i = [0:2]) {
        angle = i * 120;
        rotate([0, 0, angle])
            translate([bolt_hole_offset, 0, hub_length + spider_thickness])
                bolt();
    }
}

coupling();

