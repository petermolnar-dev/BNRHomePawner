//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Peter Molnar on 14/03/2015.
//  Copyright (c) 2015 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

//Notice that this is a class method prefixed with + sign

+ (instancetype)sharedStore;
- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;
@end
