include <BOSL2/std.scad>
include <BOSL2/threading.scad>;

/**
 * Lock container generator
 *      
 * Author: Arūnas Smaliukas
 * Version: 1.0
 *
 * Description:
 *
 * Features:
 * - Supports xxx
 *
 * License:
 * This script is shared under the CC BY-NC-SA 4.0 license:  
 * https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 * Changelog:
 */

/* [🔒 Lock] */

// Select what to display.
Display = "top"; // [all: All parts, top: Top end, bottom: Bottom container, lockDials: Lock dials, containerDials: Container dials, straw: Straw, funnel: Funnel]

// Diameter of the lock without texture (in mm).
Diameter = 15; // [10:1:200]

// Diameter of the lock without texture (in mm).
Texture_Depth = 0.4; // [0:0.1:2]

// Height of the end caps (in mm).
Cap_Height = 10; // [5:1:200]

// Height of the dial (in mm).
Dial_Height = 20; // [5:1:200]

// Count of dials on the lock.
Lock_Dials_Count = 2; // [1:1:5]

// Count of dials on the container.
Container_Dials_Count = 1; // [1:1:5]

/* [📷 Render] */

// Additional spacing for 3D printing fit (in mm).
Clearance = 0.1; // [0:0.01:0.25]

// Thickness of the thinnest wall (in mm).
Thinnest_Wall = 0.4; // [0.1:0.01:0.25]

// Render resolution to control detail level.
Resolution = 3; // [4: Ultra, 3: High, 2: Medium, 1: Low]

// Rounding
Rounding = 0.5; // [0:0.1:1]

// Color of the model.
Color = "#e2dede"; // color

// Determine face angle and size based on resolution
face = (Resolution == 4) ? [1, 0.1]
    : (Resolution == 3) ? [2, 0.15]
    : (Resolution == 2) ? [2, 0.2]
    : [4, 0.4];

$fa = face[0];
$fs = face[1];

/* [Hidden] */
strapOverlap=3;
lockCoreOverlap=2;

Overlap=(Dial_Height > Cap_Height 
? Cap_Height - Thinnest_Wall 
: Dial_Height - Thinnest_Wall)-strapOverlap-lockCoreOverlap;

// Diameters of each "layer"
wTexture=Thinnest_Wall;
dTexture=Diameter;
dTexture2=dTexture-wTexture*2;

wDial=2;
dDial=dTexture2-Clearance*2;
dDial2=dDial-wDial*2;

wLock=1;
dLock=dDial2-Clearance*2;
dLock2=dLock-wLock*2;


// Modules
module lockCore(overlap, strapOverlap=strapOverlap) {
  attach(TOP, overlap=-overlap) 
    tag("remove") {
      right_half(x=-Clearance/2) 
        cyl(d=dLock+Clearance, l=lockCoreOverlap+overlap, anchor=TOP);
      cyl(d=dLock2, l=strapOverlap+overlap, anchor=TOP);
    }

  attach(TOP, overlap=overlap) 
    tag("keep") {
      lockHeight = Lock_Dials_Count * Dial_Height + overlap;
      left_half(x=-Clearance/2, s=lockHeight*2+0.1) {
        tube(od=dLock, id=dLock2, h=lockHeight, anchor=BOT);

        up(overlap)
          for (i = [0 : Lock_Dials_Count - 1]) {
            up(i * Dial_Height + Dial_Height / 4)
              torus(r_maj=dLock/2, r_min=1/2);
            up(i * Dial_Height + Dial_Height*3/4)
              torus(r_maj=dLock/2, r_min=1/2);
          }
      }

    }
}

module texture(h) {
  linear_sweep(
      ellipse(d=dTexture), tex_size=[1.5,1.5], tex_depth=Texture_Depth, texture="trunc_pyramids",
      h=h, style="min_edge", anchor=BOT)
    children();
}

module generateTop() {
  overlap = 0.1;
  diff()
    texture(Cap_Height) {
      attach(TOP, overlap=-overlap) 
        tag("remove") 
        cyl(d=dTexture2, l=Overlap+overlap, anchor=TOP);

      down(Overlap)
        lockCore(overlap);
    }
}

module generateBottom() {
  overlap = 0.1;
  dialHeight = Dial_Height*Container_Dials_Count+Overlap;
  strapOverlap=5;

  difference() {
    texture(Cap_Height) {
      attach(TOP, overlap=overlap) 
        diff()
        cyl(d=dDial, l=dialHeight+overlap, anchor=BOT) {
          lockCore(overlap, dialHeight/2);
        }
    }

dContainer = dDial-Thinnest_Wall*2;
lContainer = Cap_Height+dialHeight-Thinnest_Wall-strapOverlap;

up(Thinnest_Wall)
  cyl(d=dContainer, l=lContainer,
      rounding1=dContainer/4,rounding2=dContainer/2,
      anchor=BOT);
  }
}

module generateLockDials() {
    for (i = [0:Lock_Dials_Count - 1]) {
        translate([0, 0, i * Dial_Height]) {
            cylinder(10);
        }
    }
}

module generateContainerDials() {
    for (i = [0:Container_Dials_Count - 1]) {
        translate([0, 0, i * Dial_Height]) {
            cylinder(10);
        }
    }
}

module generateStraw() {
    cylinder(10);
}

module generateFunnel() {
    cylinder(10);
}

// Render
color(Color) {
    if (Display == "top") {
        generateTop();
    } else if (Display == "bottom") {
        generateBottom();
    } else if (Display == "lockDials") {
        generateLockDials();
    } else if (Display == "containerDials") {
        generateContainerDials();
    } else if (Display == "straw") {
        generateStraw();
    } else if (Display == "funnel") {
        generateFunnel();
    } else {
        xdistribute(spacing = Diameter * 2) {
          generateTop();
          generateBottom();
          generateLockDials();
          generateContainerDials();
          generateStraw();
          generateFunnel();
        }
    }
}
