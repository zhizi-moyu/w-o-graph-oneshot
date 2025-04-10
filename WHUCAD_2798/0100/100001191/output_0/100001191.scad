
// Dimensions
block_width = 20;
block_depth = 40;
block_height = 20;
slope_depth = 20;  // Depth of the sloped front part
slope_height = 10; // Height difference due to the slope

module angled_block() {
    difference() {
        // Full rectangular block
        cube([block_width, block_depth, block_height]);

        // Sloped cut
        translate([0, 0, 0])
            rotate([0, 90, 0])
                linear_extrude(height = block_width)
                    polygon(points=[
                        [0, 0],
                        [block_depth - slope_depth, 0],
                        [block_depth, slope_height],
                        [block_depth, block_height],
                        [0, block_height]
                    ]);
    }
}

// Render the block
angled_block();

