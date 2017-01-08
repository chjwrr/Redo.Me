//
//  RDMWenZhangModel.h
//  ModelProduct
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseModel.h"

@interface RDMWenZhangModel : BaseModel

@property (nonatomic,strong)NSString *imageURL;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *detailURL;
@property (nonatomic,strong)NSString *type;//1.情感语录 2.一张照片


@end
