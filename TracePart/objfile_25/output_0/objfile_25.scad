```scad
$fn = 100; // Smoothness

// Parameters
body_length = 60;
body_radius = 10;
bulge_radius = 12;
bulge_length = 10;
slot_width = 1;
slot_depth = 2;
screw_radius = 1.5;
screw_length = 10;
screw_offset = 25;

// Main assembly
module flexible_coupling() {
    union() {
        central_body();
        clamping_screw( screw_offset);
        clamping_screw(-screw_offset);
    }
}

// Central body with bulge and slots
module central_body() {
    difference() {
        union() {
            // Left and right cylindrical sections
            translate([0, 0, -body_length/2 + bulge_length/2])
                cylinder(h = (body_length - bulge_length)/2, r = body_radius);
            translate([0, 0, body_length/2 - bulge_length/2])
                cylinder(h = (body_length - bulge_length)/2, r = body_radius);

            // Central bulge
            translate([0, 0, -bulge_length/2])
                cylinder(h = bulge_length, r = bulge_radius);
        }

        // Straight slots
        for (i = [-1, 0, 1]) {
            translate([-body_radius, 0, i * 10])
                cube([2 * body_radius, slot_width, slot_depth], center = true);
        }

        // Helical slots (approximated with rotated straight cuts)
        for (i = [0 : 3]) {
            rotate([0, 0, i * 90])
                translate([0, 0, -body_length/2])
                    linear_extrude(height = body_length)
                        offset(r = 0.5)
                            polygon(points=[[body_radius-1, -slot_width/2], [body_radius+1, -slot_width/2], [body_radius+1, slot_width/2], [body_radius-1, slot_width/2]]);
        }

        // Clamping screw holes
        translate([0, body_radius - 2, screw_offset])
            rotate([90, 0, 0])
                cylinder(h = 2 * body_radius, r = screw_radius, center = true);
        translate([0, body_radius - 2, -screw_offset])
            rotate([90, 0, 0])
                cylinder(h = 2 * body_radius, r = screw_radius, center = true);

        // Shaft clamping slit
        translate([0, 0, -body_length/2])
            rotate([0, 0, 0])
                cube([slot_width, 2 * body_radius, body_length], center = true);
    }
}

// Clamping screw
module clamping_screw(z_pos) {
    translate([0, body_radius - 2, z_pos])
        rotate([90, 0, 0])
            cylinder(h = screw_length, r = screw_radius);
}

// Render the model
flexible_coupling();
```

