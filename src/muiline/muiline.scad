$fa = 1;
$fs = 0.5;

or=38;

module base() {
    import("files/box_base_V0.stl");
}

module diver1() {
    translate([0,0,32.5])
    linear_extrude(5)
    scale([0.6,0.6,1])
    //resize([or*1.5,or*1.5])
    translate([13,15,0])
    import("light_top.svg", center=true);
    
    
    
    translate([0,0,32.5])
    linear_extrude(5)
    scale([0.65,0.65,1])
    //resize([or*1.5,or*1.5])
    translate([-0,-34,0])
    import("light_bottom.svg", center=true);
}


module diver2() {
    translate([0,0,33.5])
    linear_extrude(5)
    scale([0.7,0.7,1])
    //resize([or*1.5,or*1.5])
    //translate([13,15,0])
    import("light_top.svg", center=true);
    
    
    
    translate([0,0,32.5])
    linear_extrude(5)
    //scale([0.65,0.65,1])
    //resize([or*1.5,or*1.5])
    //translate([-0,-34,0])
    import("light_bottom.svg", center=true);
}

module diver3() {
    translate([0,0,32.5])
    linear_extrude(5)
    scale([0.6,0.6,1])
    //resize([or*1.5,or*1.5])
    translate([0,-16.5,0])
    import("light_top.svg", center=true);
    
    
    
    translate([0,0,32.5])
    linear_extrude(5)
    scale([0.65,0.65,1])
    //resize([or*1.5,or*1.5])
    translate([-0,34,0])
    import("light_bottom.svg", center=true);
}


module body() {
    difference() {
        union() {
            translate([0,0,32.1])
            cylinder(1.9, or, or);
            // this one does not render!
            //import("files/box_lid_v0.stl");
            import("li.stl");
        }
        
        diver1();
    }
}


body();