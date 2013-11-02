//
//  OMCContacto.h
//  ContactosLuis
//
//  Created by ios3729 on 30/10/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMCContacto : NSObject <NSCoding>

@property (strong,nonatomic) NSString * nome;
@property (strong,nonatomic) NSString * telefono;
@property (strong,nonatomic) NSString * email;
@property (strong,nonatomic) NSString * endereco;
@property (strong,nonatomic) NSString * site;

@end
