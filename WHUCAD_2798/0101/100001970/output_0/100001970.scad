
// Parameters
large_diameter = 40;
large_height = 30;

small_diameter = 20;
small_height = 10;

recess_diameter = 30;
recess_depth = 5;

// Main body (large cylinder)
module large_cylinder() {
    cylinder(d=large_diameter, h=large_height);
}

// Small shaft (bottom cylinder)
module small_cylinder() {
    translate([0, 0, -small_height])
        cylinder(d=small_diameter, h=small_height);
}

// Recessed groove in the bottom of the large cylinder
module recessed_groove() {
    translate([0, 0, -recess_depth])
        cylinder(d=recess_diameter, h=recess_depth);
}

// Full stepped cylinder shaft
module stepped_cylinder_shaft() {
    difference() {
        union() {
            large_cylinder();
            small_cylinder();
        }
        recessed_groove();
    }
}

// Render the model
stepped_cylinder_shaft();

