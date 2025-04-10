
// Parameters
block_size = [40, 40, 20];         // Width, Depth, Height of the block
cutout_size = 10;                  // Size of the square base of each pyramid
cutout_depth = 10;                 // Depth of the pyramid cutout
spacing = 5;                       // Spacing between cutouts

module hollowed_block() {
    difference() {
        // Main block
        cube(block_size, center = false);

        // Pyramidal cutouts
        for (x = [0, 1])
            for (y = [0, 1])
                translate([
                    x * (cutout_size + spacing) + (block_size[0] - 2 * cutout_size - spacing) / 2,
                    y * (cutout_size + spacing) + (block_size[1] - 2 * cutout_size - spacing) / 2,
                    block_size[2] - cutout_depth
                ])
                pyramid_cutout(cutout_size, cutout_depth);
    }
}

// Pyramid cutout module
module pyramid_cutout(base, height) {
    polyhedron(
        points=[
            [0, 0, 0],
            [base, 0, 0],
            [base, base, 0],
            [0, base, 0],
            [base/2, base/2, -height]
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

// Render the model
hollowed_block();

