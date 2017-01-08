//
//  RGCollectionViewCell.h
//  RGCardViewLayout
//
//  Created by ROBERA GELETA on 1/23/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RGCollectionViewCellDelegate <NSObject>

- (void)didSelectRGCollectionViewCellImage:(NSInteger)index;

@end

@interface RGCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIImageView *imageview;
@property (strong, nonatomic) UILabel *lab_title;

@property (nonatomic,weak)id<RGCollectionViewCellDelegate>delegate;


- (void)cellForData:(id)data;
@end
