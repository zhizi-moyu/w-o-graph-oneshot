
// Parameters
outer_width = 40;
outer_height = 60;
thickness = 5;
depth = 5;
corner_radius = 10;

// Function to create a rounded rectangle
module rounded_rect(width, height, radius) {
    offset(r=radius)
        offset(delta=-radius)
            square([width - 2*radius, height - 2*radius], center=true);
}

// Outer shape
module loop_frame() {
    difference() {
        linear_extrude(height=depth)
            rounded_rect(outer_width, outer_height, corner_radius);
        translate([0, 0, -1])  // Slightly lower to ensure clean subtraction
            linear_extrude(height=depth + 2)
                rounded_rect(outer_width - 2*thickness, outer_height - 2*thickness, corner_radius - thickness);
    }
}

// Render the loop frame
loop_frame();

