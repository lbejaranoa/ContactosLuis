//
//  FormularioContactoViewControlerViewController.h
//  ContactosLuis
//
//  Created by ios3729 on 30/10/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormularioContactoViewControlerViewController : UIViewController
- (IBAction)pegaDadosDoFormulario:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *OutLetName;
@property (weak, nonatomic) IBOutlet UITextField *OutLetTelefono;
@property (weak, nonatomic) IBOutlet UITextField *OutLetEndereco;
@property (weak, nonatomic) IBOutlet UITextField *OutLetEmail;
@property (weak, nonatomic) IBOutlet UITextField *OutLetSite;
- (IBAction)proximoElemento:(UITextField *)campoActual;

@end
