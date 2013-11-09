//
//  OMCAppDelegate.h
//  ContactosLuis
//
//  Created by ios3729 on 30/10/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) NSMutableArray *aContactos;
@property (strong) NSString * nomeArquivo;
//realonly para eviar se sobreescriba el contecto
@property (strong,readonly) NSManagedObjectContext * contexto;
-(NSURL *) applicationDocumentsDirectory;
-(NSManagedObjectModel *) managedObjectModel;
-(NSPersistentStoreCoordinator *) coordinator;
-(NSManagedObjectContext *)contexto;
-(void)salvaContexto;
-(void)insereDados;
-(void)buscarContactos;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;

@end
