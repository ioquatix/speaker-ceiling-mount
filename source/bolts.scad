
$radial_error = 0.1;
$fn = 4*8;

module cylinder_outer(height, radius, fn=$fn, radial_error=$radial_error) {
	fudge = 1/cos(180/fn);
	cylinder(h=height,r=radius*fudge+$radial_error, $fn=fn);
}

module cylinder_inner(height, radius, fn=$fn) {
	cylinder(h=height,r=radius-$radial_error,$fn=fn);
}

// Make a hole. The diameter is the size of the screw (e.g. 3 for M3). Depth is how far the hole should go for the thread, and inset is how far out there should be a hole for the head to go.
module hole(diameter=3, depth=6, inset=10) {
	cylinder_outer(depth, diameter/2);
	translate([0, 0, depth]) cylinder_outer(inset, diameter, 32);
}

module countersunk_hole(diameter=3, depth=6, inset=10) {
	hole(diameter, depth, inset);
	translate([0, 0, depth-diameter/2]) cylinder(r1=diameter/2+$radial_error, r2=diameter+$radial_error, h=diameter/2);
}

module threaded_countersunk_hole(diameter=3, depth=6, inset=10) {
	hole(diameter*0.9, depth, inset);
	translate([0, 0, depth-diameter/2]) cylinder(r1=diameter/2+$radial_error, r2=diameter+$radial_error, h=diameter/2);
}

module knurled_insert(diameter = 3, depth = 6, thickness = 1) {
	cylinder_inner(depth, diameter/2 + thickness);
}

module knurled_hole(diameter = 3, depth = 6, inset = 10, insert = 4, thickness = 1) {
	hole(diameter, depth, inset);
	
	knurled_insert(diameter, insert, thickness);
}

module countersunk_knurled_hole(diameter = 3, depth = 6, inset = 10, insert = 4, thickness = 1) {
	countersunk_hole(diameter, depth, inset);
	
	knurled_insert(diameter, insert, thickness);
}

// Make a hole for a bolt/screw combination.
module bolted_hole(diameter=3, depth=8, nut_offset=2, shaft_length=10, inset=10) {
	hole(diameter, depth, inset);
	hull() {
		shaft_width = diameter;
		translate([0, 0, nut_offset]) rotate(360/12, [0, 0, 1]) cylinder_outer(diameter, shaft_width, 6);
		translate([0, shaft_length, nut_offset]) rotate(360/12, [0, 0, 1]) cylinder_outer(diameter, shaft_width, 6);
	}
}

module countersunk_bolted_hole(diameter=3, depth=8, nut_offset=2, shaft_length=10, inset=10) {
	countersunk_hole(diameter, depth, inset);
	hull() {
		shaft_width = diameter;
		translate([0, 0, nut_offset]) rotate(360/12, [0, 0, 1]) cylinder_outer(diameter, shaft_width, 6);
		translate([0, shaft_length, nut_offset]) rotate(360/12, [0, 0, 1]) cylinder_outer(diameter, shaft_width, 6);
	}
}

module mounting_hole(diameter=3, depth=6, inset=10, outset=3) {
	difference() {
		cylinder_outer(depth, diameter/2+outset);
		hole(diameter=diameter, depth=depth, inset=inset);
	}
}

render() rotate(90, [1, 0, 0]) difference() {
	cube([40, 10, 10]);
	translate([5, 5, 0]) bolted_hole(diameter=3, depth=8);
	translate([15, 5, 0]) bolted_hole(diameter=4, depth=8);
	translate([25, 5, 0]) countersunk_hole(diameter=4, depth=8);
	translate([35, 5, 0]) knurled_hole();
}
