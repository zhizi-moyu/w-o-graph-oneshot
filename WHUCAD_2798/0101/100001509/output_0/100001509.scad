
// Parameters
plate_size = 60;         // Length and width of the square plate
plate_thickness = 3;     // Thickness of the plate
corner_radius = 5;       // Radius for rounded corners
hole_diameter = 5;       // Diameter of the central hole

module square_plate() {
    difference() {
        // Rounded square plate
        linear_extrude(height = plate_thickness)
            offset(r = corner_radius)
                square([plate_size - 2*corner_radius, plate_size - 2*corner_radius], center = true);

        // Central hole
        translate([0, 0, -1])  // Slightly lower to ensure clean subtraction
            cylinder(h = plate_thickness + 2, d = hole_diameter, center = true);
    }
}

// Render the plate
square_plate();

