//
//  OMCAppDelegate.m
//  ContactosLuis
//
//  Created by ios3729 on 30/10/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import "OMCAppDelegate.h"
#import "FormularioContactoViewControlerViewController.h"
#import "ListaContactosViewControler.h"
#import "ContactosNoMapaViewControler.h"
@implementation OMCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSArray * dirs=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString * docDir=dirs[0];
    self.nomeArquivo=[NSString stringWithFormat:@"%@/Contactos",docDir];
    self.aContactos=[NSKeyedUnarchiver unarchiveObjectWithFile:self.nomeArquivo];
    if(!self.aContactos){
        self.aContactos=[[NSMutableArray alloc] init];
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    ListaContactosViewControler * lista=[[ListaContactosViewControler alloc] init];
    lista.navigationItem.title=@"Contactosinit";
    lista.aContactos=self.aContactos;

    //muestra formulario inicial
    UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:lista];
    
    //creacion de view mapa
    ContactosNoMapaViewControler * mapa=[[ContactosNoMapaViewControler alloc]init];
    
    //inyectamos dependencia
    mapa.aContactos=self.aContactos;
    
    //colocamos mapa en barra
    UINavigationController * navMapa=[[UINavigationController alloc]initWithRootViewController:mapa];
    
    
    //creacion de tabbar controler
    UITabBarController * tabs=[[UITabBarController alloc]init];
    //colocamos las view controlers
    //tabs.viewControllers=@[nav,mapa];
    tabs.viewControllers=@[nav,navMapa];
    //envio al controlador principal
    self.window.rootViewController=tabs;
    
    //FormularioContactoViewControlerViewController * form=[[FormularioContactoViewControlerViewController alloc] init];
    //self.window.rootViewController=form;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [NSKeyedArchiver archiveRootObject:self.aContactos toFile: self.nomeArquivo];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
