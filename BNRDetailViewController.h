//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by Peter Molnar on 08/04/2015.
//  Copyright (c) 2015 Peter Molnar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNRItem;

@interface BNRDetailViewController : UIViewController
@property (nonatomic, strong) BNRItem *item;


-(IBAction)toggleCreationDateView:(id)sender;


@end
