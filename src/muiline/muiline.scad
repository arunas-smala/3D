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


module kid1() {
    translate([0,0,33.5])
    linear_extrude(5)
    scale([0.7,0.7,1])
    //resize([or*1.5,or*1.5])
    translate([-0,-20,0])
    import("kid.svg", center=true);
}


module body() {

    path = path3d(arc(100, r=70, angle=[ 465, 145]));
    path2 = path3d(arc(100, r=59, angle=[ 465, 145]));
    
    
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
        
        kid1();
        
        th=5;
    translate([-5,-47.0,33.5+th/2])
path_text(path, "lauktuvių!", font="Chivo Mono:style=Bold", size=8, h=th, lettersize=7/1.25, normal=UP);


    translate([-2,-27.3,33.5+th/2])
path_text(path2, "nepamiršk", font="Chivo Mono:style=Bold", size=4, h=th, lettersize=4/1.2, normal=UP);



    path3 = path3d(arc(100, r=50, angle=[ 210, 465]));
    path4 = path3d(arc(100, r=60, angle=[ 210, 465]));

    translate([6.5,33.5,33.5+th/2])
path_text(path3, "geros", font="Chivo Mono:style=Bold", size=4, h=th, lettersize=4/1.2, normal=UP);

    translate([14,32,33.5+th/2])
path_text(path4, "koman-", font="Chivo Mono:style=Bold", size=4, h=th, lettersize=4/1.2, normal=UP);
    translate([14,24.5,33.5+th/2])
path_text(path4, "diruotės", font="Chivo Mono:style=Bold", size=4, h=th, lettersize=4/1.2, normal=UP);



    path5 = path3d(arc(100, r=40, angle=[ 285, 465]));
    path6 = path3d(arc(100, r=50, angle=[ 275, 465]));
    path6a = path3d(arc(100, r=50, angle=[ 265, 465]));
    
    translate([11,23,33.5+th/2])
path_text(path5, "Joris", font="Chivo Mono:style=Bold", size=4.5, h=th, lettersize=4.5/1.2, normal=UP);

    translate([17,30,33.5+th/2])
path_text(path6, "2024", font="Chivo Mono:style=Bold", size=4, h=th, lettersize=4/1.2, normal=UP);
    translate([24,27,33.5+th/2])
path_text(path6a, "11-11", font="Chivo Mono:style=Bold", size=3, h=th, lettersize=3/1.2, normal=UP);

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
