//
//  BNRIMageStore.h
//  Homepwner
//
//  Created by Peter Molnar on 29/04/2015.
//  Copyright (c) 2015 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
// UIImage is in UIKit
@import UIKit;

@interface BNRIMageStore : NSObject

+(instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;
@end
