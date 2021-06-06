/** @file index.pov
* Travaux pratiques d'infographie
* @author Alexandre Lavaud & Sarah Mauriaucourt
* @date 19/05/2020 - 10/06/2021
* 
* @animationImages +KFF250
* @animationVideo ffmpeg -r 10 -f image2 -i index%03d.png -c:v libx264 -b:v 1M TrainRoute_TP2_Povray-Alexandre_LAVAUD-Sarah_MAURIAUCOURT.avi 
* @animationVideo ffmpeg -r 10 -f image2 -i index%03d.png -c:v libx264 -b:v 1M TrainGare_TP2_Povray-Alexandre_LAVAUD-Sarah_MAURIAUCOURT.avi        
* Structuration des scripts
*/                      

//ANIMATION RAPIDE : +KFF10
                      
//********************************* R�glages *******************************
#version 3.7;  
global_settings { assumed_gamma 2.0 }
#default { finish { ambient 0.1 diffuse 0.9 conserve_energy } }  
//********************************* Directives ****************************
#include "colors.inc"
#include "transforms.inc"
#include "textures.inc"
#include "shapes.inc"  
#include "shapes2.inc"
#include "woods.inc"
#include "glass.inc"
#include "stars.inc"
#include "stones.inc" 
#include "metals.inc"
#include "golds.inc"
#include "functions.inc"
#include "math.inc"                        
                        
//********************************* Sc�ne *********************************  
//********************************* Environnement technique 
// Cam�ra // 
    
camera 
{     
    right x * image_width/image_height
    up y
    location <5,6,-10>
    look_at<5,1,2>
    angle 60   
}      

/*     
//Vue loin
camera 
{     
    right x * image_width/image_height
    up y
    location <220,5,10>
    look_at<50,-5,-40>
    angle 60   
}     
*/   


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
 

// Lumi�res // 
 
// Lumi�re de type soleil    

light_source{<-1500,2000,2500> color White}
     
/*     
light_source {
    <200, 200, -200>
    color White
} 
*/          
       

// Spot interieur wagon
#declare SpotIntWagon = union 
{
    light_source
    { 
        <3.5,3.8,2> 
        color Turquoise   
        spotlight
        point_at<3.5,0,2>
        tightness 10
        falloff 40
    }    
            
    light_source
    { 
        <7.5,3.8,2> 
        color Turquoise   
        spotlight
        point_at <7.5,0,2>
        tightness 10
        falloff 40
    }            
}
                      
                      
// AXES X Y Z // 

cylinder { 0, x*100, 0.05 pigment { red 1 }   finish { ambient 1 } }
cylinder { 0, y*100, 0.05 pigment { green 1 } finish { ambient 1 } }
cylinder { 0, z*100, 0.05 pigment { blue 1 }  finish { ambient 1 } }          


//********************************* Conception de la sc�ne
//**** 1 - Modelisation (formes, materiaux) // 
/* Forme g�om�trique */    

// Barri�re
#declare Barriere = cylinder 
{          //5.5
  <0,0,0>, <5.5,0,0> .1
            
  pigment { checker pigment { Red } pigment { White }}    
  #if ((90*(1-(clock*2))) > 0)  
     rotate z*90*(1-(clock*2))   
  #else  
     rotate z*0
  #end     
                          
}       

 
// Rails //
#declare Traverse = box
{
    <0, 0, 0>,
    < 5.5, .15, .25>
    texture {
      DMFDarkOak
      scale .1
      rotate <0, 90, 0>
    }  
    rotate <0,-90,0> 
    translate x*.25
}
  

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

    rotate <-90,90,0>
    scale 0.012 
    scale x*-42000
    material { texture { pigment { P_Chrome5 }  }      }
}       
        
// TRAIN //
// Wagon : Conducteur    
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
// Wagon : Voyageurs    
#declare ParoisVoyageur = prism
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
// Wagon : Fenetre 
#declare Encadrement = box { <0,0,0>, <3,3,0.15> } 
#declare Vitre = box { <0,0,0>, <2.8,2.8,0.1> }  
// Wagon: Attache  
#declare AttacheWagon = Supercone ( <0.0,0.0,0.0>, 0.4, 0.6, <0.0,1,0.0>, 0.6, 0.4 )
// Wagon : Roues
#declare Chassis = box { <0,0,0>, <7,0.5,0.25> } 
#declare Essieu = cone{ <0,0,0>,0.25,<0,0.20,0>,0.125 }
#declare IntRoue = cylinder{ <0,0,0>,<0,0.3,0>,0.4 } 
#declare Rayon = box { <0,0,0>, <0.7,0.32,0.1> }
#declare TourRoue = cylinder{ <0,0,0>,<0,0.25,0>,0.6 }
// GARE //
// ROUTE & PASSAGE A NIVEAU //
// Route
// Passage � niveau 
                       



// ARBRES //              
//Sapin         
#declare SapinFeuilles = cone { <0,0,0> 1.5, <0,3.5,0> 0.2 }
#declare SapinTronc = cylinder { <0,0,0>, <0,3,0> 0.5 }
//Acacia         
#declare AcaciaFeuilles = sphere { <0,0,0> 2 } 
#declare AcaciaTronc = cylinder { <0,0,0>, <0,3.5,0> 0.3 }        

/* Mat�riaux (cr�ation des textures) */ 
 // Bois
#declare SoucheArbre =  material 
{
    texture
    {
        pigment { color rgb < 0.75, 0.5, 0.30>*0.25 }
        normal { bumps 2 scale <0.025,0.075,0.025> }
        finish { phong 0.003 }
    }     
}
#declare BoisBleu =  material 
{
    texture 
    {
        pigment{ color Blue } 
        normal { bumps 0.25 scale <0.015,0.08,0.015> } 
        finish { phong 0.2 phong_size 0.3 } 
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
        normal { bumps 0.1  scale <0.025,0.08,0.015> rotate <0,0,90>} 
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
// Verdure 
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
// Transparent 
#declare VerreMinerale = material { texture { T_Glass3 } }
#declare VerreUV = material 
{ 
    texture
    { 
        Lightning1  
        finish { phong 3 } 
        scale 40 
        rotate <0,0,95> 
    } 
}            
// Couleur                        
#declare BlancNeige = material 
{ 
    texture 
    { 
        pigment { color White*1.1 } 
        finish { ambient 1} 
    }
}                          
                          
//**** 2 - Habillage (On met les textures sur les formes et mat�riaux cr��s) //    
// TRAIN // 
// Wagons
#declare Parois_BoisRouge = object { ParoisVoyageur material { BoisRouge } }
#declare ParoisConducteur_BoisRouge = object { ParoisConducteur material { BoisRouge } }
#declare AttacheWagon_BoisBleu = object { AttacheWagon material { BoisBleu } }                        
#declare Chassis_BoisJaune = object { Chassis material { BoisJaune } }
// F�netre
#declare Encadrement_BlancNeige = object { Encadrement material { BlancNeige } } 
#declare Vitre_VerreMinerale = object { Vitre material { VerreMinerale } } 
#declare Vitre_VerreUV = object { Vitre material { VerreUV } }                        
//Roues des wagons
#declare Essieu_BoisBlanc = object { Essieu material { BoisBlanc } }                        
#declare IntRoue_BoisGris = object { IntRoue material { BoisGris } } 
#declare Rayon_BoisBlanc = object { Rayon material { BoisBlanc } } 
#declare TourRoue_BoisNoir = object { TourRoue material { BoisNoir } }           
// ARBRES //
// Sapin
#declare SapinFeuilles_Texture = object { SapinFeuilles material { Feuilles_Texture_1 }  }
#declare SapinTronc_SoucheArbre = object { SapinTronc material { SoucheArbre }  } 
// Acacia
#declare AcaciaFeuilles_Texture = object { AcaciaFeuilles material { Feuilles_Texture_2 }  }
#declare AcaciaTronc_SoucheArbre = object { AcaciaTronc material { SoucheArbre }  } 
                      
//**** 3 - Assemblage //  
// TRAIN //  
// Wagon : Fenetre
#declare FenetreWagon = union
{    
    difference 
    { 
        object { Encadrement_BlancNeige } 
        object { Vitre_VerreMinerale translate <0.1,0.1,-0.025> } 
        object { Vitre_VerreMinerale translate <0.1,0.1,0.08> } 
    }    
    object { Vitre_VerreMinerale  translate <0.1,0.1,0.025> } 
    scale <0.6,0.6,0>   
}
#declare FenetreWagonConducteur = union
{    
    difference 
    { 
        object { Encadrement_BlancNeige } 
        object { Vitre_VerreUV translate <0.1,0.1,-0.025> } 
        object { Vitre_VerreUV translate <0.1,0.1,0.08> }
    }    
    object { Vitre_VerreUV  translate <0.1,0.1,0.025> } 
    scale <0.6,0.6,0>   
}  
//Roues  
#declare IntRoueRayon = union 
{
    object { IntRoue_BoisGris } 
    object { Rayon_BoisBlanc translate <-0.35,0,-0.05> } 
    object { Rayon_BoisBlanc translate <-0.35,0,-0.05> rotate 90 }   
}
#declare Roue = union 
{
    object { Essieu_BoisBlanc }
    object { IntRoueRayon translate <0,0.2,0> }
    object { TourRoue_BoisNoir translate <0,0.2,0> } 
    rotate z*-90   
    rotate 360*clock*3*x
}
#declare Roues = union
{    
    #for (Pas, 0, 2, 1) 
        object{ Roue translate< 0, 0, Pas*2.5 >}  
    #end 
    rotate y*90 
    translate x*1
}  
#declare RouesChassis = union
{
    object { Roues translate y*.25 }
    object { Chassis_BoisJaune }
} 
// Wagon : Parois          
#declare ParoisConducteur = union 
{ 
    object { ParoisConducteur_BoisRouge rotate <-90,0,0> translate <0,0,4> } 
    object { AttacheWagon_BoisBleu scale <.5,.5,.7> rotate z*90 translate <0,1,2> } 
}  
#declare ParoisPassagers = union 
{ 
    object { Parois_BoisRouge rotate <-90,0,0> translate <0,0,4> } 
    object { AttacheWagon_BoisBleu scale <.5,.5,.7> rotate z*90 translate <0,1,2> } 
    object { AttacheWagon_BoisBleu scale <.5,.5,.7> rotate z*-90 translate <10,1,2> }  
}   
// Wagons
#declare WagonPassagers = union
{   
    difference 
    {
        object { ParoisPassagers }
        #for (Pas, 0.45, 3, 1) 
            object{ FenetreWagon translate <Pas*2.8,1.5, -0.07 > }  
            object{ FenetreWagon translate <Pas*2.8,1.5,3.93> } 
        #end 
        object { FenetreWagon rotate <0,90,0> translate <-0.07,1.5,2.9> }
        object { FenetreWagon rotate <0,90,0> translate <9.93,1.5,2.9> }
        translate <1,0.5,0>
    } 
    light_source { SpotIntWagon }
    object { RouesChassis translate <2.5,0.35,-0.15> } 
    object { RouesChassis rotate <0,180,0> translate <9.5,0.35,4.15> } 
}   
#declare WagonConducteur = union
{
    difference 
    {
        object { ParoisConducteur }
        #for (Pas, 0.45, 4, 1) 
            object{ FenetreWagon translate <Pas*2.8,1.5, -0.07 > }  
            object{ FenetreWagon translate <Pas*2.8,1.5,3.93> } 
        #end 
        object { FenetreWagon rotate <0,90,0> translate <-0.07,1.5,2.9> }  
        object { FenetreWagonConducteur rotate <0,90,43> translate <13.3,1.9,1.85> scale <1,1,2.1> }
        translate <1,0.5,0>
    } 
    light_source { SpotIntWagon } 
    object { RouesChassis translate <3.6,0.35,-0.15> } 
    object { RouesChassis rotate <0,180,0> translate <10.6,0.35,4.15> } 
}
// Train
#declare Train = union 
{   
    object { WagonConducteur } 
    #for (Pas, 1, 3, 1)
        object { WagonPassagers translate -x*Pas*11 }     
    #end
}
// ARBRES //
// Sapin
#declare Sapin = union
{
    object { SapinFeuilles_Texture translate <0,3.7,0> }
    object { SapinFeuilles_Texture translate <0,2.5,0> scale 1.1 } 
    object { SapinFeuilles_Texture translate <0,1.5,0> scale 1.2 }    
    object { SapinTronc_SoucheArbre }
}
// Acacia
#declare Acacia = union
{
    object { AcaciaFeuilles_Texture translate <0,4,0> }    
    object { AcaciaTronc_SoucheArbre }
}
                       
#declare Rail = union
{                            
     #for (i,0,2000)
         object { Traverse translate <i*0.5,0,0> }
     #end
    
    object { Fer translate <0,0.15,0.5>}   
    object { Fer translate <0,0.15,5>}
}       					   
					   
					   
//*** 4 - Mise en sc�ne  //
// SCENE //    
// Fond

background {
    color rgb<0.7,0.9,1>
}  

// Sol
plane { 
    y, 0
    pigment {
        checker
        color rgb<1,1,1> 
        color <.7,.7,.7> 
    } 
} 
   
   
/*
// Ciel bleu + Herbe 
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.50 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< 0,0,0>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}

// fog on the ground
fog { fog_type   2
      distance   500
      color      White  
      fog_offset 0.5
      fog_alt    5
      turbulence 8
    }

// ground
plane { <0,1,0>, 0 
        texture{ pigment{ color rgb<0.35,0.65,0.0>*0.72 }
	         normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               }
      }
*/    
             

// GARE //
//object { Rail translate <-700,0,-0.7>}     
//object {Barriere translate <195,2,5.2> }       
//object {Barriere rotate y*180 translate <205,2,-1.2> }
// TRAIN //  
//object { Train translate <clock*250,0,0> }    
// ARBRES //     
//object { Sapin }
//object { Acacia }   
