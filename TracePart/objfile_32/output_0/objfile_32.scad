```scad
$fn=100;

// Parameters
clamp_d = 20;
clamp_h = 10;
bore_d = 5;
screw_d = 3;
screw_l = 8;
screw_offset = 6;
slit_w = 0.5;

flex_d = 20;
flex_h = 20;
slot_w = 2;
slot_d = 5;
slot_count = 6;

// Modules
module clamp_end() {
    difference() {
        cylinder(d=clamp_d, h=clamp_h);
        // Bore
        translate([0,0,-1])
            cylinder(d=bore_d, h=clamp_h+2);
        // Screw holes
        for (angle = [45, -45]) {
            translate([screw_offset*cos(angle), screw_offset*sin(angle), clamp_h/2])
                rotate([90,0,0])
                    cylinder(d=screw_d, h=clamp_d);
        }
        // Slit
        translate([-clamp_d/2, -slit_w/2, 0])
            cube([clamp_d, slit_w, clamp_h]);
    }
}

module screw() {
    union() {
        cylinder(d=screw_d, h=screw_l);
        translate([0,0,screw_l])
            cylinder(d1=screw_d*1.2, d2=screw_d, h=1);
    }
}

module helical_flex_body() {
    difference() {
        cylinder(d=flex_d, h=flex_h);
        for (i = [0:slot_count-1]) {
            rotate([0,0,i*360/slot_count])
                translate([0, -flex_d/2, i*flex_h/slot_count])
                    cube([flex_d, slot_w, slot_d], center=false);
        }
    }
}

// Assembly
module coupling() {
    // Left clamp
    clamp_end();
    // Left screws
    for (angle = [45, -45]) {
        translate([screw_offset*cos(angle), screw_offset*sin(angle), 0])
            rotate([90,0,0])
                screw();
    }

    // Helical body
    translate([0,0,clamp_h])
        helical_flex_body();

    // Right clamp
    translate([0,0,clamp_h+flex_h])
        rotate([180,0,0])
            clamp_end();

    // Right screws
    for (angle = [45, -45]) {
        translate([screw_offset*cos(angle), screw_offset*sin(angle), clamp_h*2+flex_h])
            rotate([90,0,0])
                screw();
    }
}

// Render the full coupling
coupling();
```

