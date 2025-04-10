
$fn = 100; // Smoothness

// Parameters
coupling_diameter = 20;
coupling_length = 40;
half_length = coupling_length / 2;
bore_diameter = 6;
slit_width = 1;
slot_radius = 8;
slot_depth = 2;
screw_diameter = 3;
screw_head_diameter = 5;
screw_head_depth = 2;

// Main assembly
union() {
    translate([-half_length, 0, 0])
        left_coupling_half();
    translate([0, 0, 0])
        right_coupling_half();
}

// Left coupling half
module left_coupling_half() {
    difference() {
        // Main body
        cylinder(d=coupling_diameter, h=half_length, center=false);

        // Bore
        translate([0, 0, -1])
            cylinder(d=bore_diameter, h=half_length + 2);

        // Slit
        translate([-slit_width/2, coupling_diameter/2, 0])
            cube([slit_width, 5, half_length]);

        // Curved slot
        translate([0, 0, half_length - slot_depth])
            rotate([90, 0, 0])
                cylinder(r=slot_radius, h=slit_width, center=true);

        // Screw hole
        translate([0, coupling_diameter/2 - 2, half_length/2])
            rotate([90, 0, 0])
                cylinder(d=screw_diameter, h=coupling_diameter);

        // Screw head recess
        translate([0, coupling_diameter/2 - 2, half_length/2])
            rotate([90, 0, 0])
                cylinder(d=screw_head_diameter, h=screw_head_depth);
    }
}

// Right coupling half (mirror of left)
module right_coupling_half() {
    mirror([1, 0, 0])
        translate([-half_length, 0, 0])
            left_coupling_half();
}


