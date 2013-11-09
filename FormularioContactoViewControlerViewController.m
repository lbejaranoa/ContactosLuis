//
//  FormularioContactoViewControlerViewController.m
//  ContactosLuis
//
//  Created by ios3729 on 30/10/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import "FormularioContactoViewControlerViewController.h"

@interface FormularioContactoViewControlerViewController ()

@end

@implementation FormularioContactoViewControlerViewController
-(id)init{
    self=[super init];
    if(self){
        //self.aContactos=[[NSMutableArray alloc] init];
        self.navigationItem.title=@"cadastro";
        UIBarButtonItem * btnCadastro=[[UIBarButtonItem alloc] initWithTitle:@"Adiciona" style:UIBarButtonItemStylePlain target:self action:@selector(criaContacto)];
        //[self.navigationItem.rightBarButtonItem=btnCadastro];
        self.navigationItem.rightBarButtonItem=btnCadastro;
    }
    return self;
}
-(id)initWithContacto:(OMCContacto *)contacto{
    self=[super init];
    if(self){
        self.contacto=contacto;
        self.navigationItem.title=@"Alteracion";UIBarButtonItem * btnCadastro=[[UIBarButtonItem alloc] initWithTitle:@"Altera" style:UIBarButtonItemStylePlain target:self action:@selector(alterContacto)];
            //[self.navigationItem.rightBarButtonItem=btnCadastro];
        self.navigationItem.rightBarButtonItem=btnCadastro;
    }
    return self;
}

- (IBAction)buscarCoordenada:(id)sender {
   //iniciamos activiti indicator
    [self.outLetActivitiIndicator startAnimating];
    //ocultamos boton
    self.outLetBotonUbicar.hidden=YES;
    //buscamos latitud y longitud de endereco
    //utilizamos un web service de apple para realizar la funcionalidad
    //utilizamos geocode e reverso para esto adicionamos corelocation se tiene que adicionar al proyecto el framework
    //existe un objeto que hace geocoder CLGeocoder es assincrono, si fico esperando es polling, si pido que avise cuando termine se llama callback, dentro de completionhandler se coloca el codigo que quiere que ejecute
    
    CLGeocoder * geocoder=[[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:self.OutLetEndereco.text completionHandler: ^(NSArray * resultados,NSError * error)
        {
            //verificamos los resultados y el error
            if(error==nil&&[resultados count]>0){
                //recibimos el resultado
                CLPlacemark * result =resultados[0];
                //obtenemos la coordenada no tiene asterisco por que es un struct de c
                CLLocationCoordinate2D coordenada=result.location.coordinate;
                //obtenemos latitude y longitude transformamos tipos
                self.outLetLatitude.text=[NSString stringWithFormat:@"%f",coordenada.latitude];
                self.outLetLongitude.text=[NSString stringWithFormat:@"%f",coordenada.longitude];
                [self.outLetActivitiIndicator stopAnimating];
                self.outLetBotonUbicar.hidden=NO;
            }
        }
     ];
}

- (IBAction)selecionaFoto:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController * picker=[[UIImagePickerController alloc]init];
        //le decimos que la imagen viene de la camara
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        //permite editar imagen
        picker.allowsEditing=YES;
        // mostramos en modal para escojer imagen
        [self presentViewController:picker animated: YES completion:nil];
    }
    else{
        UIImagePickerController * picker=[[UIImagePickerController alloc]init];
        //le decimos que la imagen viene de la galeria
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        //permite editar imagen
        picker.allowsEditing=YES;
        picker.delegate=self;
        // mostramos en modal para escojer imagen
        [self presentViewController:picker animated: YES completion:nil];
    }
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
    //este es el evento que muestra la pantalla
    [super viewDidLoad];
    if(self.contacto)
    {
        self.OutLetName.text=self.contacto.nome;
        self.OutLetTelefono.text=self.contacto.telefono;
        self.OutLetEmail.text=self.contacto.email;
        self.OutLetSite.text=self.contacto.site;
        self.OutLetEndereco.text=self.contacto.endereco;
        self.outLetLatitude.text= [self.contacto.latitude stringValue];
        self.outLetLongitude.text= [self.contacto.longitude stringValue];
    }
    
    //verificamos la foto para mostrarla
    if(self.contacto.foto){
        [self.botaoFoto setImage:self.contacto.foto forState:UIControlStateNormal];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (OMCContacto *)pegaDadosDoFormulario {
    /*
    NSString * nome=self.OutLetName.text;
    NSString * telefone=self.OutLetTelefono.text;
    NSString * endereco=self.OutLetEndereco.text;
    NSString * email=self.OutLetEmail.text;
    NSString * site=self.OutLetSite.text;
    NSMutableDictionary * contacto=[[NSMutableDictionary alloc] init];
    [contacto setObject:nome forKey:@"nome"];
    [contacto setObject:telefone forKey:@"telefone"];
    [contacto setObject:endereco forKey:@"endereco"];
    [contacto setObject:email forKey:@"email"];
    [contacto setObject:site forKey:@"site"];
    NSLog(@"Contacto adicionado: %@",contacto);
     */
    //OMCContacto * contacto=[[OMCContacto alloc] init];
       
    //[self.view endEditing:YES];
    //NSLog(@"Contacto adicionado:%@",contacto);
    //capitulo 6
    //NSMutableArray *aNomes=[[NSMutableArray alloc] initWithObjects:@"fulano",@"beltrano",@"ciltrano",nil];
    //[aNomes addObject:@"Wayne"];
    //[aNomes addObject:@"Ballmer"];
    //NSLog(@"Nomes: %@",self.aContactos);
    
    if(!self.contacto){
        //self.contacto=[[OMCContacto alloc] init];
        //por core data por padron no existe objeto no gerenciado
        self.contacto =[NSEntityDescription insertNewObjectForEntityForName:@"Contacto" inManagedObjectContext:self.contexto];
    }
    //verificamos si usuario escojio foto
    if(self.botaoFoto.imageView.image){
        self.contacto.foto=self.botaoFoto.imageView.image;
    }
    //OMCContacto *contacto=[self pegaDadosDoFormulario];
    self.contacto.nome=self.OutLetName.text;
    self.contacto.email=self.OutLetEmail.text;
    self.contacto.site=self.OutLetSite.text;
    self.contacto.endereco=self.OutLetEndereco.text;
    self.contacto.telefono=self.OutLetTelefono.text;
    self.contacto.latitude= [NSNumber numberWithFloat:[self.outLetLatitude.text floatValue]];
    self.contacto.longitude= [NSNumber numberWithFloat:[self.outLetLongitude.text floatValue]];;
    return self.contacto;
    //[self.aContactos addObject:contacto];
    //NSLog(@"Nomes: %@",self.aContactos[0]);
    //for(int i=0; i<[self.aContactos count];i++)
    //{
        //contacto *c=[[self.aContactos indexOfAccessibilityElement:i];
    //}
    //for(OMCContacto * c in self.aContactos)
    //{
    //  NSLog(@"nome:%@",c.nome);
    //}
    //[self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)proximoElemento:(UITextField *)campoActual {
    //if(campoActual==self.OutLetName){
    //    [self.OutLetTelefono becomeFirstResponder];
    //}
    NSInteger proximaTag=campoActual.tag+1;
    UIResponder * proximoCampo =[self.view viewWithTag:proximaTag];
    if(proximoCampo!=nil){
        [proximoCampo becomeFirstResponder];
    }
    else{
        [campoActual resignFirstResponder];
    }
}

-(void)criaContacto{
    OMCContacto *contacto=[self pegaDadosDoFormulario];
        
    //[self.aContactos addObject:contacto];
    //NSLog(@"Nomes: %@",self.aContactos[0]);
    //for(OMCContacto * c in self.aContactos)
    //{
        //NSLog(@"nome:%@",c.nome);
    //}
    if ([self.delegate respondsToSelector:@selector(contactoAdicionado:)]) {
        [self.delegate contactoAdicionado:contacto];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)alterContacto{
    //[self pegaDadosDoFormulario];
    //[self.navigationController popViewControllerAnimated:YES];
    [self pegaDadosDoFormulario];
    if([self.delegate respondsToSelector:@selector(contactoAlterado:)])
    {
        [self.delegate contactoAlterado:self.contacto];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage * foto=info[UIImagePickerControllerEditedImage];
    //seleccion foto
    [self.botaoFoto setImage:foto forState:UIControlStateNormal];
    //cerramos modal
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end