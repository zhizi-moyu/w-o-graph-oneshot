
// Parameters
block_length = 60;
block_width = 30;
block_height = 10;
hole_diameter = 6;
hole_offset_x = 15; // Distance from center of hole to edge
corner_radius = 2;

// Module for rounded rectangular block
module rounded_block(length, width, height, radius) {
    minkowski() {
        cube([length - 2*radius, width - 2*radius, height - 2*radius], center=true);
        sphere(r=radius, $fn=32);
    }
}

// Module for the block with holes
module rectangular_block_with_holes() {
    difference() {
        // Rounded block
        translate([0, 0, block_height/2])
            rounded_block(block_length, block_width, block_height, corner_radius);
        
        // Holes
        for (x = [-1, 1]) {
            translate([x * (block_length/2 - hole_offset_x), 0, block_height/2])
                rotate([90, 0, 0])
                    cylinder(h=block_width + 2, d=hole_diameter, center=true, $fn=64);
        }
    }
}

// Render the model
rectangular_block_with_holes();

