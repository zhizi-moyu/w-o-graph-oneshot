
// Parameters
bracket_thickness = 5;
base_length = 60;
base_width = 60;
vertical_height = 40;
hole_radius = 10;
corner_hole_radius = 2.5;
slot_width = 5;
slot_height = 20;
slot_offset_x = 15;
slot_spacing = 30;

// Main L-bracket
module mounting_bracket() {
    difference() {
        union() {
            // Horizontal base plate
            cube([base_length, base_width, bracket_thickness]);

            // Vertical plate
            translate([0, 0, bracket_thickness])
                cube([base_length, bracket_thickness, vertical_height]);
        }

        // Central large hole
        translate([base_length/2, base_width/2, -1])
            cylinder(h = bracket_thickness + 2, r = hole_radius, $fn=64);

        // Corner holes
        for (x = [10, base_length - 10])
            for (y = [10, base_width - 10])
                translate([x, y, -1])
                    cylinder(h = bracket_thickness + 2, r = corner_hole_radius, $fn=32);

        // Vertical slots in vertical plate
        for (i = [0, 1]) {
            translate([slot_offset_x + i * slot_spacing, bracket_thickness/2, bracket_thickness + (vertical_height - slot_height)/2])
                rotate([90, 0, 0])
                    rounded_slot(slot_width, slot_height, bracket_thickness + 2);
        }
    }
}

// Helper module for rounded slot
module rounded_slot(width, height, depth) {
    hull() {
        translate([0, 0, 0])
            cylinder(h = depth, r = width/2, $fn=32);
        translate([0, height, 0])
            cylinder(h = depth, r = width/2, $fn=32);
    }
}

// Render the bracket
mounting_bracket();

