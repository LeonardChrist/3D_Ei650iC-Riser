include<BOSL2/std.scad>

$fn = 128;

wallThickness = 3;

outerDiameter = 113.95;
innerDiameter = 99.85 * 1.025;

bottomRiserHeight = 3.08;


cableThickness = 8;
innerHeight = cableThickness * 1.5;
outerHeight = innerHeight + bottomRiserHeight;

slitStrength = 3.9 * 1.3;
verticalSlitLength = 33.73;
horizontalSlitLength = 37.24;

verticalSlitOffset = 28.56;
horizontalSlitOffset = 4.34 + horizontalSlitLength / 2;

stabilizerBottomLeftAngle = 63;
stabilizerBottomLeftWidth = 11.5 * 0.95;
stabilizerBottomLeftDepth = 4.56 * 0.7;
stabilizerBottomOffset = 0.6;
stabilizerBottomLeftHeight = 5;

releasePinCutoutWidth = 14 * 1.3;
releasePinCutoutDepth = outerDiameter * 0.96;
releasePinCutoutHeight = 4;
releasePinCutoutAngle = 31;


difference()
{
    // outer cylinder
    union()
    {
        // lower
        cylinder(d = innerDiameter, h = outerHeight);

        // upper
        up(bottomRiserHeight)
            cylinder(d = outerDiameter, h = outerHeight - bottomRiserHeight);
    }

    
    // inner cutout
    up(bottomRiserHeight)
    {
        // lower
        cylinder(d = innerDiameter - wallThickness * 2, h = outerHeight);

        // upper
        up(wallThickness)
            cylinder(d = innerDiameter, h = outerHeight);
    }

    // inner cutout for cable passthrough
    cylinder(d = innerDiameter - wallThickness * 4, h = outerHeight, center = true);

    
    // cutout for release pin movement
    
    up(outerHeight - releasePinCutoutHeight / 2 + 0.01)
        zrot(releasePinCutoutAngle)
            cube([releasePinCutoutWidth, releasePinCutoutDepth, releasePinCutoutHeight], center = true);

    //up(outerHeight - bottomRiserHeight + 0.01)
    //    cylinder(d = outerDiameter - wallThickness, h = bottomRiserHeight);
}





up(bottomRiserHeight / 2)
    difference()
    {
        // support cross
        union()
        {
            
            // horizontal bar
            back(verticalSlitOffset)
                cube([verticalSlitLength + wallThickness * 6, slitStrength + wallThickness * 6, wallThickness], center = true);        

            // vertical bar
            cube([slitStrength + wallThickness * 4, innerDiameter - wallThickness, bottomRiserHeight], center = true);

        }

        // cutout middle
        cylinder(d = slitStrength, h = outerHeight, center = true);

        
        // horizontal cutout
        back(verticalSlitOffset)
            cube([verticalSlitLength, slitStrength, outerHeight], center = true);

        // vertical cutout
        fwd(horizontalSlitOffset)
            cube([slitStrength, horizontalSlitLength, outerHeight], center = true);
    }



// stabilizer pin
zrot(stabilizerBottomLeftAngle)
    up(innerHeight + stabilizerBottomLeftHeight / 2)
        fwd(outerDiameter / 2 - (outerDiameter - innerDiameter) / 2 + stabilizerBottomLeftDepth / 2 + stabilizerBottomOffset)
            cube([stabilizerBottomLeftWidth, stabilizerBottomLeftDepth, stabilizerBottomLeftHeight], center = true);