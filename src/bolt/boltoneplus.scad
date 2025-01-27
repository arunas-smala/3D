include <BOSL2/std.scad>
include <BOSL2/threading.scad>;


$fa = 1;
$fs = 0.5;

module thread() {
union() {
import("boltone.stl");
difference(){
cylinder(h=40, r=7.1);
cylinder(h=42, r=6);

translate([0,0,38.301])
cap();

import("bolttwo.stl");
}
}
}

module cap() {
difference() {
  threaded_rod(left_handed=true, d=13.4, l=5, pitch=1, $fa=1, $fs=1, end_len=0, blunt_start=true, internal=true, bevel=true);
  
  translate([0,0,-4.2])
  cylinder(h=4, r=8.5);
  
  translate([0,0,1.7])
  cylinder(h=3, r=8.5);
  
}
}


cap();
//thread();

