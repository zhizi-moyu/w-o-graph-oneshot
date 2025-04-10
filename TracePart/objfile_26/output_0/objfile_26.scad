
$fn = 100; // Smoothness

module shaft_component() {
    difference() {
        union() {
            // Central wider section
            cylinder(h = 20, r1 = 8, r2 = 8, center = true);

            // Tapered transition to narrower ends
            translate([0, 0, -20])
                cylinder(h = 10, r1 = 6, r2 = 8);
            translate([0, 0, 10])
                cylinder(h = 10, r1 = 8, r2 = 6);

            // Narrow end cylinders
            translate([0, 0, -30])
                cylinder(h = 10, r = 6);
            translate([0, 0, 20])
                cylinder(h = 10, r = 6);
        }

        // Grooves on both ends (4 grooves per end)
        for (z = [-27, 27]) {
            for (angle = [0, 90, 180, 270]) {
                rotate([0, 0, angle])
                translate([6, -1, z])
                    cube([2, 2, 6], center = true);
            }
        }

        // Holes near both ends
        for (z = [-25, 25]) {
            rotate([90, 0, 0])
            translate([0, z, 0])
                cylinder(h = 12, r = 1.2, center = true);
        }
    }
}

shaft_component();

