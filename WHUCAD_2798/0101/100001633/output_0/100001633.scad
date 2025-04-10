
// Parameters
tabletop_length = 100;
tabletop_width = 60;
tabletop_thickness = 5;

leg_diameter = 4;
leg_height = 60;

side_bar_diameter = 2.5;
side_bar_length = 90;

bottom_bar_diameter = 2.5;
bottom_bar_length = 50;

leg_offset_x = 5;
leg_offset_y = 5;

// Modules
module tabletop() {
    cube([tabletop_length, tabletop_width, tabletop_thickness], center = false);
}

module table_leg() {
    cylinder(h = leg_height, d = leg_diameter, center = false);
}

module side_support_bar() {
    rotate([0, 90, 0])
        cylinder(h = side_bar_length, d = side_bar_diameter, center = false);
}

module bottom_support_bar() {
    rotate([0, 90, 90])
        cylinder(h = bottom_bar_length, d = bottom_bar_diameter, center = false);
}

// Assembly
translate([0, 0, leg_height])
    tabletop();

// Legs
translate([leg_offset_x, leg_offset_y, 0])
    table_leg();

translate([tabletop_length - leg_offset_x - leg_diameter, leg_offset_y, 0])
    table_leg();

translate([leg_offset_x, tabletop_width - leg_offset_y - leg_diameter, 0])
    table_leg();

translate([tabletop_length - leg_offset_x - leg_diameter, tabletop_width - leg_offset_y - leg_diameter, 0])
    table_leg();

// Side support bars (long sides)
translate([leg_offset_x + leg_diameter / 2, leg_offset_y + leg_diameter / 2, 20])
    side_support_bar();

translate([leg_offset_x + leg_diameter / 2, tabletop_width - leg_offset_y - leg_diameter / 2, 20])
    side_support_bar();

// Bottom support bar (short side)
translate([tabletop_length / 2 - bottom_bar_length / 2, leg_offset_y + leg_diameter / 2, 5])
    bottom_support_bar();

