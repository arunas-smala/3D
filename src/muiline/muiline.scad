include <BOSL2/std.scad>

$fa = 1;
$fs = 0.5;

or=38;

module base() {
    import("files/box_base_V0.stl");
    
translate([0,or,-or+3])
stick();
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
translate([0,0,34])
rotate([180,0,0])
    difference() {
        union() {
            // this one does not render!
            //import("files/box_lid_v0.stl");
            import("li.stl");
            translate([0,0,32.1])
            cylinder(1.9, or, or);
        }
        
        diver3();
    }
    
translate([0,or,-or+3])
stick();
}
module textur() {
//tex = texture("trunc_diamonds",border=.25);
//tex = texture("trunc_pyramids_vnf", border=.4);
tex = texture("checkers",border=0.25);
linear_sweep(
    rect(or*2), texture=tex, h=or*2,
    tex_size=[10,10]
);
}

module stick() {



intersection() {
rotate([90,0,0])
import("textur.stl");
translate([0,-or,or-1])
cylinder(h=10, r=or-3);
}
}

//base();

body();
