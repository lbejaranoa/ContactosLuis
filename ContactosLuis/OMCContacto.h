//
//  OMCContacto.h
//  ContactosLuis
//
//  Created by ios3729 on 30/10/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
//adicionamis el contrato para el mapa
//@interface OMCContacto : NSObject <NSCoding,MKAnnotation>
//mudamos herencia para convertir a objeto gerenciado
@interface OMCContacto : NSManagedObject <NSCoding,MKAnnotation>
@property (strong,nonatomic) NSString * nome;
@property (strong,nonatomic) NSString * telefono;
@property (strong,nonatomic) NSString * email;
@property (strong,nonatomic) NSString * endereco;
@property (strong,nonatomic) NSString * site;
//clase que fica en un numero,
@property (strong,nonatomic) NSNumber * latitude;
@property (strong,nonatomic) NSNumber * longitude;

@property(strong) UIImage * foto;
@end
