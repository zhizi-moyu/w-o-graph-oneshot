
$fn = 100;

// Parameters
shaft_d = 20;
shaft_h = 30;
flange_d = 30;
flange_h = 5;
slot_w = 6;
slot_d = 15;

sleeve_outer_d = 28;
sleeve_inner_d = 20;
sleeve_h = 20;
sleeve_flange_d = 34;
sleeve_flange_h = 4;

spacer_d = 34;
spacer_h = 4;
spacer_hole_d = 10;

hub_d = 26;
hub_h = 20;
hub_slot_w = 8;
hub_slot_d = 10;
hub_center_hole_d = 8;

// Component: Slotted End Shaft
module slotted_end_shaft() {
    difference() {
        union() {
            cylinder(h = shaft_h, d = shaft_d);
            translate([0, 0, shaft_h])
                cylinder(h = flange_h, d = flange_d);
        }
        // Slots
        translate([-slot_w/2, shaft_d/2, 0])
            cube([slot_w, shaft_d, slot_d], center = true);
        translate([-slot_w/2, -shaft_d/2 - slot_w, 0])
            cube([slot_w, shaft_d, slot_d], center = true);
        // Center hole
        translate([0, 0, shaft_h + flange_h/2])
            cylinder(h = flange_h + 1, d = hub_center_hole_d);
    }
}

// Component: Flanged Sleeve
module flanged_sleeve() {
    difference() {
        union() {
            cylinder(h = sleeve_h, d = sleeve_outer_d);
            translate([0, 0, sleeve_h])
                cylinder(h = sleeve_flange_h, d = sleeve_flange_d);
        }
        // Inner bore
        translate([0, 0, -1])
            cylinder(h = sleeve_h + sleeve_flange_h + 2, d = sleeve_inner_d);
    }
}

// Component: Central Spacer Ring
module central_spacer_ring() {
    difference() {
        cylinder(h = spacer_h, d = spacer_d);
        translate([0, 0, -1])
            cylinder(h = spacer_h + 2, d = spacer_hole_d);
    }
}

// Component: Internal Coupling Hub
module internal_coupling_hub() {
    difference() {
        cylinder(h = hub_h, d = hub_d);
        // Center hole
        translate([0, 0, -1])
            cylinder(h = hub_h + 2, d = hub_center_hole_d);
        // Opposing curved slots
        translate([-hub_d/2, -hub_slot_w/2, hub_h/4])
            cube([hub_d, hub_slot_w, hub_slot_d], center = true);
        translate([-hub_d/2, -hub_slot_w/2, 3*hub_h/4])
            cube([hub_d, hub_slot_w, hub_slot_d], center = true);
    }
}

// Assembly
module assembly() {
    translate([0, 0, 0])
        slotted_end_shaft(); // Layer 1

    translate([0, 0, shaft_h + flange_h])
        flanged_sleeve(); // Layer 2

    translate([0, 0, shaft_h + flange_h + sleeve_h + sleeve_flange_h])
        central_spacer_ring(); // Layer 3a

    translate([0, 0, shaft_h + flange_h + sleeve_h + sleeve_flange_h + spacer_h])
        internal_coupling_hub(); // Layer 3b

    translate([0, 0, shaft_h + flange_h + sleeve_h + sleeve_flange_h + spacer_h + hub_h])
        flanged_sleeve(); // Layer 4

    translate([0, 0, shaft_h + flange_h + 2*(sleeve_h + sleeve_flange_h) + spacer_h + hub_h])
        rotate([180, 0, 0])
            slotted_end_shaft(); // Layer 5
}

// Render the full assembly
assembly();


