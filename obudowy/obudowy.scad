// Użyj pudełek z mcada do zaokrągleń
include<MCAD/boxes.scad>
include <MCAD/regular_shapes.scad>

//definicje
stdScrewDiameter=3;


//wycięcie pod śruby+łby
module stdScrewCutWithPhase(screw_diameter,height)
{
  screw_radius=screw_diameter/2;
  //otwór na śrubę
  cylinder(h=height,r=screw_radius*1.1);
  //faza
  cylinder(h=screw_radius,r2=screw_radius*1.1,r1=screw_radius*2);
  //duży cylinder nad razą - żeby wyciąć
  translate([0,0,-1])
    cylinder(h=1.01,r=screw_radius*2);
}

//wycięcie pod ekran
module stdScreenCutout(pos,size)
{
  if(size[0] > size[1])
  {    
  translate([pos[0]+(size[0]/2),pos[1]+(size[1]/2),0])
    square_pyramid(size[0],size[1],size[1]);
  }  
  else
  {
  translate([pos[0]+(size[0]/2),pos[1]+(size[1]/2),0])
    square_pyramid(size[0],size[1],size[0]);
  }

}

// standardowe pudełko, częśc dolna
// size - wymiary, wektor [l,w,h]
// thickness - grubość ścianek
module stdBox(size,thickness)
{
  inner_cutout = size-[thickness*2,thickness*2,0];
  standoff_height=size[2]-thickness;

  //pudełko
  difference()
  {
    //baza dla pudełka
    cube(size);

    //wytnij środek
    translate([thickness,thickness,thickness])
      cube(inner_cutout);
  }

  //mocowanie - x4 śruby
  for(i=[0,1])
    for(j=[0,1])
    {
      translate([stdScrewDiameter*2+i*(size[0]-stdScrewDiameter*4),stdScrewDiameter*2+j*(size[1]-stdScrewDiameter*4),thickness])
        stdScrewStandoff(stdScrewDiameter,standoff_height-2,standoff_height);
    }

  //wzmocnienia
}

// standardowe pudełko, częśc gorna (klapka)
// size - wymiary, wektor [l,w,h]
// thickness - grubość ścianek
module stdCover(size,thickness)
{
  inner_cutout = size-[thickness*2,thickness*2,0];
  standoff_height=size[2]-thickness;
  //klapka
  difference()
  {
    //baza dla pudełka
    cube(size);

    //wytnij środek    
    translate([thickness,thickness,thickness])
      cube(inner_cutout);

      //wytnij otwory pod 4 śruby
    for(i=[0,1])
      for(j=[0,1])
        translate([stdScrewDiameter*2+i*(size[0]-stdScrewDiameter*4),stdScrewDiameter*2+j*(size[1]-stdScrewDiameter*4),0])
          stdScrewCutWithPhase(stdScrewDiameter,10);

  }
}

// pudełko z zaokrąglonymi rogami, częśc dolna
// size - wymiary, wektor [l,w,h]
// thickness - grubość ścianek
// radius - promień zaokrąglenia
module roundEdgesBox(size,thickness,radius)
{
  // aby zaokrąglenie uwzględniało pokrywkę
  //robię pudełko wyższe o thickness a potem obcinam o thickness od góry
  outer_size = size + [0,0,thickness];
  inner_cutout = outer_size-[thickness*2,thickness*2,0];
  standoff_height=size[2]-thickness;

  difference()
  {
    //baza dla pudełka
    translate(outer_size/2)
      roundedBox(outer_size,radius);

    //wytnij środek
    translate([thickness,thickness,thickness])
      translate(inner_cutout/2)
        roundedBox(inner_cutout,radius);

    //przytnij górę
    translate([-1,-1,size[2]])
      cube(size+[2,2,2]);
  }

  //mocowanie - x4 śruby
  for(i=[0,1])
    for(j=[0,1])
      translate([stdScrewRadius*2+i*(size[0]-stdScrewRadius*4),stdScrewRadius*2+j*(size[1]-stdScrewRadius*4),thickness])
        stdScrewStandoff(stdScrewRadius,standoff_height-2,standoff_height); 
}