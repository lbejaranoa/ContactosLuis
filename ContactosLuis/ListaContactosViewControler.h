//
//  ListaContactosViewControler.h
//  ContactosLuis
//
//  Created by ios3729 on 31/10/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FormularioContactoViewControlerViewControllerDelegate.h"

@interface ListaContactosViewControler : UITableViewController <FormularioContactoViewControlerDelegate,UIActionSheetDelegate>
{
    OMCContacto * contactoSeleccionado;
}
@property NSInteger linhaSeleccionada;
@property (weak,nonatomic) NSMutableArray *aContactos;
@end
