
// Parameters
block_length = 40;
block_width = 40;
block_height = 20;
fillet_radius = 4;

// Create the rounded edge block
module rounded_edge_block() {
    // Create a cube with rounded top edges using Minkowski sum
    difference() {
        minkowski() {
            // Base cube with reduced height to allow rounding only on top
            translate([0, 0, fillet_radius])
                cube([block_length - 2*fillet_radius, block_width - 2*fillet_radius, block_height - fillet_radius], center=false);
            // Sphere for rounding
            sphere(r=fillet_radius, $fn=32);
        }
        // Cut the bottom to keep it flat and sharp
        translate([-10, -10, -10])
            cube([block_length + 20, block_width + 20, fillet_radius], center=false);
    }
}

// Render the model
rounded_edge_block();

