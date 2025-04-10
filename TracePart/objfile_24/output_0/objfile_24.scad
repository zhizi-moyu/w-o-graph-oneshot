```scad
$fn = 100; // Smoothness

// Parameters
hub_d = 40;
hub_l = 20;
bore_d = 10;

flange_d = 50;
flange_t = 5;
bolt_hole_d = 4;
bolt_circle_d = 40;
bolt_count = 6;

spacer_t = 2;

shaft_d = 20;
shaft_l = 30;

bolt_d = 4;
bolt_l = flange_t * 2 + spacer_t + 4;
nut_h = 3.5;
nut_d = 7;

// Modules
module hub() {
    difference() {
        cylinder(d=hub_d, h=hub_l);
        translate([0, 0, -1])
            cylinder(d=bore_d, h=hub_l + 2);
    }
}

module flange_plate() {
    difference() {
        cylinder(d=flange_d, h=flange_t);
        translate([0, 0, -1])
            cylinder(d=bore_d, h=flange_t + 2);
        for (i = [0 : 360 / bolt_count : 360 - 360 / bolt_count]) {
            angle = i;
            x = bolt_circle_d / 2 * cos(angle);
            y = bolt_circle_d / 2 * sin(angle);
            translate([x, y, -1])
                cylinder(d=bolt_hole_d, h=flange_t + 2);
        }
    }
}

module spacer_ring() {
    difference() {
        cylinder(d=flange_d, h=spacer_t);
        translate([0, 0, -1])
            cylinder(d=bore_d, h=spacer_t + 2);
    }
}

module bolt_with_nut() {
    union() {
        cylinder(d=bolt_d, h=bolt_l);
        translate([0, 0, bolt_l])
            cylinder(d=nut_d, h=nut_h, $fn=6);
    }
}

module flange_assembly() {
    union() {
        flange_plate();
        translate([0, 0, flange_t])
            spacer_ring();
        translate([0, 0, flange_t + spacer_t])
            flange_plate();
        // Bolts
        for (i = [0 : 360 / bolt_count : 360 - 360 / bolt_count]) {
            angle = i;
            x = bolt_circle_d / 2 * cos(angle);
            y = bolt_circle_d / 2 * sin(angle);
            translate([x, y, -2])
                bolt_with_nut();
        }
    }
}

module central_connector_shaft() {
    cylinder(d=shaft_d, h=shaft_l);
}

// Assembly
module coupling() {
    translate([0, 0, 0])
        hub(); // input hub

    translate([0, 0, hub_l])
        flange_assembly(); // input flange assembly

    translate([0, 0, hub_l + flange_t * 2 + spacer_t])
        central_connector_shaft(); // central shaft

    translate([0, 0, hub_l + flange_t * 2 + spacer_t + shaft_l])
        flange_assembly(); // output flange assembly

    translate([0, 0, hub_l + flange_t * 2 + spacer_t + shaft_l + flange_t * 2 + spacer_t])
        hub(); // output hub
}

coupling();
```

