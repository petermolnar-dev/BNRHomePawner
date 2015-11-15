//
//  BNRItem.m
//  RandomItems
//
//  Created by Peter Molnar on 27/01/2015.
//  Copyright (c) 2015 Peter Molnar. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

+(instancetype)randomItem
{
    // Create an inmutable array of adjectives
    NSArray *randomAdjectiveList = @[@"Fluffy",@"Rusty",@"Shiny"];
    
    // Create an inmutable array of nouns
    NSArray *randomNounList = @[@"Bear", @"Spork", @"MAc"];
    
    // Get the index of a random adjective/noun from the list
    // NSInteger is not an objext just a typedef for long
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                            [randomAdjectiveList objectAtIndex:adjectiveIndex],
                            [randomNounList objectAtIndex:nounIndex]];
    int randomValue = arc4random() %100;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' +arc4random() % 10,
                                    'A' +arc4random() % 26,
                                    '0' +arc4random() % 10,
                                    'A' +arc4random() % 26,
                                    '0' +arc4random() % 10
                                    ];
    
    BNRItem *newItem = [[self alloc] initWithItemNAme:randomName
                                       valueInDollars:randomValue
                                         serialNumber:randomSerialNumber];
    return newItem;
}

- (instancetype)initWithItemNAme:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber {
    //Call the superclass's designated initializer
    self = [super init];
    
    // Did the superclass's designated initializer succeed?
    if (self)
    {
        _itemName = name;
        _serialNumber = sNumber;
        _valueInDollars = value;
        
        //Set dateCreated to the current date and time
        _dateCreated = [[NSDate alloc] init];
        
        // Create a NSUUID object abd get its sring representaion
        NSUUID *uuid = [[NSUUID alloc] init];
        NSString *key = [uuid UUIDString];
        _itemKey = key;
        
    }
    
    // REturn the address of the newly initialized object
    return self;
}
- (instancetype)initWithNAme:(NSString *)name {
    return [self initWithItemNAme:name
                   valueInDollars:0
                     serialNumber:@""];
}

-(instancetype)initWithNAme:(NSString *)name
               serialNumber:(NSString *)sNumber {
    return [self initWithItemNAme:name
                   valueInDollars:0
                     serialNumber:sNumber];
}

- (instancetype)init
{
    return [self initWithNAme:@"Item"];
}


- (NSString *)description
{
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
     self.itemName,
     self.serialNumber,
     self.valueInDollars,
     self.dateCreated];
    
    return descriptionString;
}



@end
