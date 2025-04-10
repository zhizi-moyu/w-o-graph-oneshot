```scad
$fn = 100; // Smoothness

// Parameters
coupling_diameter = 30;
coupling_length = 40;
bore_diameter = 10;
set_screw_diameter = 4;
set_screw_depth = 6;
slot_width = 2;
slot_depth = 3;
num_slots = 6;
slot_spacing = 4;

// Main body
module coupling_body() {
    difference() {
        // Outer cylinder
        cylinder(h = coupling_length, d = coupling_diameter);

        // Central bore
        translate([0, 0, -1])
            cylinder(h = coupling_length + 2, d = bore_diameter);

        // Set screw holes (2 on each end)
        for (z = [5, coupling_length - 5]) {
            rotate([90, 0, 0])
                translate([-coupling_diameter/2 - 1, z, 0])
                    cylinder(h = set_screw_depth, d = set_screw_diameter);
        }

        // Slots (simulate helical and straight cuts)
        for (i = [0:num_slots - 1]) {
            angle = i * 360 / num_slots;
            translate([0, 0, 10 + i * slot_spacing])
                rotate([0, 0, angle])
                    slot_cut();
        }
    }
}

// Slot cut module
module slot_cut() {
    translate([-coupling_diameter/2, -slot_width/2, 0])
        cube([coupling_diameter, slot_width, coupling_length/2], center = false);
}

// Render the model
coupling_body();
```

