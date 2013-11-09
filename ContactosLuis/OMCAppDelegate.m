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

#import "OMCTesteViewController.h"

@implementation OMCAppDelegate
@synthesize contexto=_contexto;

//implementacion de base de datos
-(NSURL *) applicationDocumentsDirectory{
    //administrador de archivos esto es un array y vamos a enviar el objeto necesario descubrimos el directorio
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
}

//ahora creamos el managerobjects model
-(NSManagedObjectModel *) managedObjectModel{
    //ahora llamaos el Url del archivo y juntamos directorio y el archivo
    NSURL * modelURL=[[NSBundle mainBundle] URLForResource:@"Modelo_Contactos" withExtension:@"momd"];
    //creamos el managed
    NSManagedObjectModel * model=[[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    return model;
}

-(NSPersistentStoreCoordinator *) coordinator{
   //creamos coordinador
    NSPersistentStoreCoordinator * coordinator=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.managedObjectModel];
    NSURL * docDir=self.applicationDocumentsDirectory;
    NSURL * localBd=[docDir URLByAppendingPathComponent:@"Contactos.sqlite"];
    //ligamos coordinador
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:localBd options:nil error:nil];
    return coordinator;
}

//verificamos la existencia del contexto
-(NSManagedObjectContext *)contexto{
    if(_contexto!=nil)
    {
        return _contexto;
    }
    NSPersistentStoreCoordinator * coordinator=self.coordinator;
    _contexto=[[NSManagedObjectContext alloc]init];
    [_contexto setPersistentStoreCoordinator:coordinator];
    return _contexto;
}

//funcion que salva contexto
-(void)salvaContexto{
    NSError * error;
    //verificamos si existe error
    if(![self.contexto save:&error]){
        NSDictionary * info=[error userInfo];
        //obtenemos los errores
        NSArray * erros=info[NSDetailedErrorsKey];
        if(erros){
            for(NSError * error in erros ){
                NSLog(@"Erro:%@",[error userInfo]);
            }
        }
        else{
            //si entra aqui es que solo tiene un error
            NSLog(@"Erro:%@",info);
        }
    }
}

-(void)insereDados{
    //verificamos si esta el dato insertado
    NSUserDefaults * config =[NSUserDefaults standardUserDefaults];
    BOOL dadosInseridos=[config boolForKey:@"dados_inseridos"];
    if (!dadosInseridos) {
        //creamos un contacto, se crea asi por ser un objeto gerenciado
        OMCContacto * contacto=[NSEntityDescription insertNewObjectForEntityForName:@"Contacto" inManagedObjectContext:self.contexto];
        //para popular los contactos
        contacto.nome=@"Caelum Unidade Sao Paulo";
        contacto.email=@"contacto@caelum.com.br";
        contacto.endereco=@"R. Vergeiro,33185,vilaMariana,sao paulo, brasil";
        contacto.telefono=@"01155712751";
        contacto.site=@"http://www.caelum.com.br";
        contacto.latitude=[NSNumber numberWithDouble:-23.588034];
        contacto.longitude=[NSNumber numberWithDouble:-46.632369];
        //salvamos el contexto
        [self salvaContexto];
        [config setBool:YES forKey:@"dados_inseridos"];
        [config synchronize];
    }
}
-(void)buscarContactos{
    //busca los contactos
    NSFetchRequest * busca=[NSFetchRequest fetchRequestWithEntityName:@"Contacto"];

    //a esta consulta se puede colocar filtros y ordenacion, para facer filtro usamos NSPredicate, para hacer ordenamiento NSSortDescriptor * ordenacao
    NSSortDescriptor * ordenacao=[NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES];
    //pasamos ordenacion
    [busca setSortDescriptors:@[ordenacao]];
    
    //es el que ejecuta la consulta
    NSArray * contactosImmutable=[self.contexto executeFetchRequest:busca error:nil];
    //convertimos a mutable para permitir la insercion y modificacion del array para modificamos clonamos y mudamos el tipo... con copy convertimos de mutable a immutable y si queremos convertir de inmutable a mutable enviamos mutableCopy
    self.aContactos=[contactosImmutable mutableCopy];
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    
//    NSArray * dirs=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
//    NSString * docDir=dirs[0];
//    
//    self.nomeArquivo=[NSString stringWithFormat:@"%@/Contactos",docDir];
//    self.aContactos=[NSKeyedUnarchiver unarchiveObjectWithFile:self.nomeArquivo];
//    if(!self.aContactos){
//        self.aContactos=[[NSMutableArray alloc] init];
//    }
    //siempre se inserto aunque ssea un dato
    [self insereDados];
    [self buscarContactos];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    ListaContactosViewControler * lista=[[ListaContactosViewControler alloc] init];
    lista.navigationItem.title=@"Contactosinit";
    lista.aContactos=self.aContactos;
    //inyectamos el contexto de base de datos para la lista
    lista.contexto=self.contexto;

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
    
    //---
//    OMCTesteViewController * teste = [[OMCTesteViewController alloc] init];
//    teste.contatos = self.aContactos;
//    self.window.rootViewController=teste;
    //---
    
    
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
    NSError *erro;
    [self.contexto save:&erro];
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
