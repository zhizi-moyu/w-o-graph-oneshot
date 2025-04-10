```scad
// Parameters
shaft_diameter = 20;
shaft_length = 40;
bore_diameter = 8;
side_hole_diameter = 5;
side_hole_offset = 10; // distance from center to side holes
side_hole_depth = shaft_diameter / 2 + 2;

// Main shaft body
difference() {
    // Outer cylinder
    cylinder(h = shaft_length, d = shaft_diameter, $fn = 100);

    // Central bore
    translate([0, 0, 0])
        cylinder(h = shaft_length, d = bore_diameter, $fn = 100);

    // Side holes (threaded holes for bolts)
    for (angle = [90, 270]) {
        rotate([0, 0, angle])
        translate([shaft_diameter/2, 0, shaft_length/2 - side_hole_offset])
            rotate([0, 90, 0])
                cylinder(h = side_hole_depth, d = side_hole_diameter, $fn = 60);
    }
}
```

