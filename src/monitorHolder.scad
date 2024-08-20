use <hinge.scad>

kompo_storis = 5;
detales_storis = 10;
eink_storis = 7;

aukstis = 120+(114/2);
plotis = 27;


kp = 345;
mp = 289;
atitraukimas = (kp-mp)/2;

$fs = 0.1;

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							sphere(r = radius);
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							rotate(a = rotate)
							cylinder(h = diameter, r = radius, center = true);
						}
					}
				}
			}
		}
	}
}

module detale() {
    difference() {
        union() {
            roundedcube([detales_storis, plotis*2,aukstis], false, 5, "x");
            cube([detales_storis, 5, aukstis]);
        }

        translate([(detales_storis-kompo_storis)/2,5,5]) {
          cube([kompo_storis,plotis*2+5,aukstis]);
        }
        
        translate([5.5, 11, 9]) {
          cube([10,plotis*2+5,aukstis]);
        }
        
        translate([5,10, aukstis])
        rotate([90,0,90])
        cylinder(20, 5, 5);
    }
    
    translate([detales_storis/2,-9,0])
    rotate([0,0,90])
    hinge(lever=10, segments=10, h=aukstis, opening_angle=110, h_gap=0.25, v_gap=0.2, start_angle=90, ds=detales_storis-5, dl=detales_storis, da=detales_storis+5);

    //rotate(7.5)
    translate([0,-18,0])
    mirror([0,1,0])
    difference() {
        
        union() {
            roundedcube([detales_storis,plotis,aukstis], false, 5, "x");
            cube([detales_storis, 5,aukstis]);
            translate([0,0,aukstis-10])
            cube([detales_storis, plotis,10]);
        }

        translate([(detales_storis-eink_storis)/2,5,5+atitraukimas]) {
          cube([eink_storis,plotis+5,aukstis]);
        }
        
    }
}

// left

detale();


// right

//translate([0,150,0])
//mirror([0,1,0])
//detale();

