```scad
// ========== Parameters ==========
jaw_width = 20;
jaw_height = 20;
jaw_depth = 30;
groove_radius = 10;
slot_width = 6;
slot_depth = 10;
core_radius = 10;
core_height = 20;
arm_thickness = 4;
bolt_radius = 2;
bolt_length = 40;
nut_radius = 4;
nut_height = 3;

// ========== Modules ==========

// Left Jaw Block
module left_jaw_block() {
    difference() {
        cube([jaw_width, jaw_depth, jaw_height]);
        // Semi-circular groove
        translate([jaw_width/2, jaw_depth/2, jaw_height/2])
            rotate([90,0,0])
                cylinder(h=jaw_depth, r=groove_radius, center=true);
        // Vertical slot
        translate([(jaw_width-slot_width)/2, 0, jaw_height/2])
            cube([slot_width, slot_depth, jaw_height], center=true);
        // Bolt holes
        for (y = [jaw_depth*0.25, jaw_depth*0.75])
            translate([jaw_width/2, y, jaw_height/2])
                rotate([90,0,0])
                    cylinder(h=jaw_width+2, r=bolt_radius, center=true);
    }
}

// Right Jaw Block (mirrored)
module right_jaw_block() {
    mirror([1,0,0])
        left_jaw_block();
}

// Central Cylindrical Core
module central_cylindrical_core() {
    difference() {
        cylinder(h=core_height, r=core_radius, center=true);
        // Central bore
        cylinder(h=core_height+2, r=core_radius/3, center=true);
    }
}

// Clamping Arm (generic)
module clamping_arm(mirrorY=false) {
    translate([0, 0, 0])
    rotate([0, 0, mirrorY ? 180 : 0])
    difference() {
        hull() {
            translate([-core_radius, -arm_thickness/2, 0])
                cube([2*core_radius, arm_thickness, arm_thickness]);
            translate([-core_radius, -arm_thickness/2, arm_thickness])
                cube([2*core_radius, arm_thickness, arm_thickness]);
        }
        // Hook cutout
        translate([-slot_width/2, -arm_thickness, 0])
            cube([slot_width, 2*arm_thickness, arm_thickness]);
    }
}

// Bolt
module bolt() {
    union() {
        // Shaft
        cylinder(h=bolt_length, r=bolt_radius);
        // Head
        translate([0,0,bolt_length])
            cylinder(h=2, r=bolt_radius*1.5);
    }
}

// Nut
module nut() {
    cylinder(h=nut_height, r=nut_radius, $fn=6);
}

// ========== Assembly ==========

module assembly() {
    // Layer 2: Jaw blocks and core
    translate([-jaw_width, 0, 0])
        left_jaw_block();
    translate([0, 0, 0])
        right_jaw_block();
    translate([-jaw_width/2, jaw_depth/2, jaw_height/2])
        central_cylindrical_core();

    // Layer 1: Upper clamping arm
    translate([-jaw_width/2, jaw_depth/2, jaw_height])
        clamping_arm();

    // Layer 3: Lower clamping arm
    translate([-jaw_width/2, jaw_depth/2, 0])
        clamping_arm(mirrorY=true);

    // Layer 4: Bolts and nuts
    for (y = [jaw_depth*0.25, jaw_depth*0.75]) {
        // Bolt
        translate([-jaw_width, y, jaw_height/2])
            rotate([0,90,0])
                bolt();
        // Nut
        translate([jaw_width, y, jaw_height/2])
            rotate([0,90,0])
                nut();
    }
}

// Call the assembly
assembly();
```

