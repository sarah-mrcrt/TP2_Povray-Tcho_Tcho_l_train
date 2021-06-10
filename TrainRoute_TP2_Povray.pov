/** 
* @file TrainRoute_TP2_Povray.pov
* Travaux pratiques d'infographie
* @author Alexandre Lavaud & Sarah Mauriaucourt
* @date 19/05/2020 - 10/06/2021
* 
* @animationImages +KFF250
* @animationVideo ffmpeg -r 25 -f image2 -i index%03d.png -c:v libx264 -b:v 1M TrainRoute_TP2_Povray-Alexandre_LAVAUD-Sarah_MAURIAUCOURT.avi 
* @animationVideo ffmpeg -r 25 -f image2 -i index%03d.png -c:v libx264 -b:v 1M TrainGare_TP2_Povray-Alexandre_LAVAUD-Sarah_MAURIAUCOURT.avi        
*
* Structuration des scripts
**/                      
                      
//********************************* Reglages *******************************
#version 3.7;  
global_settings { assumed_gamma 2 }
#default { finish { ambient 0.1 diffuse 0.9 conserve_energy } }      

//********************************* Directives ****************************
#include "colors.inc"
#include "transforms.inc"
#include "textures.inc"
#include "shapes.inc"  
#include "shapes2.inc"
#include "woods.inc"
#include "glass.inc" 
#include "metals.inc"
                                             
//********************************* Scene *********************************  
//********************************* Variables  
#declare Random = seed (2); 
//********************************* Environnement technique 
/* Camera */  
 camera 
{     
    right x * image_width/image_height
    up y
    location <220,3,7>
    look_at<70,-5,-70>
    angle 70 
}            
/* Lumieres */ 
// SOLEIL //
light_source { <1500,2000,2500> color White shadowless } 
// SPOT //
// Interieur wagon
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
// Interieur Gare
#declare SpotGare = union 
{
    light_source
    { 
        <3,9,4> 
        color Turquoise   
        spotlight
        point_at<19,0,9>
        tightness 20
        falloff 10
    }         
    light_source
    { 
        <19,9,4> 
        color Turquoise   
        spotlight
        point_at <3,0,9>
        tightness 20
        falloff 10
    }            
}
/* Sol */ 
#declare Herbe = plane 
{ 
    y, 0
    texture
    {
        pigment { color rgb <0.35,0.65,0.0>*0.72 }
        normal { bumps 0.75 scale 0.015 }
        finish { phong 0.1 }
    }
}      
/* Arriere-plan */
#declare Ciel = plane
{
    y, 1 hollow  
    texture
    {    
        pigment
        { 
            bozo turbulence 0.92
            color_map 
            { 
                [ 0 rgb <.2, .2, 1>*0.9 ]
                [ 0.5 rgb <.2, 0.2, 1>*0.9 ]
                [ 0.7 rgb <1,1,1> ]              
                [ 0.85 rgb <.25,.25,.25> ]
                [ 1 rgb <.5,.5,.5> ]
            }
            scale <1,1,1.5>*2.5
        }
        finish { ambient 1 } 
    }      
    scale 10000
}   
#declare Brouillard = fog 
{ 
    fog_type 2
    distance 500
    color White  
    fog_offset 0.5
    fog_alt 5
    turbulence 8
}                                                

//********************************* Conception de la sc?ne
//**** 1 - Modelisation (formes, materiaux) // 
/* Forme geometrique */ 
//----- RESEAU FERROVIAIRE -----//        
// RAILS // 
// Traverse
#declare Traverse = box { <0, 0, 0>, < 5.5, .15, .25> }
// Fer
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
#declare Essieu = cone{ <0,0,0>,0.25, <0,0.20,0>, .125 }
#declare IntRoue = cylinder{ <0,0,0>, <0,0.3,0>, .4 } 
#declare Rayon = box { <0,0,0>, <0.7,0.32,0.1> }
#declare TourRoue = cylinder{ <0,0,0>, <0,0.25,0>, .6 }
// GARE //
#declare FondationGare = box { <0,0,0>, <24,1,20> } 
#declare QuaiGare = box { <0,0,0>, <40,1,7> }
#declare MurGareLargeur = box { <0,0,0>, <13,10,.5> }
#declare MurGareLongueur = box { <0,0,0>, <22,10,.5> } 
#declare ToitGare = box { <0,0,0>, <24,15,1> }
// ROUTE & PASSAGE A NIVEAU //
// Route
#declare Route = box { <0,0,0>, <11,0,200> }    
#declare Ligne = box { <0,0,0>, <1,0,5> }
// Barriere //
#declare Barriere = cylinder { <0,0,0>, <7,0,0> .15 }
#declare Support = box { <0,0,0>, <1,2.2,.4> }   
//----- ENVIRONNEMENT -----//
// MAISON //
#declare FondationMaison = prism 
{      
    -1 ,1.00 , 6
    <-1, 0>,  
    < 1, 0>, 
    < 1, 1>, 
    < 0, 2>, 
    <-1, 1>, 
    <-1, 0>
    rotate x*-90 scale z*-1 translate x*1
}
#declare ToitMaison = prism 
{ 
    -1.10 ,1.10 , 7
    <-1.05, 0.95>,  
    < 0.00, 2.00>,  
    < 1.05, 0.95>, 
    < 1.05, 1.00>, 
    < 0.00, 2.05>, 
    <-1.05, 1.00>, 
    <-1.05, 0.95>
    rotate x*-90 scale z*-1 translate x*1    
}
#declare PorteMaison = box { <0,0,0>, <2.5,5,0.3> }
// ARBRES //              
//Sapin         
#declare SapinFeuilles = cone { <0,0,0> 1.5, <0,3.5,0> 0.2 }
#declare SapinTronc = cylinder { <0,0,0>, <0,3,0> 0.5 }
//Acacia         
#declare AcaciaFeuilles = sphere { <0,0,0> 2 } 
#declare AcaciaTronc = cylinder { <0,0,0>, <0,3.5,0> 0.3 }        

/* Materiaux & Textures */ 
 // Bois  
#declare VieuxChene =  material 
{
    texture {
        DMFDarkOak
        scale .1
        rotate <0, 90, 0>
    }  
}
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
        normal { bumps 0.1 scale <0.015,0.01,0.015> rotate z*90 } 
        finish { phong 0.2 phong_size 0.3 } 
    }
}     
#declare BoisJaune =  material 
{
    texture 
    {
        pigment{ color Yellow } 
        normal { bumps 0.15  scale <0.015,0.08,0.015> rotate z*90 } 
        finish { phong 0.2 phong_size 0.3 } 
    }
} 
#declare BoisNoir =  material 
{
    texture 
    {
        pigment{ color Black } 
        normal { bumps 0.15  scale <0.015,0.08,0.015> rotate z*90 } 
        finish { phong 0.2 phong_size 0.3 } 
    }
} 
#declare BoisBlanc =  material 
{
    texture 
    {
        pigment{ color White } 
        normal { bumps 0.1  scale <0.025,0.08,0.015> rotate z*90 } 
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
        pigment { color rgbf <0.2,0.5,0, 0.1>*0.75 }
        normal { bumps 0.5 scale 0.5 }
        finish { phong_size 0.003 }
    }     
}
        
#declare Feuilles_Texture_2 = material {
    texture
    {
        pigment{ color rgbf <0.2,0.5,0, 0.1>*0.75}
        normal { bumps 0.5 scale 0.5 }
        finish { phong_size 0.003 }
    }    
}
// Parpaing  
#declare Brique = material 
{  
    texture
    {
        pigment 
        { 
            brick color White
            color rgb <0.8,0.25,0.1>
            // couleur joints, color brick
            brick_size <1.5, .5, 1.5>
            // format in x-,y-,z- direction
            mortar 0.1 // Taille des joints
        }
        normal { wrinkles 0.75 scale 0.01 }
        finish { ambient 0.1 diffuse 0.9 phong 0.2 }    
        scale .15 
    }  
} 
#declare BigBrique = material 
{  
    texture
    {
        pigment 
        { 
            brick color White
            color rgb <0.8,0.25,0.1> 
            brick_size <1.5, .5, 1.5>
            mortar 0.1
        }
        normal { wrinkles 0.75 scale 0.01 }
        finish { ambient 0.1 diffuse 0.9 phong 0.2 }    
        scale <.5,.5,.5>
    }
}
#declare Beton = material 
{
    texture
    {             
        pigment { color rgb <1,0.9,0.8> }
        normal { bumps 0.5 scale 0.01 }
        finish { phong 0.1 }
    }
} 
// Metal
#declare Chrome = material { texture { pigment { P_Chrome5 }  } }
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
        finish { ambient 1 } 
    }
} 
#declare Toiture = material
{ 
    texture 
    { 
        pigment{ color Scarlet } 
        finish { phong 1.0 }
    }
}                         
#declare DamierRougeBlanc = material { texture { pigment { checker pigment { Red } pigment { White } } } }
                          
//**** 2 - Habillage (Textures sur les formes et materiaux crees) //    
//----- RESEAU FERROVIAIRE -----// 
// RAILS // 
#declare Traverse_VieuxChene = object { Traverse material { VieuxChene } } 
#declare Fer_Chrome = object { Fer material { Chrome } }
// TRAIN // 
// Wagons
#declare Parois_BoisRouge = object { ParoisVoyageur material { BoisRouge } }
#declare ParoisConducteur_BoisRouge = object { ParoisConducteur material { BoisRouge } }
#declare AttacheWagon_BoisBleu = object { AttacheWagon material { BoisBleu } }                        
#declare Chassis_BoisJaune = object { Chassis material { BoisJaune } }
// Fenetre
#declare Encadrement_BlancNeige = object { Encadrement material { BlancNeige } } 
#declare Vitre_VerreMinerale = object { Vitre material { VerreMinerale } } 
#declare Vitre_VerreUV = object { Vitre material { VerreUV } }                        
//Roues des wagons
#declare Essieu_BoisBlanc = object { Essieu material { BoisBlanc } }                        
#declare IntRoue_BoisGris = object { IntRoue material { BoisGris } } 
#declare Rayon_BoisBlanc = object { Rayon material { BoisBlanc } } 
#declare TourRoue_BoisNoir = object { TourRoue material { BoisNoir } }
// GARE //
#declare MurGareLargeur_Brique = object { MurGareLargeur material { BigBrique } }
#declare MurGareLongueur_Brique = object { MurGareLongueur material { BigBrique } }                                                                                        
#declare ToitGare_Toiture = object { ToitGare material { Toiture } }                                                                                        
#declare FondationGare_Beton = object { FondationGare material { Beton } }
#declare QuaiGare_Beton = object { QuaiGare material { Beton } } 
// ROUTE & PASSAGE A NIVEAU //  
// Route
#declare Goudron = object { Route material { texture { pigment { Black } } } }   
#declare Peinture = object { Ligne material { texture { pigment { White } } } }
#declare Barriere_DamierRougeBlanc = object { Barriere material { DamierRougeBlanc } }     
// Passage a niveau    
#declare Support_barriere = object { Support material { Beton } }
//----- ENVIRONNEMENT -----// 
// MAISON //
#declare FondationMaison_Brique = object { FondationMaison material { Brique } }
#declare ToitMaison_Toiture = object { ToitMaison material { Toiture } } 
#declare PorteMaison_VieuxChene = object { PorteMaison material { VieuxChene } }          
// ARBRES //
// Sapin
#declare SapinFeuilles_Texture = object { SapinFeuilles material { Feuilles_Texture_1 }  }
#declare SapinTronc_SoucheArbre = object { SapinTronc material { SoucheArbre }  } 
// Acacia
#declare AcaciaFeuilles_Texture = object { AcaciaFeuilles material { Feuilles_Texture_2 }  }
#declare AcaciaTronc_SoucheArbre = object { AcaciaTronc material { SoucheArbre }  }                                                                                     
                                                                            
//**** 3 - Assemblage //  
//----- RESEAU FERROVIAIRE -----//  
// RAILS // 
#declare LigneFer = union 
{   
    object { Fer_Chrome }
    rotate <-90,90,0>
    scale 0.012 
    scale x*-42000
}
#declare Rail = union
{                            
    #for (i,0,2000)
        object { Traverse_VieuxChene   rotate y*-90 translate x*.25 translate x*i*0.5 }
    #end    
    object { LigneFer  translate <0, 0.15,0.5> }   
    object { LigneFer translate <0, 0.15,5> } 
}   
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
    rotate 360*clock*132*x
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
// GARE // 
#declare Gare = union                              
{   
    object { MurGareLongueur_Brique translate <0,0,13>}
    object { MurGareLargeur_Brique rotate y*-90 translate <0.5,0,0>}
    object { MurGareLargeur_Brique rotate y*-90 translate <22,0,0>}
    object { ToitGare_Toiture rotate <-89,0,0> translate <-1,9,14.25>}
    light_source { SpotGare }
    object { FondationGare_Beton translate <-1,0,-5.5>}
    object { QuaiGare_Beton translate <-9,0,-8>}
}  
// ROUTE & PASSAGE A NIVEAU // 
// Route
#declare Chaussee = union {
     object { Goudron } 
     #for(i,0,20)
          object { Peinture translate <5,0.01,-.22+(i*10)> }
     #end
}       
// Passage à niveau
#declare Barriere_anim = union 
{
     object { Barriere_DamierRougeBlanc }
     #if ((90*(1-(clock*2))) > 0)  
        rotate z*90*(1-(clock*2))   
     #else  
        rotate z*0
     #end  
}
#declare PassageNiveau = union
{
    object { Barriere_anim translate <0.5,0,0.2> }  
    object { Support_barriere  translate y*-2 } 
}
//----- ENVIRONNEMENT -----//  
// MAISON //
#declare Maison = union
{    
    difference 
    {
        object { FondationMaison_Brique scale 7 translate z*7 }    
        object { FenetreWagon scale 1.5 translate <1.5,2,-0.07> } 
        object { FenetreWagon scale 1.5 translate <10,2,-0.07> }
        object { FenetreWagon scale 1.5 translate <10,0,-0.07> rotate z*45 }
        object { FenetreWagon scale 1.5 rotate y*90 translate <-0.07,2,4.5> }
        object { FenetreWagon scale 1.5 rotate y*90 translate <-0.07,2,12.25> } 
        object { FenetreWagon scale 1.5 translate <1.5,2,13.93> } 
        object { FenetreWagon scale 1.5 translate <10,2,13.93> }  
    }
    object { ToitMaison_Toiture scale 7 translate z*7 } 
    object { PorteMaison_VieuxChene translate <5.75,0,-0.1> }        
}    
#declare Maisons = union 
{
    #for(i,0,6) 
        object { Maison rotate y*-90 translate <190,0,-100> translate z*i*40 } 
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
#declare Arbres = union {
    #for (i, 0, 75) 
        #declare X = rand(Random)*220;
        #declare Z = rand(Random)*200 -100;
        #if(!((X>170 & X<205) | (Z>-2 & Z<8)))
             object { Sapin  translate <X,0,Z> } 
        #end   
        #declare X = rand(Random)*220;
        #declare Z = rand(Random)*200-100;
        #if(!((X>170 & X<205) | (Z>-2 & Z<8)))
             object { Acacia  translate <X,0,Z> } 
        #end                
    #end      
}   
				 					   
//*** 4 - Mise en scene  //
// SCENE //
plane { Herbe }     
fog { Brouillard }  
object { Ciel }         
//----- RESEAU FERROVIAIRE -----//    
object { Rail translate <-700,0,-0.7> }    
object { Train translate <clock*250,0,0> }
object { Gare translate z*14 }
object { Chaussee translate <194.5,0.01,-100> }             
object { PassageNiveau translate <195,2,5.2> }       
object { PassageNiveau rotate y*180 translate <205,2,-1.2> }   
//----- ENVIRONNEMENT -----// 
object { Maisons }
object { Arbres }   
                                                                          