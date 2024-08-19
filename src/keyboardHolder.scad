pc_depth = 10;
pc_width = 300;
pc_height = 150;

wall = 5;
lip = 30;

module full() {
    difference() {
        cube([pc_width+wall*2, pc_height+wall*2, pc_depth+wall*2]);
        
        
        translate([2, 2, wall*2+pc_depth-1])
        cube([pc_width+wall*2-4, pc_height+wall*2-4, 20]);
        
        translate([4, 4, wall+pc_depth-2])
        cube([pc_width+wall*2-8, pc_height+wall*2-8, 5]);
        
        translate([wall, -wall/2, wall])
        cube([pc_width, pc_height+(wall*3), pc_depth]);

       
        translate([wall+lip, -wall/2, -0.01])
        cube([pc_width-lip*2, pc_height+(wall*3), wall+0.2]);

    }
}

// left
difference() {
    full();
    
    translate([pc_width/2+wall,-50,-50])
    cube([pc_width/2+wall+50, pc_height+wall*2+100, 100]);
}

/*
// right
difference() {
    full();
    
    translate([-50,-50,-50])
    cube([pc_width/2+wall+50, pc_height+wall*2+100, 100]);
}
*/

