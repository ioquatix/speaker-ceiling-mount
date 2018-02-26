
use <bolts.scad>;
use <zcube.scad>;

module base(size = [40, 80, 40], angle = 5) {
	difference() {
		zcube(size, z=-size[2]/3);
		
		rotate(angle, [1, 0, 0]) {
			translate([0, 0, -size[2]]) scale([2, 2, 1]) zcube(size);
			translate([0, 0, 10]) zcube([size[0], 45, 18], z=-10);
			rotate([90, 0, 0]) translate([0, 9, -size[1]/2-12]) #countersunk_hole(5, size[1]+10);
		}
		
		translate([size[0]/4, -size[1]/3.2, size[2]-1]) rotate([170, 0, 0]) #countersunk_hole(5, size[2]);
		translate([-size[0]/4, -size[1]/3.2, size[2]-1]) rotate([170, 0, 0]) #countersunk_hole(5, size[2]);
		
		translate([size[0]/4, size[1]/4.5, size[2]+3]) rotate([200, 0, 0]) #countersunk_hole(5, size[2]);
		translate([-size[0]/4, size[1]/4.5, size[2]+3]) rotate([200, 0, 0]) #countersunk_hole(5, size[2]);
		
		translate([0, 0, 60]) rotate([180, 0, 0]) #countersunk_hole(5, size[2]);
	}
}

rotate([180, 0, 0]) base();
