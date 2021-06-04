/** @file index.pov
* Travaux pratiques d'infographie
* @author Alexandre Lavaud & Sarah Mauriaucourt
* @date 29/12/2020 - 29/01/2021
* + moi
* Structuration des scripts
*/
                      
                      
//********************************* R�glages *******************************
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
                        
                        
//********************************* Sc�ne *********************************  
//********************************* Environnement technique 
// Cam�ra // 

  camera {     
    right x * image_width/image_height
    up y
    location <40,5,-20>
    look_at<15,1,0>
    angle 30   
  }    
  
/*
//dedans
  camera {     
    right x * image_width/image_height
    up y
    location <1,1,2>
    look_at<9,3.5,2>
    angle 50   
  }
*/  
// Lumi�res //  

light_source{ <5, 4.3, 2>  color Turquoise }
light_source{ <16, 4.3, 2>  color Turquoise }            

// Lumi�re de type soleil       
light_source {
    <200, 200, -200>
    color White
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
                


//********************************* Conception de la sc�ne
//**** 1 - Modelisation (formes, materiaux) // 
/* Forme g�om�trique */   

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
       
       
//TRAIN     
#declare Train = prism
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

    rotate <-90,0,0>
    translate <0,0,4>
    
    texture {
        pigment{ 
            color rgb <1,1,1>*1.2}
        }     
}         

//WAGON     
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
#declare Encadrement = box{ <0,0,0>, <3,3,0.15> } 
#declare Vitre = box{ <0,0,0>, <2.8,2.8,0.1> } 



 
/* Mat�riaux (cr�ation des textures) */  
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
#declare BoisBlanc =  material 
{
    texture { pigment{ color Red } normal { bumps 0.05 } finish { phong 0.2 phong_size 0.3 } }
} 
      
// Transparent   
#declare VerreMinerale = material { texture { T_Glass3 }  }   
// Couleurs
#declare BlancNeige = material { texture { pigment { color White*1.1 } finish { ambient 1} } }

          
      
//**** 2 - Habillage (On met les textures sur les formes et mat�riaux cr��s) //
// Sapin
#declare SapinFeuilles_Texture = object { SapinFeuilles material { Feuilles_Texture_1 }  }
#declare SapinTronc_SoucheArbre = object { SapinTronc material { SoucheArbre }  } 
// Acacia
#declare AcaciaFeuilles_Texture = object { AcaciaFeuilles material { Feuilles_Texture_2 }  }
#declare AcaciaTronc_SoucheArbre = object { AcaciaTronc material { SoucheArbre }  }            
// F�netre
#declare Encadrement_White = object { Encadrement material { BlancNeige } } 
#declare Vitre_Verre = object { Vitre material { VerreMinerale } } 
#declare Vitre_Verre2 = object { Vitre texture{ Lightning1  finish { phong 1 } scale 50 rotate <0,0,-5>} }
//Train
#declare ParoisBlanc = object { Parois material { BoisBlanc } }

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

// Fenetre
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
     
//Parois du Wagon     
#declare ParoisWagon = difference {
    object { ParoisBlanc }
    //object { Parois scale 0.8 translate <0.1,0.4,0.4>}
    rotate <-90,0,0> translate <0,0,4> 
}
//Wagon 1
#declare Wagon = difference {
     object { ParoisWagon }
     object { FenetreWagon translate <1,1.5,-0.07>}
     object { FenetreWagon translate <1,1.5,3.93>} 
     object { FenetreWagon translate <4.15,1.5,-0.07>}
     object { FenetreWagon translate <4.15,1.5,3.93>}
     object { FenetreWagon translate <7.2,1.5,-0.07>}
     object { FenetreWagon translate <7.2,1.5,3.93>}
     translate <0,0.5,0>
} 
 


                       
//*** 4 - Mise en sc�ne  //
// Sc�ne //    
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
object { Wagon }        
object { Wagon translate <11,0,0> }
// ARBRES //     
//object { Sapin }
//object { Acacia }   
