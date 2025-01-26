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
    
    
        th=5;
    path3 = path3d(arc(100, r=50, angle=[ 215, 465]));
  
  rotate([0,0,-48])
    translate([12.4,-13.5,32.5])
    linear_extrude(th)
text("UGNE", font="Chivo Mono:style=Normal", size=5);

    translate([11.3,-25.8,32.5])
rotate([0,0,-48])
cube([0.9,1.1,th]);

}


module kid1() {
    translate([0,0,33.5])
    linear_extrude(5)
    scale([0.7,0.7,1])
    //resize([or*1.5,or*1.5])
    translate([-0,-20,0])
    import("kid.svg", center=true);
    
    path = path3d(arc(100, r=70, angle=[ 465, 145]));
    path2 = path3d(arc(100, r=59, angle=[ 465, 145]));
    
    
        th=5;
    translate([-5.2,-45.5,33.5+th/2])
path_text(path, "lauktuvių!", font="Chivo Mono:style=Bold", size=6.5, h=th, lettersize=6.5/1.2, normal=UP);


    translate([-2,-27.3,33.5+th/2])
path_text(path2, "nepamiršk", font="Chivo Mono:style=Bold", size=4.5, h=th, lettersize=4.5/1.2, normal=UP);


    path3 = path3d(arc(100, r=50, angle=[ 210, 465]));
    path4 = path3d(arc(100, r=60, angle=[ 230, 465]));
  path4a = path3d(arc(100, r=60, angle=[ 240, 465]));

    translate([5.6,28.5,33.5+th/2])
path_text(path3, "geros", font="Chivo Mono:style=Bold", size=4.5, h=th, lettersize=4.5/1.2, normal=UP);

    translate([0.69,39,33.5+th/2])
path_text(path4, "koman-", font="Chivo Mono:style=Bold", size=4, h=th, lettersize=4/1.2, normal=UP);
    translate([-5.9,37.5,33.5+th/2])
path_text(path4a, "diruotės", font="Chivo Mono:style=Bold", size=4, h=th, lettersize=4/1.2, normal=UP);



    path5 = path3d(arc(100, r=50, angle=[ 275, 465]));
    path6 = path3d(arc(100, r=60, angle=[ 270, 465]));
    path6a = path3d(arc(100, r=60, angle=[ 265, 465]));
    
    translate([11.0,31.3,33.5+th/2])
path_text(path5, "su Šv.", font="Chivo Mono:style=Bold", size=4.5, h=th, lettersize=4.5/1.2, normal=UP);

    translate([11.5,37,33.5+th/2])
path_text(path6, "Kalėdom", font="Chivo Mono:style=Bold", size=3.8, h=th, lettersize=3.8/1.2, normal=UP);
    /*
    translate([24.7,35.0,33.5+th/2])
path_text(path6a, "2024", font="Chivo Mono:style=Bold", size=3.6, h=th, lettersize=3.6/1.2, normal=UP);*/

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
        
        // translate([0,0,-1])
        // kid1();
      diver3();

    }
    

 
translate([0,or,-or+3])
stick();
}

module body_text() {
RADIUS=40.35;
ARC_ANGLE=65;
stext = [ "U", "G", "N", "Ė" ];
chars = len( stext );

translate([0,0,18])
rotate([0,180,-92+ARC_ANGLE/2])
for(i=[0:1:chars]){
  rotate([0,0,i*ARC_ANGLE/chars]){
    translate( [RADIUS*.95,0,0])
      rotate([90,0,90])
        linear_extrude(2)
          text(stext[i],size=10,valign="bottom",halign="left", font="Arial:style=bold");
    }
  }

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

//difference() {
body();
//body_text();
//}
