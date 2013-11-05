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

@interface FormularioContactoViewControlerViewController : UIViewController

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
@end
