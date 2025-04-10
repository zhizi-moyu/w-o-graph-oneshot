```scad
$fn = 100; // Smoothness

// Parameters
hub_d = 30;
hub_l = 30;
bore_d = 10;
keyway_w = 4;
keyway_d = 2;

flange_d = 50;
flange_t = 5;
bolt_hole_d = 4;
bolt_circle_d = 40;

spacer_t = 2;
spacer_wave_amp = 1;
spacer_wave_freq = 6;

bolt_d = 4;
bolt_l = 40;
nut_d = 7;
nut_h = 4;

// Modules
module shaft_hub() {
    difference() {
        cylinder(d=hub_d, h=hub_l);
        translate([0, 0, -1])
            cylinder(d=bore_d, h=hub_l + 2);
        translate([-keyway_w/2, hub_d/2 - keyway_d, hub_l/2])
            cube([keyway_w, keyway_d, hub_l], center=true);
    }
}

module flange_plate() {
    difference() {
        cylinder(d=flange_d, h=flange_t);
        translate([0, 0, -1])
            cylinder(d=bore_d, h=flange_t + 2);
        for (i = [0 : 360/6 : 360 - 360/6]) {
            angle = i;
            x = bolt_circle_d/2 * cos(angle);
            y = bolt_circle_d/2 * sin(angle);
            translate([x, y, -1])
                cylinder(d=bolt_hole_d, h=flange_t + 2);
        }
    }
}

module spacer_ring() {
    // Wavy ring approximation
    rotate_extrude(angle=360)
        translate([bolt_circle_d/2 + spacer_wave_amp * sin(spacer_wave_freq * 0), 0])
            offset(r=spacer_wave_amp)
                square([spacer_t, 0.1], center=true);
}

module bolt() {
    union() {
        cylinder(d=bolt_d, h=bolt_l);
        translate([0, 0, bolt_l])
            cylinder(d=bolt_d * 1.5, h=2); // hex head
    }
}

module nut() {
    cylinder(d=nut_d, h=nut_h);
}

// Assembly
module coupling() {
    translate([0, 0, 0]) shaft_hub(); // input hub
    translate([0, 0, hub_l]) flange_plate(); // flange 1
    translate([0, 0, hub_l + flange_t]) spacer_ring(); // spacer 1
    translate([0, 0, hub_l + flange_t + spacer_t]) flange_plate(); // flange 2
    translate([0, 0, hub_l + 2*flange_t + spacer_t]) flange_plate(); // flange 3
    translate([0, 0, hub_l + 3*flange_t + spacer_t]) spacer_ring(); // spacer 2
    translate([0, 0, hub_l + 3*flange_t + 2*spacer_t]) flange_plate(); // flange 4
    translate([0, 0, hub_l + 4*flange_t + 2*spacer_t]) shaft_hub(); // output hub

    // Bolts and nuts
    for (i = [0 : 360/6 : 360 - 360/6]) {
        angle = i;
        x = bolt_circle_d/2 * cos(angle);
        y = bolt_circle_d/2 * sin(angle);
        translate([x, y, hub_l])
            bolt();
        translate([x, y, hub_l + bolt_l])
            nut();
    }
}

coupling();
```

