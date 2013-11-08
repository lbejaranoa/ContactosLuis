//
//  FormularioContactoViewControlerViewController.h
//  ContactosLuis
//
//  Created by ios3729 on 30/10/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMCContacto.h"
#import "FormularioContactoViewControlerViewControllerDelegate.h"
#import <CoreLocation/CoreLocation.h>
//adicionamos dos contratos para tratamiento de imangen
@interface FormularioContactoViewControlerViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *OutLetName;
@property (weak, nonatomic) IBOutlet UITextField *OutLetTelefono;
@property (weak, nonatomic) IBOutlet UITextField *OutLetEndereco;
@property (weak, nonatomic) IBOutlet UITextField *OutLetEmail;
@property (weak, nonatomic) IBOutlet UITextField *OutLetSite;
//@property (weak,nonatomic) NSMutableArray *aContactos;
@property (strong) OMCContacto * contacto;
@property (weak)id<FormularioContactoViewControlerDelegate> delegate;
- (IBAction)proximoElemento:(UITextField *)campoActual;
-(id)initWithContacto:(OMCContacto *)contacto;
- (IBAction)buscarCoordenada:(id)sender;
- (IBAction)selecionaFoto:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *outLetLatitude;
@property (weak, nonatomic) IBOutlet UIButton *outLetBotonUbicar;
@property (weak, nonatomic) IBOutlet UITextField *outLetLongitude;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *outLetActivitiIndicator;
@property (weak, nonatomic) IBOutlet UIButton *botaoFoto;
//aqui inyectamos el contexto
@property (weak) NSManagedObject * contexto;
@end
