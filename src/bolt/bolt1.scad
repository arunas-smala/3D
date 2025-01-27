include <BOSL2/std.scad>
include <BOSL2/threading.scad>;


$fa = 1;
$fs = 0.1;

h=60;
ch=10;
d=11;
p=1.2;
ang=180;
  cr=d/2*1.2;

storis=0.8;
        
tt=0.001;      
    ctt=0.15;  

module cap() {
  capt(ch);
  
  

  
}

module capt(hh=h) {
  path = ellipse(r=cr+storis);
  translate([0,0,-hh/2])
  linear_sweep(
    path, tex_size=[1.5,1.5], tex_depth=0.4,texture="trunc_pyramids",
    h=hh, style="min_edge", anchor=BOT);
      
}

module ring(mask=false) {
r= mask ? d/2+0.15 : d/2;
    rotate_extrude(angle=360)
    translate([r,0,0])
    circle(mask?0.85:0.75);
}

module cyl(mask=false) {
r= mask ? d/2+0.15 : d/2;

  cylinder(h=h, r=r, center=true);
  
  translate([0,0,-5])
  ring(mask);
  
  translate([0,0,5])
  ring(mask);
  
  if (!mask) {
      translate([0,0,15])
      ring();
      
      translate([0,0,-15])
      ring();
      
      translate([0,0,25])
      ring();
      
      translate([0,0,-25])
      ring();
  }
}

module rod() {
    difference() {
        union() {
            difference() {
                //threaded_rod(d=d, l=h, pitch=p, starts=1, $fa=1, $fs=0.5);
                cyl();
                
                //rotate([0,0,-0.5])
                rotate_extrude(angle=ang+0.5)
                translate([50,-50+h/2,0])
                square([100,100], center=true);
                
                translate([0,0,-50-h/2+tt*2])
                cylinder(h=100, r=100, center=true);
            }
            
            translate([0,0,(h+ch)/2-tt])
            cap();
        }
        
        translate([0,cr+1,h/2+1-tt*10])
        cube(2,center=true);
    
        cylinder(h=h+(ch-storis)*2, r=d/2-p/2-storis, center=true);
    }
    
}

module rod2() {
    
    difference() {
        union() {
            difference() {
                //threaded_rod(d=d, l=h, pitch=p, starts=1, $fa=1, $fs=0.5);
                cyl();
                
                rotate([0,0,ang])
                rotate_extrude(angle=360-ang+0.5)
                translate([50+d/2-p/2-storis-ctt,0,0])
                square([100,100], center=true);
                
                translate([0,0,50+h/2-tt*2])
                cylinder(h=100, r=100, center=true);
                
            }
            
            difference() {
            cylinder(h=h+(ch-storis)*2-ctt, r=d/2-p/2-storis-ctt, center=true);
                // remove cap
                translate([0,0,(h+(ch-storis)*2-ctt)/2])
                cylinder(h=6, r=d/2-p/2-storis-ctt+10, center=true);
            }
            
            translate([0,0,-(h+ch)/2+tt])
            cap();
        }
        rom=d/2-p/2-storis-storis-ctt;
        hom=h+(ch-storis)*2-rom;
        translate([0,0,rom/2])
        union() {
          cylinder(h=hom, r=rom, center=true);
          translate([0,0,-hom/2])
          sphere(rom);
        }
        
        
    }
}

module cp() {
    rom=d/2-p/2-storis-storis-ctt-(ctt/2);
    hom=h+(ch-storis)*2-rom;
        
    translate([0,0,(h+(ch-storis)*2-ctt)/2-1.5]) {
        cylinder(h=3, r=d/2-p/2-storis-ctt, center=true);

        union() {
            translate([0,0,-3+tt])
          cylinder(h=5, r=rom, center=true);
          
            translate([0,0,-5.5+2*tt])
          sphere(rom);
        }
    }
}


module nut() {
nh = 19;

    difference() {
        capt(nh);
        union() {
            cyl(true);
            
            rotate([0,0,-2])
            rotate_extrude(angle=ang+4)
            translate([(d/2)+0.15-tt,0,0])
            square([1.6+tt+0.15,nh*2], center=true); 
        }
        
        
        //translate([0,0,nh/2-1.5+tt])
        //cylinder(r=(d/2)+0.15-tt+(1.6+tt+0.15)/2,h=nh+tt*20,center=true);
    }


/*
difference() {
    cylinder(h=ch/2, r=cr, center=true);
    union() {
        cyl();
        
        rotate([0,0,-2])
        rotate_extrude(angle=ang+4)
        translate([(d/2)-1,0,0])
        square([2+ctt+0.2,ch*2], center=true);        
    }
}
difference() {
cylinder(h=ch, r=cr, center=true);
cylinder(h=ch+1, r=d/2+ctt+tt, center=true);
}
*/
//capt();      
    
}

//translate([50,0,0])
//rod();
//rod2();
//cp();
nut();

