include <BOSL2/std.scad>
include <BOSL2/threading.scad>

module threaded_rod_with_inverted_bevel(d=13, pitch=2, l=10) {
    difference() {
        // Create the main rod shape
        cylinder(d=d, h=l);
        // Add the top and bottom bevels
        translate([0, 0, -1])
            threaded_rod(d=d, pitch=pitch, l=1, blunt_start=false, internal=true, internal=false);
        translate([0, 0, l-1])
            threaded_rod(d=d, pitch=pitch, l=1, blunt_start=false, internal=true, internal=false);
    }
}

// Example usage
threaded_rod_with_inverted_bevel();
