/*
    This was created by Jimmie Rodgers at the 2015 Hack in the Box in Amsterdam. My luggage wheels failed me while on tour with Mitch Altman, and I couldn't find a replacemnt. Hopefully this will be able to help others with access to a 3D printer.
    
    This is released under a public domain license. Do with it as you will.

*/

// All measurements are in mm

wheelHeight     = 64;   // The height of the wheel while on it's side.
wheelWidth      = 50;   // The total width of the wheel (diameter).
centerHole      = 7;    // The total width of the center hole (diameter).

// The chamfer is the slope along the sides of the wheel. It just looks nicer. Set both values to 0 if you do not wish to have it.
chamferedHeight = 6;    // Height of the chamfer from the edges of the wheel.
chamfer         = 6;    // Slope of the chamfer.

// Use this if you would like to have bearings in your wheel. This will make the center hole + 0.5mm larger than the bearing so the weight is largely on them.
bearing         = true; // Set to true to enable, false to disable.
bearingHeight   = 10;   // Height of the bearing.
bearingWidth    = 20;   // Total width of the bearing (diameter).
bearingHole     = 7;    // The total wideth of the center hole in the bearing (diameter).

resolution      = 1000;  // Sets how high resolution the model is. 1000 is fine for export, but can be slow on some machines if you are making lots of changes.

// This creates first the main wheel base, and then subtracts the bearings and center hole.
difference(){
    // Creates the main wheel.
    union(){
        cylinder(h = chamferedHeight, r1 = (wheelWidth-chamfer)/2, r2=wheelWidth/2, $fn=resolution); 
        translate([0,0,chamfer])
            cylinder(h = wheelHeight-(chamferedHeight*2), r=wheelWidth/2, $fn=resolution);
        translate([0,0,wheelHeight-chamfer])
            cylinder(h = chamferedHeight, r1=wheelWidth/2, r2 = (wheelWidth-chamfer)/2, $fn=resolution);
        }
        
    // If bearings are enabled this will run, else it will just create the center hole.
    if(bearing){
        union(){
            translate([0,0,-1])
                cylinder(h = wheelHeight+chamfer+2, r=bearingHole/2+0.5, $fn=resolution);
            translate([0,0,-1])
                cylinder(h = bearingHeight+1, r=bearingWidth/2, $fn=resolution);
            translate([0,0,wheelHeight-bearingHeight])
                cylinder(h = bearingHeight+1, r=bearingWidth/2, $fn=resolution);
        }
    }
    else {
        translate([0,0,-1])
            cylinder(h = wheelHeight+chamfer+2, r=centerHole/2, $fn=resolution);
    }
}