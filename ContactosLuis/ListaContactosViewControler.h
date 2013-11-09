//
//  ListaContactosViewControler.h
//  ContactosLuis
//
//  Created by ios3729 on 31/10/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import "OMCContacto.h"

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "FormularioContactoViewControlerViewControllerDelegate.h"
//adicionamos los contratos del delgate, se tiene que implementar los mensajes de los delegates
@interface ListaContactosViewControler : UITableViewController <FormularioContactoViewControlerDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate>
    {
        OMCContacto * contactoSeleccionado;
    }
@property NSInteger linhaSeleccionada;
@property (weak,nonatomic) NSMutableArray *aContactos;
@property (weak) NSManagedObjectContext * contexto;

@end
