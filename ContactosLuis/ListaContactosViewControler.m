//
//  ListaContactosViewControler.m
//  ContactosLuis
//
//  Created by ios3729 on 31/10/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import "ListaContactosViewControler.h"

@implementation ListaContactosViewControler
-(id)init{
    self=[super init];
    if(self){
        self.navigationItem.title=@"Contactos";
        UIBarButtonItem * btnNav=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeForm)];
        self.navigationItem.rightBarButtonItem=btnNav;
    }
    return self;
}
-(void)exibeForm{
    NSLog(@"llamada");
}

@end
