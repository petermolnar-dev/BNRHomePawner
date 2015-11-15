//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Peter Molnar on 14/03/2015.
//  Copyright (c) 2015 Peter Molnar. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRIMageStore.h"

@interface BNRItemStore()
@property (nonatomic) NSMutableArray *privateItems;
@end

@implementation BNRItemStore

+(instancetype)sharedStore {
    static BNRItemStore *sharedStore = nil;
    
    // Do I need to create a sharedStore?
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

// If a programmers calls init , let them know the error this way
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleto"
                                   reason:@"Use +[BNRItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

-(instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc]init];

    }
    
    return self;
}

- (NSArray *) allItems
{
    return self.privateItems;
    // With more rigid rules you can do like this
    // return [self.privateItems copy];
}

- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    
    return item;
}

- (void)removeItem:(BNRItem *)item
{
    NSString *key = item.itemKey;
    
    [[BNRIMageStore sharedStore] deleteImageForKey:key];
    [self.privateItems removeObjectIdenticalTo:item];
}


- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    //Get pointer to the object being moved so you can re-insert it
    BNRItem *item = self.privateItems[fromIndex];
    
    //Remove from array
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    //Insert the temp item to the new location
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end
