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
     self.linhaSeleccionada=-1;
    if(self){
        self.navigationItem.title=@"Contactos";
        UIBarButtonItem * btnNav=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeForm)];
        self.navigationItem.rightBarButtonItem=btnNav;
        self.navigationItem.leftBarButtonItem=self.editButtonItem;
        //creamos la imagen que vamos a usar en el tab
        UIImage * img = [UIImage imageNamed:@"lista-contatos.png"];
        //colocamos nombre del tab de navegacion inferior el tag sirve para leer cual es el tab actual
        UITabBarItem * tabItem=[[UITabBarItem alloc]initWithTitle: @"Contacts" image:img tag:0];
        self.tabBarItem=tabItem;
    }
    return self;
}
-(void)exibeForm{
//    NSLog(@"llamada");
    
    
    FormularioContactoViewControlerViewController * form=[[FormularioContactoViewControlerViewController alloc] init];
//    form.aContactos=self.aContactos;
//    [self presentViewController:form animated:YES completion:nil];
    form.delegate=self;
    //inyextamos el contexto de base de datos
    form.contexto=self.contexto;
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(self.linhaSeleccionada >- 1){
        NSIndexPath * ip=[NSIndexPath indexPathForRow:self.linhaSeleccionada inSection:0];
        [self.tableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.tableView scrollToRowAtIndexPath:ip atScrollPosition: UITableViewScrollPositionNone animated: YES];
        self.linhaSeleccionada=-1;
    }
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
    form.delegate = self;
    [self.navigationController pushViewController:form animated:YES];
}
-(void) contactoAdicionado:(OMCContacto *)Contato{
    [self.aContactos addObject:Contato];
    self.linhaSeleccionada=[self.aContactos indexOfObject:Contato];
//    NSInteger indice=[self.aContactos indexOfObject:contato];
//    NSLog(@"Indice do contato: %d",indice);
}
-(void) contactoAlterado:(OMCContacto *)Contato{
    self.linhaSeleccionada=[self.aContactos indexOfObject:Contato];
    //NSInteger indice=[self.aContactos indexOfObject:contato];
    //NSLog(@"Indice do contato: %d",indice);
}
-(void) viewDidLoad{
    UILongPressGestureRecognizer * gr=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(exibeAcoes:)];
    [self.tableView addGestureRecognizer:gr];
}

-(void)exibeAcoes:(UIGestureRecognizer *) gesture{
    //se puede colocar en diferentes momentos de la accion
    if(gesture.state==UIGestureRecognizerStateBegan)
    {
        //no es un objeto es una struct
        CGPoint point=[gesture locationInView:self.tableView];
        NSIndexPath * ip=[self.tableView indexPathForRowAtPoint:point];
        contactoSeleccionado=self.aContactos[ip.row];
        UIActionSheet * as=[[UIActionSheet alloc] initWithTitle:contactoSeleccionado.nome delegate: self cancelButtonTitle:@"Cancela" destructiveButtonTitle:nil otherButtonTitles:@"Ligar",@"Enviar email",@"Visualizar site",@"Abrir mapa", nil];
        //genera problema de boton cancela
        //[as showInView:self.view];
        //vista donde mostramos la vixsta del tab, se tiene que utilizar para evitar problema de button cancela
        [as showFromTabBar:self.tabBarController.tabBar];
    }
}
-(void)abrirUrl:(NSString *)Url{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:Url]];
}
-(void)ligar{
    UIDevice * device = [UIDevice currentDevice];
    if([device.model isEqualToString:@"iPhone"]){
        NSString * telefono=[NSString stringWithFormat:@"tel:%@",contactoSeleccionado.telefono];
        [self abrirUrl:telefono];

    }
    else{
        UIAlertView * ar=[[UIAlertView alloc] initWithTitle:@"Pobre" message:@"Compra Iphone" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [ar show];
    }
}
-(void)visualizarSite{
    [self abrirUrl:contactoSeleccionado.site];
}
-(void)abrirMapa{
    //reemplazamos los caracateres especiales
    NSString * urlMapa=[[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@",contactoSeleccionado.endereco] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self abrirUrl:urlMapa];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;
        case 2:
            [self visualizarSite];
            break;
        case 3:
            [self abrirMapa];
            break;
        default:
            break;
    }
}
-(void) enviarEmail{
    //consultamos si podemos mandar email
    if([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController * mail=[[MFMailComposeViewController alloc] init];
        //seteamos delegate para obtener respuesta
        mail.mailComposeDelegate=self; //esto precisa asignacion de contrato
        //llamamos a un modal, muestra a tela de mail
        [mail setToRecipients:@[contactoSeleccionado.email]];
        [mail setSubject:@"caelum"];
        [self presentViewController:mail animated:YES completion:nil];
    }
    else{
        //mostramos alert de error
    }
}
//implementacion de delegate mail
-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    //retiramos pantalla de error si es que existiera
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
