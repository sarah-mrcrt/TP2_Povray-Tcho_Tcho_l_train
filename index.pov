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
  camera {     
    right x * image_width/image_height
    up y
    location <4, 5, 10>
    look_at <-3,1,0>
    angle 50   
    
  }
// Lumières //
// Lumière de type soleil       
light_source {
    <200, 200, 200>
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
       
       
//TRAIN  

//Bandes bleues
#declare Pattern_Object_1= union
{ 
    object{ Round_Box (<-10,-0.5,-3.0>,<0,1.3,-0.5>,0.2,0) }  
    object{ Round_Box(<-10,-0.5, 0.5>,<0,1.3, 3.0>,0.2,0) }  
}               

//Couleurs blanc et bleu
#declare Object_Pigment_1 = pigment
{ 
    object { Pattern_Object_1
        color rgb<1,1,1> //Interieur Blanc
        color rgb<0,0.7,0.9> //Bandes bleues
    }
}
#declare Body_Texture_1 = texture
{ 
    pigment{ Object_Pigment_1 } 
    finish { phong 0.5 }
} 
      
      
//Toit gris
#declare Pattern_Object_2 = box { <-10,2.25,-3>,<0,3,3> }  

//Couleurs toit gris
#declare Object_Pigment_2 = pigment
{ 
    object { Pattern_Object_2
        color rgbf<1,1,1,1> //ne pas toucher
        color rgb<0.7,0.7,0.7>*0.5//Toit gris 
    }
}
#declare Body_Texture_2 = texture 
{ 
    pigment{ Object_Pigment_2 }
    finish { phong 0.5 }
}

//Superposition de texture 
#declare Body_Texture =
 texture{ Body_Texture_1 } 
 texture{ Body_Texture_2 }

//Train 
#declare Train =
union{ 
  object{ Round_Box(<-3,0,-0.75>,<0,3,0.75>,0.5,0)
          matrix<1, 0, 0, // shear_y_to_x 
              -0.5, 1, 0,
                 0, 0, 1,
                 0, 0, 0>
        } //       
  object{ Round_Box(<-5,0,-0.75>,<0,3,0.75>,0.5,0)  
          translate<-1.5,0,0.00>
        }     
  scale<1,1,3>  
}  

 
/* Matériaux (création des textures) */  
#declare SoucheArbre =  
material {
texture{
    pigment{ 
        color rgb< 0.75, 0.5, 0.30>*0.25}
        normal { bumps 2 scale<0.025,0.075,0.025>}
        finish { phong 0.003 }
        }     
      }  
#declare Feuilles_Texture_1 = material {
texture{
    pigment{
        color rgbf<0.2,0.5,0, 0.1>*0.75}
        normal { bumps 0.5 scale 0.5 }
        finish { phong_size 0.003 }
        }     }
        
#declare Feuilles_Texture_2 = material {
    texture{
    pigment{
        color rgbf<0.2,0.5,0, 0.1>*0.75}
        normal { bumps 0.5 scale 0.5 }
        finish { phong_size 0.003 }
        }    
        
      }            
      
//**** 2 - Habillage (On met les textures sur les formes et matériaux créés) //
// Sapin
#declare SapinFeuilles_Texture = object { SapinFeuilles material { Feuilles_Texture_1 }  }
#declare SapinTronc_SoucheArbre = object { SapinTronc material { SoucheArbre }  } 
// Acacia
#declare AcaciaFeuilles_Texture = object { AcaciaFeuilles material { Feuilles_Texture_2 }  }
#declare AcaciaTronc_SoucheArbre = object { AcaciaTronc material { SoucheArbre }  }

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

                       
//*** 4 - Mise en scène  //
// Scène //    
background {
    color Gray50
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
// ARBRES //     
//object { Sapin }
//object { Acacia }   
object { Train texture{ Body_Texture } }