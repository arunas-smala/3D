
shoulder = 0.2;
h_gap=0.25;
layer_height=0.15;
v_gap_layers=1;
v_gap=layer_height*v_gap_layers;
height=14;

ds=3;
dl=4;
da=6;

start_angle=0;
opening_angle=90;
lever=20;

segments=1;

t1="";
t2="";

$fs=0.1;
$fa=1;
eps=0.001;
cut = false;

detales_storis = 10;

    hinge(lever=10, segments=2, h=28, opening_angle=90, h_gap=0.25, v_gap=0.2, start_angle=45, ds=detales_storis-1, dl=detales_storis, da=detales_storis+2);

module hinge(da=6, dl=4, ds=3, h=14, segments=1, lever=20, start_angle=0, opening_angle=90, shoulder=0.2, h_gap=0.25, v_gap=0.2) {
  for (a=[1:segments]) {
    h_offset=(a-1)*h/segments;
    translate([0,0,h_offset])
    hinge_segment(da, dl, ds, h/segments, lever, start_angle, opening_angle,shoulder, h_gap, v_gap);
  }
}
module hinge_segment(da, dl, ds, h, lever, start_angle, opening_angle,shoulder, h_gap, v_gap) {
  pin(dl=dl, ds=ds, h=h, shoulder, 0, 0);
  rotate([0,0,start_angle]){
    pin_connector_flat(ds, h, lever);
    pin_connector_cone(da, dl, ds, h, h_gap);
    leave(da, dl, h, lever, h_gap);
  }
  knuckle(da, dl, ds, h, lever, start_angle, opening_angle, shoulder, h_gap, v_gap);
}



module knuckle (da, dl, ds, h, lever, start_angle, opening_angle, shoulder, h_gap, v_gap) {
  difference(){
    union(){
      difference(){
        union(){
          cylinder(d=da,h=h+eps);
          rotate([0,0,-90])
          translate([-dl/2,0,0])
          cube([dl,lever,h+eps]);
        }
        rotate([0,0,start_angle]){
          union(){
            knuckle_gap_flat(ds, h, h_gap, v_gap);
            for (a = [30:30:opening_angle]) {
              rotate([0,0,a])
              knuckle_gap_flat(ds, h, h_gap, v_gap);
            }
            rotate([0,0,opening_angle])
            knuckle_gap_flat(ds, h, h_gap, v_gap);
          };
        }
      }
    segment_h=h/3.5;
    translate([0,0,segment_h*0.75+v_gap])
    cylinder(d1=dl+2*h_gap, d2=da, h=segment_h/4);
    translate([0,0,segment_h*2.5-v_gap])
    cylinder(d1=da, d2=dl+2*h_gap, h=segment_h/4);
    }
    pin(dl, ds, h, shoulder, h_gap, v_gap);
  }
}

module knuckle_gap_flat (ds, h, h_gap, v_gap) {
segment_h=h/3.5;
translate([-(ds+h_gap)/2,0,-eps])
cube([ds+h_gap, 3*ds,segment_h+v_gap+eps]);
translate([-(ds+h_gap)/2,0,2.5*segment_h-v_gap])
cube([ds+h_gap, 3*ds,segment_h+v_gap+2*eps]);
}

module pin_connector_flat (ds, h, lever) {
  segment_h=h/3.5;
  translate([-ds/2,0,0])
  cube([ds, lever,segment_h/2]);
  translate([-ds/2,0,3*segment_h])
  cube([ds, lever,segment_h/2]);
}

module pin_connector_cone (da, dl, ds, h, h_gap) {
  segment_h=h/3.5;
  translate([0,0,segment_h/2-eps])
  intersection(){
    translate([-(ds)/2,0,0])
    cube([ds, 3*ds,segment_h/2]);
    cylinder(d1=da, d2=dl+h_gap, h=segment_h/4);
  }
  translate([0,0,2.75*segment_h+eps])
  intersection(){
    translate([-(ds)/2,0,0])
    cube([ds, 3*ds,segment_h/2]);
    cylinder(d2=da, d1=dl+h_gap, h=segment_h/4);
  }
}

module leave (da, dl, height, lever, h_gap) {
  difference(){
    translate([-dl/2,0,0])
    cube([dl,lever,height]);
    translate([0,0,-eps])
    cylinder(d=da+h_gap, h=height+2*eps);
  }
}

module pin (dl, ds, h, shoulder, h_gap, v_gap) {
  segment_h=h/3.5;
  local_eps = v_gap > 0 ? eps : 0;
  union(){
    translate([0,0,-local_eps])
    cylinder(d=dl+shoulder+h_gap, h=segment_h*0.75+v_gap+2*local_eps);
    translate([0,0,0.75*segment_h+v_gap])
    cylinder(d1=dl+h_gap, d2=ds+h_gap, h=segment_h-v_gap+eps);
    translate([0,0,1.75*segment_h])
    cylinder(d1=ds+h_gap, d2=dl+h_gap, h=segment_h-v_gap);
    translate([0,0,2.75*segment_h-v_gap-local_eps])
    cylinder(d=dl+shoulder+h_gap, h=1.5*segment_h/2+v_gap+eps+2*local_eps);
  }
}