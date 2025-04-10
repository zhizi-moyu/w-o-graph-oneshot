
// Parameters
thickness = 4;         // Uniform thickness of the bracket
short_arm = 20;        // Length of the shorter arm
long_arm = 40;         // Length of the longer arm
corner_radius = 4;     // Radius for the rounded outer corner

module L_bracket() {
    difference() {
        union() {
            // Vertical arm
            cube([thickness, thickness, long_arm]);

            // Horizontal arm
            cube([short_arm, thickness, thickness]);
        }

        // Cut out the corner to round it
        translate([thickness - corner_radius, thickness - corner_radius, thickness - corner_radius])
            rotate([0, 90, 0])
                cylinder(h = corner_radius * 2, r = corner_radius, $fn = 50);
    }
}

// Position the bracket upright as in the image
translate([0, 0, 0])
    rotate([0, 0, 0])
        L_bracket();

