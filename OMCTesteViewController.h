//
//  OMCTesteViewController.h
//  ContactosLuis
//
//  Created by ios3729 on 08/11/13.
//  Copyright (c) 2013 infinitodhd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OMCContacto.h"

@interface OMCTesteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak) NSMutableArray *contatos;

@end
