```scad
// Parameters
clamp_diameter = 40;
clamp_length = 20;
bore_diameter = 10;
spider_thickness = 5;
spider_lobe_radius = 6;
spider_lobe_count = 3;
keyway_width = 4;
keyway_depth = 2;

// Module: Clamp Half
module clamp_half(mirror=false) {
    difference() {
        // Main body
        cylinder(d=clamp_diameter, h=clamp_length, $fn=100);

        // Central bore
        translate([0, 0, -1])
            cylinder(d=bore_diameter, h=clamp_length + 2, $fn=100);

        // Semi-circular cutout for spider
        translate([0, 0, mirror ? 0 : clamp_length - spider_thickness])
            cylinder(d=spider_lobe_radius * 2 + 2, h=spider_thickness + 1, $fn=100);

        // Keyway slot
        translate([-keyway_width/2, clamp_diameter/2 - keyway_depth, clamp_length/2])
            rotate([90, 0, 0])
                cube([keyway_width, keyway_depth, clamp_length], center=true);

        // Interlocking profile (simple notch)
        translate([clamp_diameter/4, 0, clamp_length/2])
            rotate([0, 90, 0])
                cube([2, 6, 6], center=true);
    }
}

// Module: Central Spider
module central_spider() {
    difference() {
        // Base cylinder
        cylinder(d=clamp_diameter - 2, h=spider_thickness, $fn=100);

        // Cut out center bore
        translate([0, 0, -1])
            cylinder(d=bore_diameter, h=spider_thickness + 2, $fn=100);
    }

    // Add lobes
    for (i = [0 : 360/spider_lobe_count : 359]) {
        rotate([0, 0, i])
            translate([clamp_diameter/4, 0, 0])
                cylinder(d=spider_lobe_radius * 2, h=spider_thickness, $fn=50);
    }
}

// Assembly
module coupling_assembly() {
    // Left clamp half
    clamp_half();

    // Central spider
    translate([0, 0, clamp_length - spider_thickness])
        central_spider();

    // Right clamp half (mirrored)
    translate([0, 0, clamp_length])
        clamp_half(mirror=true);
}

// Render the full assembly
coupling_assembly();
```

