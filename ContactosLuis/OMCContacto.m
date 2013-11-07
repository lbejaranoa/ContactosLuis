//
//  OMCContacto.m
//  ContactosLuis
//
//  Created by ios3729 on 30/10/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import "OMCContacto.h"

@implementation OMCContacto

//adicionamos getter de propiedades de contrato de mapa
-(CLLocationCoordinate2D) coordinate{
    //construimos la struct CLLocation las estructuras tienen Make,
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

-(NSString *)title{
    return self.nome;
}
-(NSString *)subtitle{
    return self.email;
}
-(NSString *) description{
    return [NSString stringWithFormat:@"%@<%@>,%@",self.nome,self.email,[super description]];
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    //aqui es donde serializamos el objeto
    [aCoder encodeObject:self.nome forKey:@"nome"];
    [aCoder encodeObject:self.telefono forKey:@"tel"];
    [aCoder encodeObject:self.email forKey:@"ema"];
    [aCoder encodeObject:self.site forKey:@"sit"];
    [aCoder encodeObject:self.endereco forKey:@"end"];
    [aCoder encodeObject:self.foto forKey:@"fot"];
    [aCoder encodeObject:self.latitude forKey:@"lat"];
    [aCoder encodeObject:self.longitude forKey:@"lon"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    //realizamos la carga de la informacion serializada
    self=[super init];
    if(self){
        self.nome=[aDecoder decodeObjectForKey:@"nome"];
        self.telefono=[aDecoder decodeObjectForKey:@"tel"];
        self.email=[aDecoder decodeObjectForKey:@"ema"];
        self.site=[aDecoder decodeObjectForKey:@"sit"];
        self.endereco=[aDecoder decodeObjectForKey:@"end"];
        self.foto=[aDecoder decodeObjectForKey:@"fot"];
        self.latitude=[aDecoder decodeObjectForKey:@"lat"];
        self.longitude=[aDecoder decodeObjectForKey:@"lon"];
    }
    return self;
}

@end

