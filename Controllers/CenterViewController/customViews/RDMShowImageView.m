//
//  RDMShowImageView.m
//  ModelProduct
//
//  Created by apple on 16/8/24.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "RDMShowImageView.h"

@interface RDMShowImageView ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIImageView *bgimageView;

@property (nonatomic,strong)UILabel *lab_content;
@property (nonatomic,strong)UIView *labView;
@property (nonatomic,strong)UIImageView *bglabImageView;


@property (nonatomic,strong)UIImageView *imageView1;
@property (nonatomic,strong)NSString *imageUrl;

@property (nonatomic)CGRect imageRect;
@end

@implementation RDMShowImageView

+ (instancetype)shareInstance{
    static RDMShowImageView *scanView=nil;
    static dispatch_once_t patch;
    dispatch_once(&patch, ^{
        scanView=[[RDMShowImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    });
    
    return scanView;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    _imageUrl=[[NSString alloc]init];
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    [self addSubview:self.scrollView];
    _scrollView.delegate=self;
    _scrollView.multipleTouchEnabled=YES;
    _scrollView.minimumZoomScale=0.5;
    _scrollView.maximumZoomScale=2;
    _scrollView.backgroundColor=[UIColor blackColor];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dimissSelf)];
    [_scrollView addGestureRecognizer:tap];
    
    _bgimageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    //_bgimageView.backgroundColor=[UIColor blackColor];
    [_scrollView addSubview:_bgimageView];

    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_scrollView addSubview:_imageView];

    _labView=[[UILabel alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, 0)];
    [self addSubview:_labView];
    
    _bglabImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 0)];
    _bglabImageView.backgroundColor=[UIColor blackColor];
    _bglabImageView.alpha=0.5;
    [_labView addSubview:_bglabImageView];

    _lab_content=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, kSCREEN_WIDTH, 0)];
    [_labView addSubview:_lab_content];
    _lab_content.font=kSYS_FONT(14);
    _lab_content.textColor=[UIColor whiteColor];
    _lab_content.numberOfLines=0;
}

- (void)showWithBeginRect:(CGRect)rect imageURL:(NSString *)imageUrl content:(NSString *)content{
    self.alpha=1.0;

    _imageUrl=imageUrl;
    CGFloat contentH=[content getStringHeightSizeWidth:kSCREEN_WIDTH-20 WithFontSize:14]+40;
    
    _labView.frame=CGRectMake(0, kSCREEN_HEIGHT-contentH/2-20, kSCREEN_WIDTH, 0);
    _bglabImageView.frame=CGRectMake(0, 0, kSCREEN_WIDTH, 0);
    _lab_content.frame=CGRectMake(10, 0, kSCREEN_WIDTH, 0);

    _lab_content.text=content;
    
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    _imageRect=rect;

    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    
    
    _imageView.frame=rect;

    [UIView animateWithDuration:0.5 animations:^{
        _imageView.frame=CGRectMake(0, (kSCREEN_HEIGHT-_imageView.height)/2, _imageView.width, _imageView.height);
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.25 animations:^{
                _labView.frame=CGRectMake(0, kSCREEN_HEIGHT-contentH-20, kSCREEN_WIDTH, contentH);
                _bglabImageView.frame=CGRectMake(0, 0, _labView.width, _labView.height);
                _lab_content.frame=CGRectMake(10, 0, kSCREEN_WIDTH-20, _labView.height);
            } completion:^(BOOL finished) {
                if (finished) {
                }
            }];
        }
    }];
    
}

- (void)dimissSelf {
    __weak RDMShowImageView *weakself=self;

    [UIView animateWithDuration:0.25 animations:^{
        [_scrollView setZoomScale:1.0];
        
    } completion:^(BOOL finished) {
        if (finished) {
            
            [UIView animateWithDuration:0.25 animations:^{
                self.alpha=0.0;
            } completion:^(BOOL finished) {
                if (finished) {
                    [self removeFromSuperview];
                    [_imageView1 removeFromSuperview];
                    _imageView1 = nil;
                    
                    
                    
                    _imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, (kSCREEN_HEIGHT-_imageRect.size.height)/2, _imageRect.size.width, _imageRect.size.height)];
                    [_imageView1 sd_setImageWithURL:[NSURL URLWithString:_imageUrl]];
                    
                    [[[[UIApplication sharedApplication] delegate] window] addSubview:_imageView1];
                    
                    
                    [UIView animateWithDuration:0.5 animations:^{
                        _imageView1.frame=_imageRect;
                    } completion:^(BOOL finished) {
                        
                        if (finished) {
                            weakself.dimissSucessBlock();
                            
                            [_imageView1 removeFromSuperview];
                        }
                    }];

                }
            }];
            
            
          
            
            
            /*
            _labView.frame=CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, 0);
            _bglabImageView.frame=CGRectMake(0, 0, kSCREEN_WIDTH, 0);
            _lab_content.frame=CGRectMake(10, 0, kSCREEN_WIDTH-20, 0);
            
            
            
            [UIView animateWithDuration:0.5 animations:^{
                _imageView.frame=_imageRect;
            } completion:^(BOOL finished) {
                
                weakself.dimissSucessBlock();
                
                [self removeFromSuperview];
                if (finished) {
                   
                }
            }];
            */
        }
    }];
    
   
}

#pragma mark - UIScrollView 的 代理方法
#pragma mark 这个方法返回的控件就能进行捏合手势缩放操作
#pragma mark 当UIScrollView尝试进行缩放的时候就会调用
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}
#pragma mark 当缩放完毕的时候调用

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
}


#pragma mark 当正在缩放的时候调用
//实现图片在缩放过程中居中

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
    self.imageView.center = CGPointMake(scrollView.contentSize.width/2 + offsetX,scrollView.contentSize.height/2 + offsetY);
}

@end

