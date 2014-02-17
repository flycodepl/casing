
//kołek pod śruby
module stdScrewStandoff(screw_diameter,depth,height)
{
  screw_radius=screw_diameter/2;
  difference()
  {
    //materiał
    cylinder(h=height,r=screw_radius+2);

    //dziura
    translate([0,0,height-depth])
      cylinder(h=depth+1,r=screw_radius);
  }
}
// 4 kołki pod pcb
module stdPcbMounting4x(screw_diameter,size,height)
{
  //dla każdego rogu płytki:
  for(i=[0,1])
    for(j=[0,1])
      translate([i*size[0],j*size[1]])
      {
        //kołek
        stdScrewStandoff(screw_diameter,height,height);
      }
}

// 2 kołki pod pcb
module stdPcbMounting2x(screw_diameter,size,height)
{
  //dla każdego rogu płytki:
  for(i=[0,1])
    translate([i*size,0])
    {
      //kołek
      stdScrewStandoff(screw_diameter,height,height);
    }
}