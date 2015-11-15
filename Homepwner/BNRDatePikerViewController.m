//
//  BNRDatePikerViewController.m
//  Homepwner
//
//  Created by Peter Molnar on 14/04/2015.
//  Copyright (c) 2015 Peter Molnar. All rights reserved.
//

#import "BNRDatePikerViewController.h"
#import "BNRItem.h"

@interface BNRDatePikerViewController ()
@property (strong, nonatomic) IBOutlet UIDatePicker *creationDate;


@end

@implementation BNRDatePikerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.creationDate.date = self.item.dateCreated;
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
   
    
    self.item.dateCreated = self.creationDate.date;
}

@end
