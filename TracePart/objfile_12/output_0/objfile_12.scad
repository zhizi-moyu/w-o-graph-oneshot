```scad
// Parameters
hub_length = 30;
hub_radius = 15;
bore_radius = 5;
flange_thickness = 5;
flange_radius = 20;
groove_count = 4;
groove_depth = 2;
groove_width = 2;
bolt_radius = 1.5;
bolt_circle_radius = 12;
bolt_count = 8;
keyway_width = 2;
keyway_depth = 1;
slit_width = 1;

// Modules
module shaft_hub() {
    difference() {
        union() {
            // Main body
            cylinder(h = hub_length, r = hub_radius, $fn=100);
            // Flange
            translate([0, 0, hub_length])
                cylinder(h = flange_thickness, r = flange_radius, $fn=100);
        }

        // Bore
        translate([0, 0, -1])
            cylinder(h = hub_length + flange_thickness + 2, r = bore_radius, $fn=100);

        // Grooves
        for (i = [1:groove_count]) {
            translate([0, 0, i * (hub_length / (groove_count + 1))])
                rotate([0, 0, 0])
                    cylinder(h = groove_width, r1 = hub_radius + 1, r2 = hub_radius - groove_depth, $fn=100);
        }

        // Keyway slot
        translate([-keyway_width/2, bore_radius, hub_length/2])
            cube([keyway_width, keyway_depth, hub_length], center=true);

        // Clamping slit
        translate([-slit_width/2, -hub_radius, 0])
            cube([slit_width, 2*hub_radius, hub_length + flange_thickness]);
        
        // Bolt holes
        for (i = [0:bolt_count-1]) {
            angle = 360 / bolt_count * i;
            x = bolt_circle_radius * cos(angle);
            y = bolt_circle_radius * sin(angle);
            translate([x, y, hub_length])
                cylinder(h = flange_thickness + 2, r = bolt_radius, $fn=50);
        }
    }
}

module bolt() {
    union() {
        // Shaft
        cylinder(h = flange_thickness * 2, r = bolt_radius, $fn=30);
        // Head
        translate([0, 0, flange_thickness * 2])
            cylinder(h = 2, r = bolt_radius * 1.5, $fn=6);
    }
}

// Assembly
module coupling() {
    // Input hub
    shaft_hub();

    // Output hub (mirrored)
    translate([0, 0, hub_length + flange_thickness])
        mirror([0, 0, 1])
            shaft_hub();

    // Bolts
    for (i = [0:bolt_count-1]) {
        angle = 360 / bolt_count * i;
        x = bolt_circle_radius * cos(angle);
        y = bolt_circle_radius * sin(angle);
        translate([x, y, hub_length])
            bolt();
    }
}

// Render the full coupling
coupling();
```

