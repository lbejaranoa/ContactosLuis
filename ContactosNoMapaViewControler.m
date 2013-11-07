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
    [self.outLetMapa removeAnnotation: self.aContactos];
}
@end
