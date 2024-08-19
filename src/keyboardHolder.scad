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
        
        translate([wall, -wall/2, wall])
        cube([pc_width, pc_height+(wall*3), pc_depth]);

       
        translate([wall+lip, -wall/2, -0.01])
        cube([pc_width-lip*2, pc_height+(wall*3), wall+0.2]);

    }

    
}

// left
full();


