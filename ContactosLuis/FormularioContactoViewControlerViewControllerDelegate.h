//
//  FormularioContactoViewControlerViewControllerDelegate.h
//  ContactosLuis
//
//  Created by ios3729 on 04/11/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OMCContacto.h"

@interface FormularioContactoViewControlerViewControllerDelegate : UIResponder<UIApplicationDelegate>

@end
@protocol FormularioContactoViewControlerDelegate<NSObject>
-(void) contactoAdicionado:(OMCContacto *) Contato;
-(void) contactoAlterado:(OMCContacto *) Contato;
@end