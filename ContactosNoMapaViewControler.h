//
//  ContactosNoMapaViewControler.h
//  ContactosLuis
//
//  Created by ios3729 on 05/11/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "OMCContacto.h"
@interface ContactosNoMapaViewControler : UIViewController<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *outLetMapa;
@property (weak,nonatomic) NSMutableArray *aContactos;
@end
