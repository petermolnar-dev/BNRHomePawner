//
//  BNRItem.h
//  RandomItems
//
//  Created by Peter Molnar on 27/01/2015.
//  Copyright (c) 2015 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject


@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, strong) NSDate *dateCreated;

@property (nonatomic, copy) NSString *itemKey;


// Class method, signed with +
+(instancetype)randomItem;

// Designated initializer for BNRItem
-(instancetype)initWithItemNAme:(NSString *)name
                 valueInDollars:(int)value
                   serialNumber:(NSString *)sNumber;

-(instancetype)initWithNAme:(NSString *)name;
-(instancetype)initWithNAme:(NSString *)name serialNumber:(NSString *)sNumber;


@end
