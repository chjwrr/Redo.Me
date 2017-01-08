//
//  RDMShowImageView.h
//  ModelProduct
//
//  Created by apple on 16/8/24.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseView.h"

typedef void(^RDMShowImageViewBlock)(void);

@interface RDMShowImageView : BaseView

@property (nonatomic,copy)RDMShowImageViewBlock dimissSucessBlock;

+ (instancetype)shareInstance;

- (void)showWithBeginRect:(CGRect)rect imageURL:(NSString *)imageUrl content:(NSString *)content;

@end
