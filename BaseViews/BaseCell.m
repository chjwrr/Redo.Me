//
//  BaseCell.m
//  ModelProduct
//
//  Created by chj on 15/12/30.
//  Copyright © 2015年 chj. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews {
    
}

- (void)cellForData:(id)data {
    
}

+ (CGFloat)cellHeightForData:(id)data {
    return 44;
}

+ (CGFloat)cellHeight {
    return 44;
}
@end
