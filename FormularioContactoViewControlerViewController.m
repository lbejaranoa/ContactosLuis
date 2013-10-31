//
//  FormularioContactoViewControlerViewController.m
//  ContactosLuis
//
//  Created by ios3729 on 30/10/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import "FormularioContactoViewControlerViewController.h"
#import "OMCContacto.h"
@interface FormularioContactoViewControlerViewController ()

@end

@implementation FormularioContactoViewControlerViewController

-(id)init{
    self=[super init];
    if(self){
        self.aContactos=[[NSMutableArray alloc] init];
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pegaDadosDoFormulario:(id)sender {
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
    OMCContacto *contacto=[[OMCContacto alloc] init];
    contacto.nome=self.OutLetName.text;
    contacto.email=self.OutLetEmail.text;
    [self.aContactos addObject:contacto];
    NSLog(@"Nomes: %@",self.aContactos[0]);
    for(int i=0; i<[self.aContactos count];i++)
    {
//       contacto *c=[[self.aContactos indexOfAccessibilityElement:i];
    }
    
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
@end
