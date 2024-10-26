module wavey(width, height, length, amplitude, periods, dl) {
    top_coords=[ for (l = [0:dl:length]) [l, height + amplitude*sin((l/length)*(periods*360.0))] ];
    bottom_coords=[ for (l = [length:-dl:0]) [l, amplitude*sin((l/length)*(periods*360.0))] ];
    coords = concat(top_coords, bottom_coords);
    
    minkowski() {
    linear_extrude(width) {
        polygon(coords);
    }
    rotate([0,90])
    cylinder(1,3,3);
    }
}
  $fn=50;
    w = 3;
    h = 3;
    d = 100;
    
    f = 3;
    a = 5;
    dt = 0.1;
    
    difference() {
    difference() {
    union() {
    wavey(w, h, d, a, f, dt);
    
    translate([0,20,0])
    wavey(w, h, d, a, f, dt);
    
    translate([0,40,0])
    wavey(w, h, d, a, f, dt);
    
    translate([0,60,0])
    wavey(w, h, d, a, f, dt);
    
    translate([0,80,0])
    wavey(w, h, d, a, f, dt);
    }
    
    translate([-10,-10,-11])
    cube([150,150,15]);
}


    translate([0,-12,0])
difference() {
    translate([-10,-10,-1])
    cube([150,150,15]);
    
    
    translate([50,50,-21])
    cylinder(50,50,50,false);
    }
    }