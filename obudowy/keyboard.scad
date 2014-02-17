//klawisze

//Blblioteka do tesktu
include <Write/Write.scad>

//definicje
key_ar=1.5; //aspect ratio owalnego klawisza

//standardowy okrągły klawisz
module stdKey(height,radius,text="A")
{

  translate([0,0,1])
  {
    difference()
    {
      //klawisz
      cylinder(h=height,r=radius);
      
      //tekst na klawiszu
      translate([0,0,height])
        write(text,h=radius,center=true,t=1);
    }
  }
  
  //spód
  cylinder(h=1,r=radius+2);
}

//strzałka
module stdArrowKey(height,radius)
{

  translate([0,0,1])
  {
    difference()
    {
      //klawisz
      oval_prism(height=height,rx=radius,ry=radius*key_ar);
      
      //strzałka na klawiszu
      translate([0,0,height])
      {
        cube([radius*key_ar,1,1],center=true);
        translate([radius*key_ar/2+sqrt(2)/2,0,-0.5])
          rotate([0,0,135])
            cube([radius*key_ar/2,1,1],center=false);
        translate([radius*key_ar/2,++sqrt(2)/2,-0.5])
          rotate([0,0,-135])
            cube([radius*key_ar/2,1,1],center=false);
      }
    }    
  }
  
  //spód
  oval_prism(height=1,rx=radius+2,ry=radius*key_ar+2);
}

//podstawowa klawiatura : klawisze strzałek + OK i ANULUJ
module stdKeyb()
{
  //strzałki
  for(i=[0:3])
    rotate([0,0,90*i])
      translate([15,0,0])
        stdArrowKey(height=6,radius=4.75);

  //ok
  translate([40,15,0])
    stdKey(height=6,radius=9.75,text="OK");
  //cancel
  translate([40,-15,0])
    stdKey(height=6,radius=9.75,text="C");
}

//wycięcie pod klawiaturę
module stdKeybCutout(pos)
{
  translate(pos)
    rotate([0,180,0])
    {
      //strzałki
      for(i=[0:3])
        rotate([0,0,90*i])
          translate([15,0,0])
            stdArrowKey(height=6,radius=5);

      //ok
      translate([40,15,0])
        stdKey(height=6,radius=10,text="OK");
      //cancel
      translate([40,-15,0])
        stdKey(height=6,radius=10,text="C");
    }
}