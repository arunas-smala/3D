include <BOSL2/std.scad>
include <BOSL2/threading.scad>;


$fa = 1;
$fs = 0.1;

h=50;
ch=10;
d=11;
p=1.2;
ang=90;
  cr=d/2*1.2;

storis=0.8;
        
tt=0.0001;      
    ctt=0.2;  

module cap() {
  cylinder(h=ch, r=cr, center=true);
  capt();
  
  

  
}

module capt() {
  path = ellipse(r=cr+storis);
  difference() {
      translate([0,0,-ch/2])
      linear_sweep(
        path, tex_size=[1.5,1.5], tex_depth=0.4,texture="trunc_pyramids",
        h=ch, style="min_edge", anchor=BOT);
      
      cylinder(h=ch*2, r=cr, center=true);
  }
}

module rod() {
    difference() {
        union() {
            difference() {
                threaded_rod(d=d, l=h, pitch=p, starts=1, $fa=1, $fs=0.5);
                
                rotate([0,0,-0.5])
                rotate_extrude(angle=ang+1)
                translate([50,-50+h/2,0])
                square([100,100], center=true);
                
                translate([0,0,-50-h/2+tt*2])
                cylinder(h=100, r=100, center=true);
            }
            
            translate([0,0,(h+ch)/2-tt])
            cap();
        }
    
        cylinder(h=h+(ch-storis)*2, r=d/2-p/2-storis, center=true);
    }
    
}

module rod2() {
    
    difference() {
        union() {
            difference() {
                threaded_rod(d=d, l=h, pitch=p, starts=1, $fa=1, $fs=0.5);
                
                rotate([0,0,ang])
                rotate_extrude(angle=360-ang)
                translate([50+d/2-p/2-storis-ctt,0,0])
                square([100,100], center=true);
                
                translate([0,0,50+h/2-tt*2])
                cylinder(h=100, r=100, center=true);
            }
            
            cylinder(h=h+(ch-storis)*2-ctt, r=d/2-p/2-storis-ctt, center=true);
            
            translate([0,0,-(h+ch)/2+tt])
            cap();
        }

        cylinder(h=h+(ch-storis)*2, r=d/2-p/2-storis-storis-ctt, center=true);
    }
}


module nut() {
difference() {
    cylinder(h=ch/2, r=cr, center=true);
    union() {
        threaded_rod(internal=true, d=d, l=ch*2, pitch=p, starts=1, $fa=1, $fs=0.5, $slop=0.1);
        
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
capt();
    
    //translate([0,0,(h+ch)/2-tt])
    //cap();
        
    
}

//translate([50,0,0])
rod();
//rod2();
//nut();
