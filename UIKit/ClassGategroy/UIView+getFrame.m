//
//  UIView+getFrame.m
//  ModelProduct
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "UIView+getFrame.h"

@implementation UIView (getFrame)


- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

@end
