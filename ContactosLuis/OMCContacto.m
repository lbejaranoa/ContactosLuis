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

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.nome forKey:@"nome"];
    [aCoder encodeObject:self.telefono forKey:@"tel"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if(self){
        self.nome=[aDecoder decodeObjectForKey:@"nome"];
        self.telefono=[aDecoder decodeObjectForKey:@"tel"];
    }
    return self;
}

@end

