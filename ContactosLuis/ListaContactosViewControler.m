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
        self.navigationItem.leftBarButtonItem=self.editButtonItem;
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
    static NSString* pool=@"pool";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:pool];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pool];
    }
    cell.textLabel.text=contacto.nome;
    //self.aContactos[indexPath.row];
    NSLog(@"Contacto:%@",contacto);
    return cell;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        [self.aContactos removeObjectAtIndex:indexPath.row];
//        [self.tableView reloadData];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:<#(UITableViewRowAnimation)#>]
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    OMCContacto * contacto=self.aContactos[sourceIndexPath.row];
    [self.aContactos removeObjectAtIndex:sourceIndexPath.row];
    [self.aContactos insertObject:contacto atIndex:destinationIndexPath.row];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OMCContacto * contacto=self.aContactos[indexPath.row];
    FormularioContactoViewControlerViewController * form=[[FormularioContactoViewControlerViewController alloc] initWithContacto:contacto];
    [self.navigationController pushViewController:form animated:YES];
}

@end
