```scad
$fn = 100; // Smoothness

// Parameters
outer_diameter = 60;
inner_diameter = 40;
sleeve_length = 60;
hub_diameter = 38;
hub_length = 30;
gear_depth = 5;
end_cap_thickness = 5;
end_cap_diameter = 65;
shaft_hole_diameter = 10;
bolt_hole_diameter = 4;
bolt_circle_diameter = 50;
bolt_count = 6;

// Main Assembly
module flexible_coupling() {
    // Layer 1: Top End Cap
    translate([0, 0, sleeve_length + end_cap_thickness])
        end_cap();

    // Layer 2: Outer Sleeve and Inner Hub
    outer_sleeve();
    translate([0, 0, (sleeve_length - hub_length) / 2])
        inner_hub();

    // Layer 3: Bottom End Cap
    translate([0, 0, 0])
        end_cap();
}

// Outer Sleeve
module outer_sleeve() {
    difference() {
        cylinder(h = sleeve_length, d = outer_diameter);
        translate([0, 0, gear_depth])
            cylinder(h = sleeve_length - 2 * gear_depth, d = inner_diameter);
        // Simulated internal gear teeth
        for (i = [0 : 20]) {
            angle = i * 360 / 20;
            rotate([0, 0, angle])
                translate([inner_diameter / 2 - 1, 0, gear_depth])
                    cube([2, 2, sleeve_length - 2 * gear_depth], center = false);
        }
    }
}

// Inner Hub
module inner_hub() {
    difference() {
        cylinder(h = hub_length, d = hub_diameter);
        cylinder(h = hub_length, d = shaft_hole_diameter);
    }
    // Simulated external gear teeth
    for (i = [0 : 20]) {
        angle = i * 360 / 20;
        rotate([0, 0, angle])
            translate([hub_diameter / 2, 0, 0])
                cube([2, 2, hub_length], center = false);
    }
}

// End Cap
module end_cap() {
    difference() {
        cylinder(h = end_cap_thickness, d = end_cap_diameter);
        // Central shaft hole
        cylinder(h = end_cap_thickness + 1, d = shaft_hole_diameter);
        // Bolt holes
        for (i = [0 : bolt_count - 1]) {
            angle = i * 360 / bolt_count;
            rotate([0, 0, angle])
                translate([bolt_circle_diameter / 2, 0, 0])
                    cylinder(h = end_cap_thickness + 1, d = bolt_hole_diameter);
        }
    }
}

// Render the full model
flexible_coupling();
```

