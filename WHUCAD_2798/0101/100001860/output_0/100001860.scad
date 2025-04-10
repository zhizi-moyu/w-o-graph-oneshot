
// Module for a curved wedge block (quarter cylinder segment)
module curved_wedge_block() {
    difference() {
        cylinder(r=20, h=10, $fn=100);
        translate([-20, -20, 0])
            cube([20, 20, 10]);
    }
}

// Module for a flat wedge block (triangular prism)
module flat_wedge_block() {
    polyhedron(
        points=[
            [0, 0, 0],     // 0
            [20, 0, 0],    // 1
            [0, 20, 0],    // 2
            [0, 0, 10],    // 3
            [20, 0, 10],   // 4
            [0, 20, 10]    // 5
        ],
        faces=[
            [0, 1, 2],
            [3, 5, 4],
            [0, 3, 4, 1],
            [1, 4, 5, 2],
            [2, 5, 3, 0],
            [3, 4, 5]
        ]
    );
}

// Stack the components according to the graph_dict
module full_model() {
    for (i = [0:5]) {
        translate([0, 0, i * 10])
            if (i % 2 == 0)
                curved_wedge_block();
            else
                flat_wedge_block();
    }
}

// Render the full model
full_model();

