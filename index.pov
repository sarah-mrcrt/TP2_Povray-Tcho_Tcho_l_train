/** @file index.pov
* Travaux pratiques d'infographie
* @author Alexandre Lavaud & Sarah Mauriaucourt
* @date 29/12/2020 - 29/01/2021
* + moi
* Structuration des scripts
*/
                      
                      
//********************************* Réglages *******************************
#version 3.7;  
global_settings { assumed_gamma 2.0 }
#default { finish { ambient 0.1 diffuse 0.9 conserve_energy } }  
//********************************* Directives ****************************
#include "colors.inc"
#include "transforms.inc"
#include "textures.inc"
#include "shapes.inc"
#include "woods.inc"
#include "glass.inc"
#include "stars.inc"
#include "stones.inc" 
                        
                        
//********************************* Scène *********************************  
//********************************* Environnement technique 
// Caméra // 

camera 
{     
    right x * image_width/image_height
    up y
    location <60,3,-20>
    look_at<18,0,6>
    angle 30   
}     


/*
//vue dans wagon
camera
{     
    right x * image_width/image_height
    up y
    location <2,4,2>
    look_at<10,0,2>
    angle 70   
}
*/
 

// Lumières // 
 
// Lumière de type soleil       

light_source {
    <200, 200, -200>
    color White
} 


//Spot interieur wagon
#declare SpotIntWagon = union 
{
    light_source{ <3.5,3.8,2> color Turquoise   
              spotlight
              point_at<3.5,0,2>
              tightness 10
              falloff 40
            }    
            
    light_source{ <7.5,3.8,2> color Turquoise   
              spotlight
              point_at<7.5,0,2>
              tightness 10
              falloff 40
            }            
}
                      
                      
// AXES X Y Z //


cylinder { //X
    <0,0,0>, <100,0,0>, 0.01
    pigment { Red }
    finish { ambient 1 }
}
cylinder { //Y
    <0,0,0>, <0,100,0>, 0.01
    pigment { Green }
    finish { ambient 1 }
}
cylinder { //Z
    <0,0,0>, <0,0,100>, 0.01
    pigment { Blue }
    finish { ambient 1 }
}               


//********************************* Conception de la scène
//**** 1 - Modelisation (formes, materiaux) // 
/* Forme géométrique */   

// Rails //
#declare Traverse = box
{
    <0, 0, 0>,
    < 2.3, .15, .25>
    texture {
      DMFDarkOak
      scale .1
      rotate <0, 90, 0>
    }
}
  
/*  
#declare Traverses = union
{
    object { Traverse }
    object { Traverse translate <0,0,1>}
}   
*/

// Rail
#declare Fer = prism
{
    bezier_spline
    linear_sweep
    0, 2, 4*13,
    <0,0>, <0,0>, <0,1>, <0,1>,
    <0,1>, <2,1>, <5.4,1.4>, <5,2>,
    <5,2>, <5,2>, <5,9>, <5,9>,
    <5,9>, <4.2,9>, <3,9.8>, <3,11>,
    <3,11>, <2.88,11.6>, <2.92,12.6>, <3,13>,
    <3,13>, <3.4,13.4>, <5.2,14>, <7,14>,
    <7,14>, <8.8,14>, <10.6,13.4>, <11,13>,
    <11,13>, <11.12,12.4>, <11.08,11.4>, <11,11>,
    <11,11>, <11,9.8>, <9.8,9>, <9,9>,
    <9,9>, <9,9>, <9,2>, <9,2>,
    <9,2>, <9,1.4>, <11.6,1>, <14,1>,
    <14,1>, <14,1>, <14,0>, <14,0>,
    <14,0>, <14,0>, <0,0>, <0,0>

    rotate <-90,0,0>

    pigment{ color DarkBrown }
}       
#declare Rail = union
{
    object { Traverse }
    object { Fer translate <0,0,1>}
}         

  
  
// ARBRES //              
//Sapin         
#declare SapinFeuilles = cone {<0,0,0>1.5, <0,3.5,0>0.2 }
#declare SapinTronc = cylinder { <0,0,0>, <0,3,0>0.5 }
//Acacia         
#declare AcaciaFeuilles = sphere
{   
    <0,0,0>2
} 
#declare AcaciaTronc = cylinder { <0,0,0>, <0,3.5,0>0.3 }
       
  
       
//TRAIN//
//WagonConducteur    
#declare ParoisConducteur = prism
{
    bezier_spline
    linear_sweep
    0, 4, 4*9,
    <0.8,0>, <0.32,0>, <0,0.48>, <0,0.8>,
    <0,0.8>, <0,0.8>, <0,3.2>, <0,3.2>, 
    <0,3.2>, <0,3.68>, <0.48,4>, <0.8,4>, 
    <0.8,4>, <0.8,4>, <10.6,4>, <10.6,4>, 
    <10.6,4>, <11.2,4>, <11.6,3.72>, <11.8,3.53>, 
    <11.8,3.53>, <11.96,3.4>, <12.57,2.78>, <13.13,2.15>,
    <13.13,2.15>, <13.6,1.66>, <13.88,1.02>, <13.85,0.8>,
    <13.85,0.8>, <13.81,0.51>, <13.25,0.04>, <12.5,0>, 
    <12.5,0>, <12.5,0>, <0.8,0>, <0.8,0>
}         

//Wagon     
#declare Parois = prism
{
    bezier_spline
    linear_sweep
    0, 4, 4*8,
    <0.8,0>, <0.32,0>, <0,0.48>, <0,0.8>,
    <0,0.8>, <0,0.8>, <0,3.2>, <0,3.2>, 
    <0,3.2>, <0,3.68>, <0.48,4>, <0.8,4>, 
    <0.8,4>, <0.8,4>, <9.2,4>, <9.2,4>,  
    <9.2,4>, <9.68,4>, <10,3.52>, <10,3.2>, 
    <10,3.2>, <10,3.2>, <10,0.8>, <10,0.8>,
    <10,0.8>, <10,0.32>, <9.52,0>, <9.2,0>,    
    <9.2,0>, <9.2,0>, <0.8,0>, <0.8,0>  
}   
       
//Fenetre Wagon
#declare Encadrement = box { <0,0,0>, <3,3,0.15> } 
#declare Vitre = box { <0,0,0>, <2.8,2.8,0.1> } 
 
//AttacheWagon  
#declare AttacheWagon = Supercone (<0.0,0.0,0.0>, 0.4, 0.6, <0.0,1,0.0>, 0.6, 0.4)

//Roues
#declare Chassis = box { <0,0,0>, <7,0.5,0.25> } 
#declare Essieu = cone{ <0,0,0>,0.25,<0,0.20,0>,0.125 }
#declare IntRoue = cylinder{ <0,0,0>,<0,0.3,0>,0.4 } 
#declare Rayon = box { <0,0,0>, <0.7,0.32,0.1> }
#declare TourRoue = cylinder{ <0,0,0>,<0,0.25,0>,0.6 }
 
 
 
/* Matériaux (création des textures) */ 
 
#declare SoucheArbre =  material 
{
    texture
    {
        pigment { color rgb< 0.75, 0.5, 0.30>*0.25}
        normal { bumps 2 scale<0.025,0.075,0.025>}
        finish { phong 0.003 }
    }     
} 
 
#declare Feuilles_Texture_1 = material {
    texture
    {
        pigment { color rgbf<0.2,0.5,0, 0.1>*0.75 }
        normal { bumps 0.5 scale 0.5 }
        finish { phong_size 0.003 }
    }     
}
        
#declare Feuilles_Texture_2 = material {
    texture
    {
        pigment{ color rgbf<0.2,0.5,0, 0.1>*0.75}
        normal { bumps 0.5 scale 0.5 }
        finish { phong_size 0.003 }
    }    
} 

#declare BoisRouge =  material 
{
    texture 
    {
        pigment{ color Red } 
        normal { bumps 0.1 scale <0.015,0.01,0.015> rotate <0,0,90>} 
        finish { phong 0.2 phong_size 0.3 } 
    }
}     

#declare BoisBleu =  material 
{
    texture 
    {
        pigment{ color Blue } 
        normal { bumps 0.25 scale <0.015,0.08,0.015>} 
        finish { phong 0.2 phong_size 0.3 } 
    }
}  

#declare BoisJaune =  material 
{
    texture 
    {
        pigment{ color Yellow } 
        normal { bumps 0.15  scale <0.015,0.08,0.015> rotate <0,0,90>} 
        finish { phong 0.2 phong_size 0.3 } 
    }
} 
#declare BoisNoir =  material 
{
    texture 
    {
        pigment{ color Black } 
        normal { bumps 0.15  scale <0.015,0.08,0.015> rotate <0,0,90>} 
        finish { phong 0.2 phong_size 0.3 } 
    }
} 
#declare BoisBlanc =  material 
{
    texture 
    {
        pigment{ color White } 
        normal { bumps 0.15  scale <0.015,0.08,0.015> rotate <0,0,90>} 
        finish { phong 0.2 phong_size 0.3 } 
    }
} 

#declare BoisGris =  material 
{
    texture 
    {
        pigment{ color Grey } 
        normal { bumps 0.15  scale <0.015,0.08,0.015> rotate <0,0,90>} 
        finish { phong 0.2 phong_size 0.3 } 
    }
} 
 
#declare VerreMinerale = material
{
    texture { T_Glass3 }
}            
                        
#declare BlancNeige = material 
{ 
    texture 
    { 
        pigment { color White*1.1 } 
        finish { ambient 1} 
    }
}     
 
#declare Lightning = material 
{ 
    texture
    { 
    Lightning1  
    finish { phong 3 } 
    scale 40 
    rotate <0,0,95> 
    } 
}

          
                          
                          
//**** 2 - Habillage (On met les textures sur les formes et matériaux créés) //
// Sapin
#declare SapinFeuilles_Texture = object { SapinFeuilles material { Feuilles_Texture_1 }  }
#declare SapinTronc_SoucheArbre = object { SapinTronc material { SoucheArbre }  } 
// Acacia
#declare AcaciaFeuilles_Texture = object { AcaciaFeuilles material { Feuilles_Texture_2 }  }
#declare AcaciaTronc_SoucheArbre = object { AcaciaTronc material { SoucheArbre }  }            
// Fênetre
#declare Encadrement_White = object { Encadrement material { BlancNeige } } 
#declare Vitre_Verre = object { Vitre material { VerreMinerale } } 
#declare Vitre_Verre2 = object { Vitre material { Lightning } }
//Train
#declare ParoisRouge = object { Parois material { BoisRouge } }
#declare ParoisConducteurRouge = object { ParoisConducteur material { BoisRouge } }
#declare AttacheWagonBleu = object { AttacheWagon material { BoisBleu } }                        
#declare ChassisJaune = object { Chassis material { BoisJaune } }                        
//Roues du train
#declare EssieuBlanc = object { Essieu material { BoisBlanc } }                        
#declare IntRoueGris = object { IntRoue material { BoisGris } } 
#declare RayonBlanc = object { Rayon material { BlancNeige } } 
#declare TourRoueNoir = object { TourRoue material { BoisNoir } } 

                        
//**** 3 - Assemblage // 
#declare Sapin = union
{
    object { SapinFeuilles_Texture translate <0,3.7,0> }
    object { SapinFeuilles_Texture translate <0,2.5,0> scale 1.1 } 
    object { SapinFeuilles_Texture translate <0,1.5,0> scale 1.2 }    
    object { SapinTronc_SoucheArbre }
}

#declare Acacia = union
{
    object { AcaciaFeuilles_Texture translate <0,4,0> }    
    object { AcaciaTronc_SoucheArbre }
}

//Roues  
#declare IntRoueRayon = union {
    object { IntRoueGris } 
    object { RayonBlanc translate <-0.35,0,-0.05>} 
    object { RayonBlanc translate <-0.35,0,-0.05> rotate 90}   
}

#declare Roue = union 
{
    object { EssieuBlanc }
    object { IntRoueRayon translate <0,0.2,0>}
    object { TourRoueNoir translate <0,0.2,0>} 
    rotate <0,0,-90>
}

#declare Roues = union
{  
#for (Nr, 0, 2, 1) 

    object{ Roue translate< 0, 0, Nr*2.5 >} 

#end 
rotate <0,90,0> 
translate <1,0,0>
}  
//Roues sur chassis
#declare RouesChassis = union
{
    object { Roues translate <0,0.25,0>}
    object { ChassisJaune }
}

// Fenetres wagon
# declare FenetreWagon = union
{    
    difference 
    { 
        object { Encadrement_White } 
        object { Vitre_Verre translate <0.1,0.1,-0.025> } 
        object { Vitre_Verre translate <0.1,0.1,0.08> }
    }    
    object { Vitre_Verre  translate <0.1,0.1,0.025> } 
    scale <0.6,0.6,0>   
}  
// Fenetre conducteur
# declare FenetreWagonConducteur = union
{    
    difference 
    { 
        object { Encadrement_White } 
        object { Vitre_Verre2 translate <0.1,0.1,-0.025> } 
        object { Vitre_Verre2 translate <0.1,0.1,0.08> }
    }    
    object { Vitre_Verre2  translate <0.1,0.1,0.025> } 
    scale <0.6,0.6,0>   
}
      
//Parois WagonConducteur  
#declare ParoisConducteur = union 
{
    object { ParoisConducteurRouge rotate <-90,0,0> translate <0,0,4> }
    light_source { SpotIntWagon translate <3,0,0>}  
    object { AttacheWagonBleu scale<.5,.5,.7> rotate<0,0,90> translate<0,1,2> }
}  
     
//Parois du Wagon     
#declare ParoisWagon = union 
{
    object { ParoisRouge rotate <-90,0,0> translate <0,0,4> }
    light_source { SpotIntWagon }
    object { AttacheWagonBleu scale<.5,.5,.7> rotate<0,0,90> translate<0,1,2> } 
    object { AttacheWagonBleu scale<.5,.5,.7> rotate<0,0,-90> translate<10,1,2> }
}
//Wagons
#declare Wagon = difference 
{
     object { ParoisWagon } 
     object { FenetreWagon translate <1,1.5,-0.07>}
     object { FenetreWagon translate <1,1.5,3.93>} 
     object { FenetreWagon translate <4.15,1.5,-0.07>}
     object { FenetreWagon translate <4.15,1.5,3.93>}
     object { FenetreWagon translate <7.2,1.5,-0.07>}
     object { FenetreWagon translate <7.2,1.5,3.93>}
     object { FenetreWagon rotate <0,90,0> translate <-0.07,1.5,2.9>}
     object { FenetreWagon rotate <0,90,0> translate <9.93,1.5,2.9>}
     translate <1,0.5,0>
}

#declare WagonConducteur = difference 
{
     object { ParoisConducteur } 
     object { FenetreWagon translate <0.8,1.5,-0.07>}
     object { FenetreWagon translate <0.8,1.5,3.93>} 
     object { FenetreWagon translate <3.95,1.5,-0.07>}
     object { FenetreWagon translate <3.95,1.5,3.93>}
     object { FenetreWagon translate <7,1.5,-0.07>}
     object { FenetreWagon translate <7,1.5,3.93>}     
     object { FenetreWagon translate <10,1.5,-0.07>}
     object { FenetreWagon translate <10,1.5,3.93>}
     object { FenetreWagon rotate <0,90,0> translate <-0.07,1.5,2.9>}
     object { FenetreWagonConducteur rotate <0,90,43> translate <13.3,1.9,1.85> scale <1,1,2.1>}
     translate <0,0.5,0>
} 

#declare WagonRoues = union
{   
    object { Wagon }
    object { RouesChassis translate <2.5,0.35,-0.15>} 
    object { RouesChassis rotate <0,180,0> translate <9.5,0.35,4.15>}
} 

#declare WagonConducteurRoues = union
{   
    object { WagonConducteur }
    object { RouesChassis translate <3,0.35,-0.15>} 
    object { RouesChassis rotate <0,180,0> translate <10,0.35,4.15>}
}

                       
//*** 4 - Mise en scène  //
// Scène //    
background {
    color rgb<0.7,0.9,1>
}                  

plane { 
    y, 0
    pigment {
        checker
        color rgb<1,1,1> 
        color <.7,.7,.7> 
    } 
}   
// GARE //
// TRAIN //  
object { WagonRoues }
object { WagonRoues translate <11,0,0>}        
object { WagonConducteurRoues translate <23,0,0>}      
// ARBRES //     
//object { Sapin }
//object { Acacia }   
