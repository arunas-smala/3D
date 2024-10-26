$fa = 1;
$fs = 0.5;

d=88;
h=100;
w=2;
p=0.5;
lip=15;

bx=178;
bz=80;


module pan() {
difference(){
union() {
difference(){
    cylinder(h, d, d);
    
    translate([0,0,-w]) cylinder(h+10, d-w, d-w);
}

translate([d-w/2,0,0])
cube([lip,w*2,h]);
}



translate([d-w-lip/2,w-p/2,-h/2])
cube([lip*2,p,h*2]);
}
}


module diving() {
import(file="diving3.svg", center=true);
}

module decor() {

translate([0,0,0])
linear_extrude(5)
diving();

handle=10;

translate([-48,0,4.9])
cube([15,2,handle]);

translate([-6,0,4.9])
cube([25,2,handle]);

translate([38,0,4.9])
cube([12,2,handle]);

//  translate([-75, -19, 0])
//cube([150,38,10], center=false);
}

module clip() {
difference(){
cube([lip,w*4,h/2]);

translate([-w,w,-h/4])
cube([lip,w*2,h]);
}
}

module boxPlata() {
difference() {
translate([0,0,bz/2])
  cube([bx, bx, bz], true);
  
  translate([0,0,5])
    cylinder(h, d+10, d+20);
    }
}

pan();
//clip();
boxPlata();
//decor();
