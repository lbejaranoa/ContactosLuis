//
//  OMCTesteViewController.m
//  ContactosLuis
//
//  Created by ios3729 on 08/11/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import "OMCTesteViewController.h"

@interface OMCTesteViewController ()

@end

@implementation OMCTesteViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contatos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OMCContacto * contacto =[self.contatos objectAtIndex:indexPath.row];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OMCContacto *contato = self.contatos[indexPath.row];
    NSLog(@"Tocou na linha do contato: %@", contato);
}

@end
