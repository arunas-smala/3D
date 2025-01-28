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
    
smauka=5;   

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

cr=mask?0.85:0.75;

    translate([0,0,-5])
    rotate_extrude(angle=360)
    translate([r-0.1,0,0])
    union() {
        circle(cr);
        
        //translate([0,0,0])
        //square([cr,10],center=false);
        
        translate([0,10,0])
        circle(cr);
    }
}

module cyl(mask=false) {
r= mask ? d/2+0.25 : d/2;

  cylinder(h=h, r=r, center=true);
  
  if (h==40) {
  translate([0,0,-10])
  ring(mask);
  
  translate([0,0,10])
  ring(mask);
  } else {
  translate([0,0,0])
  ring(mask);
  
  translate([0,0,-20])
  ring(mask);
  
  translate([0,0,20])
  ring(mask);
  }
  
}

module female(h=nh*2) {
  cylinder(h=h, r=cr+storis-0.5, center=true);
}

module male(h=nh) {
cylinder(h=h, r=cr+storis-0.6, center=true);
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
            
            difference() {
                translate([0,0,(h+ch)/2-smauka])
                cap();
                
                th=smauka*2;
                
                translate([0,0,(h+ch)/2-smauka-ch/2-th/2+smauka+tt])
                female(th);
            }
        }
        
        translate([0,-(cr+1),h/2-tt*10-smauka+ch-1])
        cube(2,center=true);
    
        cylinder(h=h+(ch-storis-smauka)*2, r=d/2-p/2-storis, center=true);
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
            cylinder(h=h+(ch-storis-smauka)*2-ctt*2, r=d/2-p/2-storis-ctt, center=true);
                // remove cap
                //translate([0,0,(h+(ch-storis)*2-ctt)/2])
                //cylinder(h=6, r=d/2-p/2-storis-ctt+10, center=true);
            }
            
            translate([0,0,-(h+ch)/2+tt])
            union() {
                th=smauka*(h==40?5:2);
                
                translate([0,0,ch/2-th/2])
                male(th);
                
                translate([0,0,-smauka-(h==40?20:0)])
                cap();
            }
        }
        rom=d/2-p/2-storis-storis-ctt;
        hom=h+(ch-storis+smauka)*2-rom;
        translate([0,0,rom/2])
        union() {
          cylinder(h=hom, r=rom, center=true);
          translate([0,0,-hom/2])
          sphere(rom);
        }
        
        
    }
}

module cp() {
    rom=d/2-p/2-storis-storis-ctt;
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

module t(t="1") {
RADIUS = cr+storis;
            rotate([0,0,-90])
          translate( [RADIUS-0.15,0,0])
            rotate([90,180,90])
              linear_extrude(1)
                text(t,valign="center",halign="center", size=5);
}


module nut(stext = [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" ]) {
nh = 20-tt;

ARC_ANGLE=360;

chars = len( stext );


difference() {
    union() {
        translate([0,0,5])
        difference() {
            capt(nh);
            //

            for(i=[0:1:chars]){
                rotate([0,0,i*ARC_ANGLE/chars])
                t(stext[chars-i]);
            }
        }
        
        male(nh);
    }
    
    translate([0,0,nh*1.5])
    female(nh*2);

    union() {
        cyl(true);

        rotate([0,0,-2])
        rotate_extrude(angle=ang+4)
        translate([(d/2)+0.05-tt,0,0])
        square([1.6+tt+0.15,nh*2], center=true); 
    }
    
        translate([0,-cr-0.5, -nh/2+2.5])
        cube(2,center=true);


    //translate([0,0,0])
    //cylinder(r=(d/2)+0.15-tt+(1.6+tt+0.0)/2,h=nh+tt*20,center=true);
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
rod2();
//cp();

/*
nut(stext = [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" ]);

translate([20,0,0])
nut(stext = [ "8", "9", "0", "1", "2", "3", "4", "5", "6", "7" ]);

translate([20,20,0])
nut(stext = [ "9", "0", "1", "2", "3", "4", "5", "6", "7", "8" ]);
*/

