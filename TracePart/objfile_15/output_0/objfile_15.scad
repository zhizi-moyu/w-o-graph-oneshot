
$fn = 100;

// Parameters
hub_radius = 20;
hub_height = 15;
bore_radius = 5;
jaw_radius = 5;
jaw_length = 10;
jaw_thickness = 5;
bolt_radius = 2;
bolt_head_radius = 4;
bolt_length = 40;
nut_radius = 4.5;
nut_height = 3;
insert_arm_length = 10;
insert_arm_thickness = 4;
insert_radius = 5;

// Modules
module hub(is_left=true) {
    difference() {
        cylinder(h=hub_height, r=hub_radius);
        translate([0, 0, -1])
            cylinder(h=hub_height+2, r=bore_radius);
    }

    // Jaws
    for (i = [0:2]) {
        rotate([0, 0, i*120])
        translate([hub_radius - jaw_radius, 0, 0])
        if (is_left)
            translate([0, 0, hub_height - jaw_length])
                rotate([90, 0, 0])
                    cylinder(h=jaw_length, r=jaw_radius);
        else
            rotate([90, 0, 0])
                cylinder(h=jaw_length, r=jaw_radius);
    }

    // Bolt holes
    for (i = [0:2]) {
        angle = i * 120;
        x = (hub_radius - 5) * cos(angle);
        y = (hub_radius - 5) * sin(angle);
        translate([x, y, hub_height/2])
            rotate([90, 0, 0])
                cylinder(h=bolt_length, r=bolt_radius);
    }
}

module elastomer_insert() {
    union() {
        for (i = [0:5]) {
            rotate([0, 0, i*60])
            translate([insert_arm_length/2, 0, 0])
                cube([insert_arm_length, insert_arm_thickness, insert_arm_thickness], center=true);
        }
        cylinder(h=insert_arm_thickness, r=insert_radius, center=true);
    }
}

module bolt_with_nut() {
    union() {
        // Bolt shaft
        cylinder(h=bolt_length, r=bolt_radius);
        // Bolt head
        translate([0, 0, bolt_length])
            cylinder(h=3, r=bolt_head_radius);
        // Nut
        translate([0, 0, -nut_height])
            cylinder(h=nut_height, r=nut_radius);
    }
}

// Assembly
module coupling_assembly() {
    // Left hub
    translate([0, 0, hub_height + insert_arm_thickness])
        hub(true);

    // Elastomer insert
    translate([0, 0, hub_height])
        elastomer_insert();

    // Right hub
    hub(false);

    // Bolts and nuts
    for (i = [0:2]) {
        angle = i * 120;
        x = (hub_radius - 5) * cos(angle);
        y = (hub_radius - 5) * sin(angle);
        translate([x, y, 0])
            rotate([90, 0, angle])
                bolt_with_nut();
    }
}

coupling_assembly();

