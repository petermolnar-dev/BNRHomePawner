//
//  CrossHairView.m
//  Homepwner
//
//  Created by Peter Molnar on 17/05/2015.
//  Copyright (c) 2015 Peter Molnar. All rights reserved.
//

#import "CrossHairView.h"

@implementation CrossHairView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]]; // This view needs to be transparent
    }
    
         return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bounds =[self bounds];
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    CGContextSetLineWidth(ctx, 1);
    
    [[UIColor redColor] setStroke];
    
    CGContextMoveToPoint(ctx, center.x - 20, center.y);
    CGContextAddLineToPoint(ctx, center.x + 20, center.y);
    CGContextMoveToPoint(ctx, center.x, center.y - 20);
    CGContextAddLineToPoint(ctx, center.x, center.y +20) ;
    
    CGContextStrokePath(ctx);
}

// This is required and critical to release the gestures capture to the real UIImagePickerView

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return NO;
}

@end
