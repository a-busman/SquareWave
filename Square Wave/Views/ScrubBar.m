//
//  ScrubBar.m
//  Square Wave
//
//  Created by Alex Busman on 5/17/18.
//  Copyright © 2018 Alex Busman. All rights reserved.
//

#import "ScrubBar.h"

@implementation ScrubBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)trackRectForBounds:(CGRect)bounds {
    CGRect newBounds = [super trackRectForBounds:bounds];
    newBounds.size.height = 3;
    return newBounds;
}

@end
