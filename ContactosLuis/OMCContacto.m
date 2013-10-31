//
//  OMCContacto.m
//  ContactosLuis
//
//  Created by ios3729 on 30/10/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import "OMCContacto.h"

@implementation OMCContacto
-(NSString *) description{
    return [NSString stringWithFormat:@"%@<%@>,%@",self.nome,self.email,[super description]];
}


@end
