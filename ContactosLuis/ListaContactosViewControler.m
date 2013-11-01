//
//  ListaContactosViewControler.m
//  ContactosLuis
//
//  Created by ios3729 on 31/10/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//
#import "FormularioContactoViewControlerViewController.h"
#import "ListaContactosViewControler.h"
#import "OMCContacto.h"

@implementation ListaContactosViewControler

-(id)init{
    self=[super init];
    if(self){
        
        self.navigationItem.title=@"Contactos";
        UIBarButtonItem * btnNav=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeForm)];
        self.navigationItem.rightBarButtonItem=btnNav;
    }
    return self;
}
-(void)exibeForm{
//    NSLog(@"llamada");
    FormularioContactoViewControlerViewController * form=[[FormularioContactoViewControlerViewController alloc] init];
    form.aContactos=self.aContactos;
//    [self presentViewController:form animated:YES completion:nil];
    [self.navigationController pushViewController:form animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.aContactos count];
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OMCContacto * contacto =[self.aContactos objectAtIndex:indexPath.row];
    //self.aContactos[indexPath.row];
    NSLog(@"Contacto:%@",contacto);
    return nil;
    
}

@end
