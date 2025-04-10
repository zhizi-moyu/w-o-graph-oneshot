```scad
$fn = 100; // Smoothness

// Parameters
shaft_length = 60;
shaft_radius = 6;

hub_length = 15;
hub_radius = 10;
hub_bore_radius = 6;

flange_thickness = 4;
flange_radius = 14;
bolt_hole_radius = 1.5;
bolt_circle_radius = 10;

spacer_thickness = 1;

bolt_length = 12;
bolt_radius = 1.5;
nut_radius = 2.5;
nut_thickness = 2;

// Modules
module central_shaft() {
    cylinder(h = shaft_length, r = shaft_radius, center = true);
}

module hub() {
    difference() {
        cylinder(h = hub_length, r = hub_radius, center = true);
        translate([0, 0, -hub_length/2 - 1])
            cylinder(h = hub_length + 2, r = hub_bore_radius, center = false);
    }
}

module flange_plate() {
    difference() {
        cylinder(h = flange_thickness, r = flange_radius, center = true);
        for (i = [0:3]) {
            angle = i * 90;
            translate([bolt_circle_radius * cos(angle), bolt_circle_radius * sin(angle), 0])
                cylinder(h = flange_thickness + 2, r = bolt_hole_radius, center = true);
        }
    }
}

module spacer_ring() {
    difference() {
        cylinder(h = spacer_thickness, r = flange_radius, center = true);
        cylinder(h = spacer_thickness + 1, r = flange_radius - 2, center = true);
    }
}

module bolt() {
    cylinder(h = bolt_length, r = bolt_radius, center = true);
}

module nut() {
    cylinder(h = nut_thickness, r = nut_radius, center = true);
}

// Assembly
module coupling() {
    // Central Shaft
    central_shaft();

    // Hubs
    translate([0, 0, shaft_length/2 + hub_length/2])
        hub();
    translate([0, 0, -shaft_length/2 - hub_length/2])
        hub();

    // Flange Plates
    translate([0, 0, shaft_length/2 + hub_length + flange_thickness/2])
        flange_plate();
    translate([0, 0, -shaft_length/2 - hub_length - flange_thickness/2])
        flange_plate();

    // Spacer Ring
    translate([0, 0, 0])
        spacer_ring();

    // Bolts and Nuts
    for (i = [0:3]) {
        angle = i * 90;
        x = bolt_circle_radius * cos(angle);
        y = bolt_circle_radius * sin(angle);

        // Bolt
        translate([x, y, 0])
            bolt();

        // Nut on one end
        translate([x, y, shaft_length/2 + hub_length + flange_thickness + nut_thickness/2])
            nut();

        // Nut on the other end
        translate([x, y, -shaft_length/2 - hub_length - flange_thickness - nut_thickness/2])
            nut();
    }
}

// Render the full coupling
coupling();
```

