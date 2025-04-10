
// Parameters
bolt_length = 30;
bolt_radius = 4;
head_height = 6;
head_radius = 6;
hex_radius = 3; // across flats
hex_depth = 3;

// Main bolt body
module bolt_body() {
    cylinder(h = bolt_length, r = bolt_radius, $fn=100);
}

// Bolt head with hex socket
module bolt_head() {
    difference() {
        cylinder(h = head_height, r = head_radius, $fn=100);
        translate([0, 0, head_height - hex_depth])
            rotate([0, 0, 0])
                hex_socket(hex_radius, hex_depth);
    }
}

// Hex socket (recessed)
module hex_socket(radius, depth) {
    rotate([0, 0, 0])
        cylinder(h = depth, r=radius / cos(180/6), $fn=6);
}

// Chamfered bottom
module chamfered_tip() {
    translate([0, 0, -2])
        cylinder(h = 2, r1 = 0, r2 = bolt_radius, $fn=100);
}

// Full bolt
module bolt() {
    union() {
        bolt_body();
        translate([0, 0, bolt_length])
            bolt_head();
        chamfered_tip();
    }
}

// Render the bolt
bolt();

