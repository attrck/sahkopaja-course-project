totalHeight = 40;
widerR = 6;
transitionHeight = 2;
totalWidth = 50;
narrowR = 4.5;
narrowHeight = 30;
widerHeight = totalHeight - narrowHeight - transitionHeight;
hitterHeight = 15;
screwHoleRadius = 3.3;
screwHoleHeight = 35;
otherHoleRadius = 1.5;

difference() {
	pipesAndBar();
	differenceShape();
	translate([0,-(totalWidth - narrowR) / 2,narrowHeight / 2 + transitionHeight + widerHeight - screwHoleHeight / 2]) screw();
	translate([0,0,-4.5]) rotate([0,90,0]) cylinder(h = 2 * narrowR + 2, r=otherHoleRadius, center=true, $fn = 80);
		translate([0,(totalWidth - narrowR) / 2,narrowHeight / 2 + transitionHeight + widerHeight - screwHoleHeight / 2]) screw();
}

module screw() {
	cylinder(h = screwHoleHeight, r=screwHoleRadius, center=true, $fn = 80);
}

module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}

module bar() {
	cylinder(h = narrowHeight, r=narrowR, center=true, $fn = 80);
	translate([0, 0, narrowHeight / 2 + transitionHeight / 2]) cylinder(h = transitionHeight, r1=narrowR, r2= widerR, center=true, $fn = 0);
	translate([0,0,narrowHeight / 2 + transitionHeight + widerHeight / 2]) cylinder(h = widerHeight, r=widerR, center=true, $fn = 80);
}

module pipesAndBar() {
	translate([0,(totalWidth - narrowR) / 2,0]) bar();
	translate([0,-(totalWidth - narrowR) / 2,0]) bar();
	translate([0, 0, -narrowHeight / 2 + hitterHeight / 2]) cube([2 * narrowR, totalWidth - narrowR, hitterHeight], center=true) bar();
}

module differenceShape() {
	squareWidth = 2 * narrowR + 2;
	extrudeHeight = totalWidth + 6;
	translate([0,extrudeHeight / 2,-narrowR * 2 - narrowR + 3]) rotate([90, 180, 0]) linear_extrude(height = extrudeHeight) difference() {

		translate([-squareWidth / 2,0]) square([squareWidth, narrowR + 2]);
		circle(narrowR, $fn = 120);
	}
}
