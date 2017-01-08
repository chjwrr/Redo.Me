//
//  RDMYuLuCell.h
//  ModelProduct
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseCell.h"

@protocol RDMYuLuCellDelegate <NSObject>

- (void)didSelectRDMYuLuCellIndex:(NSInteger)cellIndex ItemIndex:(NSInteger)index;
- (void)didSelectRDMYuLuCellheadImage:(NSInteger)index;

@end

@interface RDMYuLuCell : BaseCell

@property (nonatomic,weak)id<RDMYuLuCellDelegate>delegate;
@property (nonatomic)BOOL isHiddent;

@end
