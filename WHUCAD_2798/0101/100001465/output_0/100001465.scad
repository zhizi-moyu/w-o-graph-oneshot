
// Parameters
outer_width = 40;
outer_depth = 25;
outer_height = 30;
wall_thickness = 2;
flange_thickness = 2;
flange_extension = 3;

// Inner cavity dimensions (tapered)
inner_top_width = outer_width - 2 * wall_thickness;
inner_top_depth = outer_depth - 2 * wall_thickness;
inner_bottom_width = inner_top_width - 6;  // tapering inward
inner_bottom_depth = inner_top_depth - 6;
inner_height = outer_height;

// Main block with flanges
module tapered_hollow_block() {
    difference() {
        // Outer block with flanges
        union() {
            // Main outer box
            cube([outer_width, outer_depth, outer_height], center=false);
            
            // Top flange
            translate([-flange_extension, -flange_extension, outer_height])
                cube([outer_width + 2*flange_extension, outer_depth + 2*flange_extension, flange_thickness]);

            // Bottom flange
            translate([-flange_extension, -flange_extension, -flange_thickness])
                cube([outer_width + 2*flange_extension, outer_depth + 2*flange_extension, flange_thickness]);
        }

        // Inner tapered cavity
        translate([wall_thickness, wall_thickness, 0])
            linear_extrude(height=inner_height)
                polygon(points=[
                    [0, 0],
                    [inner_top_width, 0],
                    [inner_bottom_width, inner_bottom_depth],
                    [0, inner_bottom_depth]
                ]);
    }
}

// Call the module
tapered_hollow_block();

