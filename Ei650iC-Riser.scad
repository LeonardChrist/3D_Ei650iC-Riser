include<BOSL2/std.scad>

$fn = 128;

wallThickness = 3;

outerDiameter = 113.95;
innerDiameter = 99.85;

bottomRiserHeight = 3.08;


cableThickness = 8;
innerHeight = cableThickness * 1.5;
outerHeight = innerHeight + bottomRiserHeight;

slitStrength = 3.9;
verticalSlitLength = 33.73;
horizontalSlitLength = 37.24;

verticalSlitOffset = 28.56;
horizontalSlitOffset = 4.34 + horizontalSlitLength / 2;

stabilizerBottomLeftAngle = 57;
stabilizerBottomLeftWidth = 11.5 * 0.8;
stabilizerBottomLeftDepth = 4.56 * 0.8;


difference()
{
    union()
    {
        cylinder(d = innerDiameter, h = outerHeight);

        up(bottomRiserHeight)
            cylinder(d = outerDiameter, h = outerHeight - bottomRiserHeight);
    }

    up(bottomRiserHeight)
    {
        cylinder(d = innerDiameter - wallThickness * 2, h = outerHeight * 2);

        up(wallThickness)
            cylinder(d = innerDiameter, h = outerHeight);
    }

    
    up(outerHeight - bottomRiserHeight + 0.01)
        cylinder(d = outerDiameter - wallThickness, h = bottomRiserHeight);


    cylinder(d = innerDiameter - wallThickness * 4, h = outerHeight, center = true);
}

up(bottomRiserHeight / 2)
    difference()
    {
        union()
        {
            back(verticalSlitOffset)
                cube([verticalSlitLength + wallThickness * 6, slitStrength + wallThickness * 6, wallThickness], center = true);        

                    
            cube([slitStrength + wallThickness * 4, innerDiameter - wallThickness, bottomRiserHeight], center = true);

        }

        
        back(verticalSlitOffset)
            cube([verticalSlitLength, slitStrength, outerHeight], center = true);


        fwd(horizontalSlitOffset)
            cube([slitStrength, horizontalSlitLength, outerHeight], center = true);
    }



zrot(stabilizerBottomLeftAngle)
    up(innerHeight)
        fwd(outerDiameter / 2 - (outerDiameter - innerDiameter) / 2 + stabilizerBottomLeftDepth / 2)
            cube([stabilizerBottomLeftWidth, stabilizerBottomLeftDepth, bottomRiserHeight], center = true);