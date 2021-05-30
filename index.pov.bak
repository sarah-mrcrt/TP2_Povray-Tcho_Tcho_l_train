/** @file index.pov
* Travaux pratiques dinfographie : Atelier de bricolage
* @author Téo L'Huillier & Sarah Mauriaucourt
* @date 29/12/2020 - 29/01/2021
* + moi
* Structuration des scripts
*/


//********************************* Reglages *********************************
#version 3.7;
global_settings
{
assumed_gamma 2.0
}
#default{ finish { ambient 0.1 diffuse 0.9 conserve_energy } }

//********************************* Directives *********************************
#include "colors.inc"
#include "transforms.inc"
#include "textures.inc"
#include "shapes.inc"
#include "woods.inc"
#include "glass.inc"
#include "stars.inc"
#include "stones.inc"              


/******************************** TEXTURES ********************************/
#declare Tronc_Texture =
texture{
    pigment{ 
        color rgb< 0.75, 0.5, 0.30>*0.25}
        normal { bumps 2 scale<0.025,0.075,0.025>}
        finish { phong 0.003 }
        }     
        
#declare Feuilles_Texture_1 =
texture{
    pigment{
        color rgbf<0.2,0.5,0, 0.1>*0.75}
        normal { bumps 0.5 scale 0.5 }
        finish { phong_size 0.003 }
        }
        
#declare Feuilles_Texture_2 =
texture{
    pigment{
        color rgbf<0.2,0.5,0, 0.1>*0.75}
        normal { bumps 0.5 scale 0.5 }
        finish { phong_size 0.003 }
        }



//********************************* AXES X Y Z *********************************
/*
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
*/ 
   
//********************************* CAMERA *********************************
  camera {     
    right x * image_width/image_height
    up y
    location <7, 2, 30>
    look_at <0, 3, 0>
    angle 30   
    
  }
      
      
//********************************* LUMIERE + BG + SOL *********************************

light_source {
    <20000, 2000, 20000>
    color White
}
  
background {
    color Gray50
}                  

plane { 
    y, 0
    pigment {
        checker
        color rgb<1,1,1> 
        color <.7,.7,.7> } 
    }
                 
                 
//********************************* RAIL *********************************
// Traverse
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
               

              

//Sapin         
#declare Feuilles_Sapin = cone
{   
    <0,0,0>1.5, <0,3.5,0>0.2
}
  
#declare Tronc = cylinder
{
    <0,0,0>, <0,3,0>0.5        
}

#declare Sapin = union
{
    object { Feuilles_Sapin translate <0,3.7,0> texture{ Feuilles_Texture_1 }}
    object { Feuilles_Sapin translate <0,2.5,0> scale 1.1 texture{ Feuilles_Texture_1 }} 
    object { Feuilles_Sapin translate <0,1.5,0> scale 1.2 texture{ Feuilles_Texture_1 }}    
    object { Tronc texture{ Tronc_Texture }}
}

//Acacia         
#declare Boule = sphere
{   
    <0,0,0>2
}
  
#declare Tronc = cylinder
{
    <0,0,0>, <0,3.5,0>0.3        
}

#declare Acacia = union
{
    object { Boule translate <0,4,0> texture { Feuilles_Texture_2 }}    
    object { Tronc texture{ Tronc_Texture }}
}










                       
         
         
/******************************** OBJETS ********************************/
object { Acacia }