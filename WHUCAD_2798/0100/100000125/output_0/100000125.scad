
// Parameters
base_length = 60;
base_width = 10;
base_thickness = 4;

vertical_height = 40;
vertical_thickness = 4;

pin_diameter = 6;
pin_height = 8;

raised_feature_length = 10;
raised_feature_width = 6;
raised_feature_height = 2;

fillet_radius = 6;

// Main module
module angled_bracket_with_pin() {
    // Horizontal base
    difference() {
        union() {
            // Base
            cube([base_length, base_width, base_thickness]);

            // Vertical arm
            translate([0, 0, base_thickness])
                cube([vertical_thickness, base_width, vertical_height]);

            // Fillet (approximate with cylinder)
            translate([vertical_thickness, 0, base_thickness])
                rotate([0, 90, 0])
                    cylinder(h = base_width, r = fillet_radius, $fn=50);

            // Raised rectangular feature
            translate([base_length/2 - raised_feature_length/2, 
                       base_width/2 - raised_feature_width/2, 
                       base_thickness])
                cube([raised_feature_length, raised_feature_width, raised_feature_height]);

            // Cylindrical pin
            translate([base_length - 10, base_width/2, -pin_height])
                cylinder(h = pin_height, d = pin_diameter, $fn=50);
        }
    }
}

// Render the model
angled_bracket_with_pin();

