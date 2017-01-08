//
//  RDMWenZhangDetailTypeTwoViewController.m
//  ModelProduct
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "RDMWenZhangDetailTypeTwoViewController.h"
#import "RDMWenZhangDetailModel.h"
#import "UMSocialData.h"
#import "UMSocialSnsService.h"
#import "UMSocialControllerService.h"
#import "UMSocialSnsPlatformManager.h"

#define kYiZhangZhaoPianDetailHttp  @"https://news-at.zhihu.com/api/4/story/"


@interface RDMWenZhangDetailTypeTwoViewController ()<UMSocialUIDelegate>

@property (nonatomic,strong)RDMWenZhangDetailModel *model;
@property (nonatomic,strong)UIWebView *webView;

@end

@implementation RDMWenZhangDetailTypeTwoViewController

- (void)initDataSource {
    _model=[[RDMWenZhangDetailModel alloc]init];
}
- (void)initSubViews {
    
    [self initLeftNavigationBarButton];
    
    __weak RDMWenZhangDetailTypeTwoViewController *weakself=self;
    self.leftNavBarBlock=^{
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    
    [self initRithNavigationBarButtonWithImage:@"rdm_share"];
    self.rightNavBarBlock=^{
        [weakself share];
    };
    
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
    [self.view addSubview:_webView];
    _webView.opaque = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    

    [self getDetailData];
    
}

- (void)getDetailData {

    __weak RDMWenZhangDetailTypeTwoViewController *weakself=self;
    [[AFHTTPClickManager shareInstance] getRequestWithPath:[NSString stringWithFormat:@"%@%@",kYiZhangZhaoPianDetailHttp,_str_ID] params:nil isHeader:NO LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        weakself.model.body=kFormatterSring([respose objectForKey:@"body"]);
        weakself.model.title=kFormatterSring([respose objectForKey:@"title"]);
        weakself.model.share_url=kFormatterSring([respose objectForKey:@"share_url"]);

    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{
        
        [weakself uploadData];
        
    }];
    
}

- (void)uploadData {

    //图片适应屏幕
    self.model.body=[self.model.body stringByReplacingOccurrencesOfString:@"<img " withString:@"<img width=\"100%\""];
    [_webView loadHTMLString:self.model.body baseURL:nil];
    
    self.title=self.model.title;
}

/**
 *  分享
 */
- (void)share{
    /**
     *  微信分享设置
     */
    
    //当分享消息类型为图文时，点击分享内容会跳转到预设的链接，设置方法如下
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.model.share_url;
    
    //如果是朋友圈，则替换平台参数名即可
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.model.share_url;
    
    
    //设置微信好友title方法为
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"一张照片，一幅场景";
    
    //设置微信朋友圈title方法替换平台参数名即可
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = self.model.title;
    
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    

    
    /**
     *  QQ分享设置
     */
    
    //QQ设置点击分享内容跳转链接调用下面的方法
    [UMSocialData defaultData].extConfig.qqData.url = self.model.share_url;
    
    //Qzone设置点击分享内容跳转链接替换平台参数名即可
    [UMSocialData defaultData].extConfig.qzoneData.url = self.model.share_url;
    
    
    NSLog(@"self.model.share_url %@",self.model.share_url);
    //QQ设置title方法为
    [UMSocialData defaultData].extConfig.qqData.title = @"一篇文章，一个曾经";
    
    //Qzone设置title方法将平台参数名替换即可
    [UMSocialData defaultData].extConfig.qzoneData.title = @"一篇文章，一个曾经";
    
    
    // 如果是网络图片，需要设置
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:_imageURL];
    
    //分享内嵌图片
    //UIImage *shareImage = [UIImage imageNamed:@"rdm_shareIcon"];
    
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kUMAPPKEY
                                      shareText:self.model.title
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone]
                                       delegate:self];
}



//下面可以设置根据点击不同的分享平台，设置不同的分享文字
-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    //    if ([platformName isEqualToString:UMShareToSina]) {
    //        socialData.shareText = @"分享到新浪微博";
    //    }
    //    else{
    //        socialData.shareText = @"分享内嵌文字";
    //    }
}

-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType
{
    [self showMessage:@"分享已取消"];
}

//下面得到分享完成的回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        if ([[[response.data allKeys] objectAtIndex:0] isEqualToString:@"qzone"]) {
            [self showMessage:@"QQ空间分享成功"];
        }
        if ([[[response.data allKeys] objectAtIndex:0] isEqualToString:@"qq"]) {
            [self showMessage:@"QQ好友分享成功"];
        }
        if ([[[response.data allKeys] objectAtIndex:0] isEqualToString:@"wxsession"]) {
            [self showMessage:@"微信好友分享成功"];
        }
        if ([[[response.data allKeys] objectAtIndex:0] isEqualToString:@"wxtimeline"]) {
            [self showMessage:@"微信好友圈分享成功"];
        }

    }
}





@end
