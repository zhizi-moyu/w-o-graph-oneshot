```scad
// ========== Parameters ==========
hub_diameter = 30;
hub_length = 20;
bore_diameter = 10;

flange_diameter = 50;
flange_thickness = 5;
bolt_hole_diameter = 4;
bolt_circle_diameter = 40;

spacer_thickness = 2;

bolt_diameter = 4;
bolt_length = 30;
nut_thickness = 3;
nut_diameter = 7;

bolt_positions = [
    [bolt_circle_diameter/2, 0],
    [-bolt_circle_diameter/2, 0],
    [0, bolt_circle_diameter/2],
    [0, -bolt_circle_diameter/2]
];

// ========== Modules ==========

module shaft_hub() {
    difference() {
        union() {
            // Main hub
            cylinder(d=hub_diameter, h=hub_length);
            // Flange
            translate([0, 0, hub_length])
                cylinder(d=flange_diameter, h=flange_thickness);
        }
        // Bore
        translate([0, 0, -1])
            cylinder(d=bore_diameter, h=hub_length + flange_thickness + 2);
    }
}

module flange_plate() {
    difference() {
        cylinder(d=flange_diameter, h=flange_thickness);
        // Bolt holes
        for (pos in bolt_positions)
            translate([pos[0], pos[1], 0])
                cylinder(d=bolt_hole_diameter, h=flange_thickness + 1);
        // Center hole
        translate([0, 0, 0])
            cylinder(d=bore_diameter, h=flange_thickness + 1);
    }
}

module spacer_ring() {
    difference() {
        cylinder(d=flange_diameter, h=spacer_thickness);
        translate([0, 0, -1])
            cylinder(d=flange_diameter - 10, h=spacer_thickness + 2);
    }
}

module bolt_with_nut() {
    union() {
        // Bolt shaft
        cylinder(d=bolt_diameter, h=bolt_length);
        // Nut
        translate([0, 0, bolt_length])
            cylinder(d=nut_diameter, h=nut_thickness, $fn=6);
    }
}

module full_assembly() {
    union() {
        // Input shaft hub
        translate([0, 0, 0])
            shaft_hub();

        // Layer 2 flange
        translate([0, 0, hub_length + flange_thickness])
            flange_plate();

        // Spacer ring 1
        translate([0, 0, hub_length + flange_thickness * 2])
            spacer_ring();

        // Layer 4 flange
        translate([0, 0, hub_length + flange_thickness * 2 + spacer_thickness])
            flange_plate();

        // Layer 5 flange
        translate([0, 0, hub_length + flange_thickness * 3 + spacer_thickness])
            flange_plate();

        // Spacer ring 2
        translate([0, 0, hub_length + flange_thickness * 4 + spacer_thickness])
            spacer_ring();

        // Layer 7 flange
        translate([0, 0, hub_length + flange_thickness * 4 + spacer_thickness * 2])
            flange_plate();

        // Output shaft hub
        translate([0, 0, hub_length + flange_thickness * 5 + spacer_thickness * 2])
            rotate([180, 0, 0])
                shaft_hub();

        // Bolts and nuts
        for (pos in bolt_positions)
            translate([pos[0], pos[1], hub_length + flange_thickness])
                bolt_with_nut();
    }
}

// ========== Render ==========
full_assembly();
```

