```scad
$fn = 100;

// Parameters
hub_d = 30;
hub_l = 15;
bore_d = 10;
flange_d = 40;
flange_t = 5;
bolt_d = 3;
bolt_head_d = 5;
bolt_head_h = 2;
bolt_circle_r = 12;
bellows_d = 28;
bellows_l = 30;
bellows_ridges = 6;
bellows_ridge_h = 2;
nut_d = 5;
nut_h = 2;

// Modules
module hub() {
    difference() {
        union() {
            cylinder(h = hub_l, d = hub_d);
            translate([0, 0, hub_l - flange_t])
                cylinder(h = flange_t, d = flange_d);
        }
        // Bore
        translate([0, 0, -1])
            cylinder(h = hub_l + 2, d = bore_d);
        // Bolt holes
        for (i = [0:120:360]) {
            angle = i;
            x = bolt_circle_r * cos(angle);
            y = bolt_circle_r * sin(angle);
            translate([x, y, hub_l - flange_t - 1])
                cylinder(h = flange_t + 2, d = bolt_d);
        }
    }
}

module flange_ring() {
    difference() {
        cylinder(h = flange_t, d = flange_d);
        // Center hole
        translate([0, 0, -1])
            cylinder(h = flange_t + 2, d = bore_d);
        // Bolt holes
        for (i = [0:120:360]) {
            angle = i;
            x = bolt_circle_r * cos(angle);
            y = bolt_circle_r * sin(angle);
            translate([x, y, -1])
                cylinder(h = flange_t + 2, d = bolt_d);
        }
    }
}

module bellows() {
    for (i = [0:bellows_ridges - 1]) {
        translate([0, 0, i * bellows_ridge_h])
            cylinder(h = bellows_ridge_h, d = bellows_d + (i % 2 == 0 ? 2 : -2));
    }
}

module bolt() {
    union() {
        // Shaft
        cylinder(h = flange_t * 2 + 2, d = bolt_d);
        // Head
        translate([0, 0, flange_t * 2 + 2])
            cylinder(h = bolt_head_h, d = bolt_head_d);
    }
}

module nut() {
    cylinder(h = nut_h, d = nut_d);
}

// Assembly
module coupling() {
    // Left hub
    hub();

    // Left flange ring
    translate([0, 0, hub_l])
        flange_ring();

    // Bolts and nuts (left)
    for (i = [0:120:360]) {
        angle = i;
        x = bolt_circle_r * cos(angle);
        y = bolt_circle_r * sin(angle);
        translate([x, y, hub_l])
            bolt();
        translate([x, y, hub_l - nut_h])
            nut();
    }

    // Bellows
    translate([0, 0, hub_l + flange_t])
        bellows();

    // Right flange ring
    translate([0, 0, hub_l + flange_t + bellows_l])
        flange_ring();

    // Bolts and nuts (right)
    for (i = [0:120:360]) {
        angle = i;
        x = bolt_circle_r * cos(angle);
        y = bolt_circle_r * sin(angle);
        translate([x, y, hub_l + flange_t + bellows_l])
            bolt();
        translate([x, y, hub_l + flange_t + bellows_l - nut_h])
            nut();
    }

    // Right hub
    translate([0, 0, hub_l + flange_t * 2 + bellows_l])
        hub();
}

coupling();
```

