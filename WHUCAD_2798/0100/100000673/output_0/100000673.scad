
// Parameters
thickness = 2; // consistent thickness of the key
bevel = 0.3;   // optional bevel amount (not implemented in this simple version)

// 2D profile of the key insert
module key_insert_profile() {
    polygon(points=[
        [0, 0],         // Start at the rounded end
        [2, 0],         // Right side of the rounded end
        [2.5, 0.5],     // Curve transition
        [3, 1.5],       // Mid body
        [4, 3],         // Tapered point
        [3, 3.5],       // Top edge
        [1.5, 3.8],     // Left top edge
        [0.5, 2.5],     // Left mid
        [0, 1.5],       // Back to start
        [-0.5, 0.5]     // Rounded protrusion
    ]);
}

// 3D model
module key_insert() {
    linear_extrude(height=thickness)
        key_insert_profile();
}

// Render the key insert
key_insert();

