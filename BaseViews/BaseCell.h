//
//  BaseCell.h
//  ModelProduct
//
//  Created by chj on 15/12/30.
//  Copyright © 2015年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell

- (void)initSubViews;

- (void)cellForData:(id)data;

+ (CGFloat)cellHeightForData:(id)data;

+ (CGFloat)cellHeight;

@end
