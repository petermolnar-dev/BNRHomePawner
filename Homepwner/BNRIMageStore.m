//
//  BNRIMageStore.m
//  Homepwner
//
//  Created by Peter Molnar on 29/04/2015.
//  Copyright (c) 2015 Peter Molnar. All rights reserved.
//

#import "BNRIMageStore.h"

@interface BNRIMageStore()

@property (strong, nonatomic) NSMutableDictionary *dictionary;

@end

@implementation BNRIMageStore

+(instancetype)sharedStore
{
    static BNRIMageStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

// No one should call init

-(instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRImagestore sharedStore]" userInfo:nil];
    return nil;
}

// Secret designated init
- (instancetype)initPrivate
{
    self = [super init];
    
    
    if (self) {
        _dictionary = [[NSMutableDictionary alloc]init];
    }
    return  self;
}

- (void) setImage:(UIImage *)image forKey:(NSString *)key {
    self.dictionary[key] = image;
}

-(UIImage *)imageForKey:(NSString *)key {
    return self.dictionary[key];
}

-(void)deleteImageForKey:(NSString *)key {
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
}

@end
