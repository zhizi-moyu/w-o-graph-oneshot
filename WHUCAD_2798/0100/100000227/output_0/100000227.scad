```scad
// Parameters
fork_arm_length = 40;
fork_arm_thickness = 5;
fork_arm_height = 10;
fork_base_radius = 8;
fork_base_height = 10;
hole_radius = 2.5;
hole_offset = 30;

pin_body_width = 30;
pin_body_height = 10;
pin_body_thickness = 5;
pin_shaft_radius = 6;
pin_shaft_height = 20;

// Fork Head Module
module fork_head() {
    // Base cylinder
    translate([0, 0, 0])
        cylinder(h = fork_base_height, r = fork_base_radius, $fn = 64);

    // Left arm
    translate([-fork_arm_thickness/2 - fork_base_radius, -fork_arm_length/2, fork_base_height])
        cube([fork_arm_thickness, fork_arm_length, fork_arm_height]);

    // Right arm
    translate([fork_base_radius - fork_arm_thickness/2, -fork_arm_length/2, fork_base_height])
        cube([fork_arm_thickness, fork_arm_length, fork_arm_height]);

    // Holes in arms
    for (x = [-fork_base_radius, fork_base_radius]) {
        translate([x, hole_offset - fork_arm_length/2, fork_base_height + fork_arm_height/2])
            rotate([90, 0, 0])
                cylinder(h = fork_arm_thickness + 1, r = hole_radius, $fn = 32);
    }
}

// Pin Head Module
module pin_head() {
    // Flat body
    translate([-pin_body_thickness/2, -pin_body_width/2, 0])
        cube([pin_body_thickness, pin_body_width, pin_body_height]);

    // Holes in body
    for (y = [-hole_offset, hole_offset]) {
        translate([0, y, pin_body_height/2])
            rotate([90, 0, 0])
                cylinder(h = pin_body_thickness + 1, r = hole_radius, $fn = 32);
    }

    // Shaft
    translate([0, 0, -pin_shaft_height])
        cylinder(h = pin_shaft_height, r = pin_shaft_radius, $fn = 64);
}

// Assembly
union() {
    fork_head();
    translate([0, 0, fork_base_height + 1])  // Slight offset to avoid z-fighting
        pin_head();
}
```

