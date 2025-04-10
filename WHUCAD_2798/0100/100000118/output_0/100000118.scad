
// Parameters
block_size = 40;       // Width and depth of the block
block_height = 20;     // Height of the block
hollow_depth = 10;     // Depth of the hollow (inverted pyramid)
wall_thickness = 0.1;  // Small offset to ensure proper subtraction

module hollow_block() {
    difference() {
        // Outer solid block
        cube([block_size, block_size, block_height], center=false);

        // Inverted pyramid hollow
        translate([0, 0, block_height - hollow_depth])
            polyhedron(
                points=[
                    [0, 0, 0],
                    [block_size, 0, 0],
                    [block_size, block_size, 0],
                    [0, block_size, 0],
                    [block_size/2, block_size/2, hollow_depth + wall_thickness]
                ],
                faces=[
                    [0, 1, 4],
                    [1, 2, 4],
                    [2, 3, 4],
                    [3, 0, 4],
                    [0, 1, 2, 3]
                ]
            );
    }
}

// Render the model
hollow_block();

