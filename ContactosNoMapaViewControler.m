//
//  ContactosNoMapaViewControler.m
//  ContactosLuis
//
//  Created by ios3729 on 05/11/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import "ContactosNoMapaViewControler.h"

@interface ContactosNoMapaViewControler ()

@end

@implementation ContactosNoMapaViewControler

-(id)init{
    self=[super init];
    if(self){
        //titulo de mapa
        self.navigationItem.title=@"Mapa";

        //creamos la imagen que vamos a usar en el tab
        UIImage * img = [UIImage imageNamed:@"mapa-contatos.png"];
        //colocamos nombre del tab de navegacion inferior el tag sirve para leer cual es el tab actual
        UITabBarItem * tabItem=[[UITabBarItem alloc]initWithTitle: @"Contacts" image:img tag:0];
        
        self.tabBarItem=tabItem;
        
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //creamos mktrackingbar butot
    MKUserTrackingBarButtonItem * btn = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.outLetMapa];
    self.navigationItem.leftBarButtonItem=btn;
    
    // Do any additional setup after loading the view from its nib.
    
    self.outLetMapa.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    //invocamos a super para no quitar funcionalidad heredada
    [super viewWillAppear:animated];
    //utilizamod delegate para cargar los contactos del mapa 
    //    NSArray * coordenadas=[[NSArray alloc]init];
    [self.outLetMapa addAnnotations: self.aContactos];
    
}
-(void) viewWillDisappear:(BOOL)animated{
    //invocamos super
    [super viewWillDisappear:animated];
    //quitamos los contactos del mapa
    [self.outLetMapa removeAnnotations: self.aContactos];
}

//delegate del map
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //verificamos si estamos en ubicacion actual
    if([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    //definimos variable global con scope local
    static NSString* pool=@"poolDePiros";
    //declaramos variable que vamos a enviar
    MKPinAnnotationView * pino;
    //antes de crear un anotation view verificamos si hay alguno en el pool
    pino=(MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pool];
    //verificamos si existe pin
    if(!pino)
    {
        //creamos el pin y enviamos la anotacion
        pino=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pool];
    }
    else{
        //configuramos pino si halla del pool
        pino.annotation=annotation;
    }
    //hata aqui ya retornaria el pino con texto
    //cambiamos el color de pino
    pino.pinColor=MKPinAnnotationColorRed;
    //decide si mostramos balon o no si hacemos click sobre el
    pino.canShowCallout=YES;
    //colocamos foto que se encuentra en anotation
    OMCContacto * contacto=(OMCContacto *)annotation;
    if(contacto){
        //verificamos tamano de foto;
        //para efectos de interface los pixeles los cnvierte en pontos
        //1pixel=1pt en retirna 2pixel=1pt;
        //AutoLayout permite modificar resoluciones
        //frame representa la pantalla
        //propiedades origin y size
        //
        //creamos imagen del tamano que queremos
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,32,32)];
        //cargamps foto
        image.image=contacto.foto;
        //cargamos imagen en el balon
        pino.leftCalloutAccessoryView=image;
    }
    return pino;
    
}

@end
