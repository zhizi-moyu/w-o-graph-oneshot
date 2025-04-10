```scad
$fn = 100;

// Parameters
hub_diameter = 30;
hub_height = 15;
bore_diameter = 8;
slot_width = 4;
slot_depth = 10;
pin_diameter = 4;
pin_length = hub_diameter + 2;
set_screw_diameter = 3;
set_screw_depth = 5;
jaw_thickness = 10;
finger_count = 6;
finger_length = 5;
finger_width = 4;

// Modules
module input_hub() {
    difference() {
        cylinder(h = hub_height, d = hub_diameter);
        // Bore
        cylinder(h = hub_height + 1, d = bore_diameter);
        // Set screw hole
        translate([hub_diameter/2 - 2, 0, hub_height/2])
            rotate([0,90,0])
            cylinder(h = set_screw_depth, d = set_screw_diameter);
        // Curved slots
        for (i = [0:180:180]) {
            rotate([0,0,i])
            translate([0, -hub_diameter/4, hub_height/2 - slot_width/2])
                cube([slot_depth, slot_width, slot_width], center=true);
        }
    }
}

module output_hub() {
    translate([0, 0, -(hub_height + jaw_thickness)]) {
        input_hub();
    }
}

module jaw_element() {
    translate([0, 0, -hub_height]) {
        difference() {
            cylinder(h = jaw_thickness, d = hub_diameter - 2);
            // Central bore
            cylinder(h = jaw_thickness + 1, d = bore_diameter);
        }
        // Flexible fingers
        for (i = [0:360/finger_count:360-360/finger_count]) {
            rotate([0,0,i])
            translate([hub_diameter/4, -finger_width/2, -hub_height])
                cube([finger_length, finger_width, jaw_thickness]);
        }
    }
}

module pin(pos_z) {
    translate([0, 0, pos_z])
        rotate([0,90,0])
        cylinder(h = pin_length, d = pin_diameter, center=true);
}

module set_screw(pos_z) {
    translate([hub_diameter/2 - 2, 0, pos_z])
        rotate([0,90,0])
        cylinder(h = set_screw_depth, d = set_screw_diameter);
}

// Assembly
union() {
    input_hub();
    output_hub();
    jaw_element();
    pin(hub_height/2);
    pin(-hub_height - jaw_thickness + hub_height/2);
    set_screw(hub_height/2);
    set_screw(-hub_height - jaw_thickness + hub_height/2);
}
```

