```scad
// Parameters
main_body_diameter = 30;
main_body_height = 30;
groove_width = 1.5;
groove_depth = 1.5;
groove_spacing = 5;
shaft_diameter = 10;
shaft_length = 20;
slot_width = 2;
slot_depth = main_body_diameter;
set_screw_diameter = 4;
set_screw_length = 6;
set_screw_offset = 8;

// Main Assembly
module flexible_coupling() {
    union() {
        main_cylindrical_body();
        shaft();
        set_screw(1);
        set_screw(2);
    }
}

// Main Body
module main_cylindrical_body() {
    difference() {
        union() {
            // Main cylinder
            cylinder(h = main_body_height, d = main_body_diameter, $fn=100);

            // Grooves
            for (i = [1:3]) {
                translate([0, 0, i * groove_spacing])
                    groove();
            }
        }

        // Slot on one end
        translate([-slot_depth/2, -slot_width/2, 0])
            cube([slot_depth, slot_width, main_body_height]);

        // Central hole for shaft
        translate([0, 0, -1])
            cylinder(h = shaft_length + 2, d = shaft_diameter, $fn=100);

        // Set screw holes
        for (i = [0:1]) {
            rotate([0, 0, i * 180])
                translate([main_body_diameter/2 - 1, 0, set_screw_offset])
                    rotate([0, 90, 0])
                        cylinder(h = set_screw_length + 2, d = set_screw_diameter, $fn=50);
        }
    }
}

// Groove
module groove() {
    difference() {
        translate([0, 0, 0])
            cylinder(h = groove_width, d = main_body_diameter + 1, $fn=100);
        translate([0, 0, -1])
            cylinder(h = groove_width + 2, d = main_body_diameter - groove_depth, $fn=100);
    }
}

// Shaft
module shaft() {
    translate([0, 0, main_body_height])
        cylinder(h = shaft_length, d = shaft_diameter, $fn=100);
}

// Set Screw
module set_screw(index) {
    angle = index == 1 ? 0 : 180;
    rotate([0, 0, angle])
        translate([main_body_diameter/2 - 1, 0, set_screw_offset])
            rotate([0, 90, 0])
                color("black")
                    cylinder(h = set_screw_length, d = set_screw_diameter, $fn=50);
}

// Render the model
flexible_coupling();
```

