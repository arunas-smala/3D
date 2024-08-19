kompo_storis = 5;
detales_storis = 10;
eink_storis = 7;

aukstis = 90;

difference() {
    cube([detales_storis,30,aukstis]);

    translate([(detales_storis-kompo_storis)/2,5,5]) {
      cube([kompo_storis,35,aukstis]);
    }
    
    translate([5.5,7.5,7.5]) {
      cube([5,35,aukstis]);
    }
}

rotate(15)
mirror([0,1,0])
difference() {
    cube([detales_storis,30,aukstis]);

    translate([(detales_storis-eink_storis)/2,5,5]) {
      cube([eink_storis,35,aukstis]);
    }
    
    translate([5.5,12.5,12.5]) {
      cube([5,35,aukstis]);
    }
}