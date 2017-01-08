//
//  RDMYuLuViewController.m
//  ModelProduct
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "RDMYuLuViewController.h"
#import "RDMYuLuCell.h"
#import "RDMYuLuModel.h"
#import "RDMShowImageView.h"


#import "UMSocialData.h"
#import "UMSocialSnsService.h"
#import "UMSocialControllerService.h"
#import "UMSocialSnsPlatformManager.h"

#define kspace_height   5


//早安晚安语录列表接口,不支持https
#define kZaoAnWanAnHTTP       @"http://114.55.128.192:800/article/getpage?cateid=3&siteid=1"

//暖心美文首页列表接口,不支持https
#define kNuanXinMeiWenHttp    @"http://hl.51wnl.com/upgrade/dayword/getdayword.ashx"

//一张照片首页列表接口,支持https
#define kYiZhangZhaoPianHTTP  @"https://qianming.sinaapp.com/index.php/AndroidApi10/index/cid/qutu/lastId/"

@interface RDMYuLuViewController ()<UITableViewDataSource,UITableViewDelegate,RDMYuLuCellDelegate,UMSocialUIDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic)NSInteger currentPage;

@property (nonatomic,strong)NSString *lastID;
@end

@implementation RDMYuLuViewController

- (void)initDataSource {
    _currentPage = 1;
    _lastID=[[NSString alloc]init];
    _lastID=@"0";

    _dataSource=[[NSMutableArray alloc]init];
    
}

/**
 *  获取随机时间
 *
 *  @return 返回随机时间字符串
 */
- (NSString*)getRandomTime{
    
    /*
     2014-2016
     
     01-12
     
     01-28
     
     */
    int yyyy=arc4random()%3+2014;
    
    int mm=arc4random()%12+1;
    
    int dd=arc4random()%28+1;
    
    NSString *string=[NSString stringWithFormat:@"%d-%02d-%02d",yyyy,mm,dd];

    return string;
    
}


- (void)initSubViews {
    
    self.view.backgroundColor=[UIColor greenColor];
    
    
    [self.view addSubview:self.tableView];
    
    
    [_tableView.mj_header beginRefreshing];
    
    
    NSMutableArray *cacheData=[[FMDBManager shareInstance] searchDataFMDBWithTableName:kTableName];
    
    
    for (NSDictionary *diction in cacheData) {

        RDMYuLuModel *model=[[RDMYuLuModel alloc]init];
        model.imageURL=kFormatterSring([diction objectForKey:@"imageURL"]);
        model.content=kFormatterSring([diction objectForKey:@"content"]);
        model.imageHeight=kFormatterSring([diction objectForKey:@"imageHeight"]);
        model.imageWidht=kFormatterSring([diction objectForKey:@"imageWidht"]);
        model.str_id=kFormatterSring([diction objectForKey:@"id"]);
        
        [_dataSource addObject:model];
    }
    
    [_tableView reloadData];
    
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:_tableView];

        _tableView.mj_header=[self addTableViewHeaderRefreshingTarget:self refreshingAction:@selector(refrehData)];
        _tableView.mj_footer=[self addTableViewFooterRefreshingTarget:self refreshingAction:@selector(loadMore)];
    }
    return _tableView;
}

-(void)refrehData{
    [self footerRefreshHiddent:NO];
    
    _currentPage = 1;
    _lastID=@"0";
    
    
    [self getYiZhangZhaoPianData];
}

-(void)loadMore{
    
    if ([_dataSource count] != 0) {
        _currentPage++;
        
        
        RDMYuLuModel *model=[_dataSource lastObject];
        
        _lastID=model.str_id;

        
        [self getYiZhangZhaoPianData];

    }
    
}


#pragma  mark TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RDMYuLuCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RDMYuLuCell"];
    
    if (!cell) {
        
        cell=[[RDMYuLuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RDMYuLuCell"];
        
    }
    
    
    if ([_dataSource count] != 0) {
        cell.delegate=self;
        cell.tag=10*indexPath.row;
        RDMYuLuModel*model=_dataSource[indexPath.row];
        [cell cellForData:model];
    }
     
    
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_dataSource count] == 0) {
        return 0;
    }
    RDMYuLuModel*model=_dataSource[indexPath.row];

    return [RDMYuLuCell cellHeightForData:model];
}


/**
 *  RDMYuLuCellDelegate
 *
 *  @param index
 */
- (void)didSelectRDMYuLuCellIndex:(NSInteger)cellIndex ItemIndex:(NSInteger)index {
    RDMYuLuModel*model=_dataSource[cellIndex];

    switch (index) {
        case 3:{
            //分享
            
            [self shareText:model.content imageURL:model.imageURL];
            
        }
            break;
        case 2:{
            //下载
            
            NSData *imagedata=[NSData dataWithContentsOfURL:[NSURL URLWithString:model.imageURL]];
            UIImage *image=[UIImage imageWithData:imagedata];
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

        }
            break;
        default:
            break;
    }
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        // Show error message...
        [self showMessage:@"图片保存失败,请开启照片权限"];

        
    }
    else  // No errors
    {
        [self showMessage:@"图片保存成功"];
    }
}



/**
 *  RDMYuLuCellDelegate
 *
 *  @param 点击图片 index
 */
- (void)didSelectRDMYuLuCellheadImage:(NSInteger)index {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kshownormalMenu object:nil];
    
    RDMYuLuModel*model=_dataSource[index];
    
    NSIndexPath *indexP=[NSIndexPath indexPathForRow:index inSection:0];
    
    
    RDMYuLuCell *selectCell=(RDMYuLuCell *)[_tableView cellForRowAtIndexPath:indexP];
    
    selectCell.isHiddent=YES;
    
    //cell相对于tableview的位置
    CGRect rect= [_tableView rectForRowAtIndexPath:indexP];
    
    //cell相对于屏幕的位置
    CGRect rect1= [_tableView convertRect:rect toView:[_tableView superview]];
    
    CGFloat imageH=kFormatterSring(model.imageHeight).floatValue;
    CGFloat imageW=kFormatterSring(model.imageWidht).floatValue;
    CGFloat height=kSCREEN_WIDTH*imageH/imageW;
    
    //cell里面的图片相对于屏幕的位置
    CGRect imageRect=CGRectMake(0, 64+rect1.origin.y+kspace_height, kSCREEN_WIDTH, height);
    
    [[RDMShowImageView shareInstance] showWithBeginRect:imageRect imageURL:model.imageURL content:model.content];
    [RDMShowImageView shareInstance].dimissSucessBlock=^{
        selectCell.isHiddent=NO;
    };
}


/**
 *  一张照片
 */
- (void)getYiZhangZhaoPianData {
    
    __weak RDMYuLuViewController *weakself=self;
    [[AFHTTPClickManager shareInstance] postRequestWithPath:[NSString stringWithFormat:@"%@%@",kYiZhangZhaoPianHTTP,_lastID] params:nil isHeader:NO LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {
    
        if ([_lastID isEqualToString:@"0"]) {
            
            //第一次,移除缓存数据
            [_dataSource removeAllObjects];
            
            
            NSArray *data=[respose objectForKey:@"rows"];
            
            for (int i=0; i<[data count]; i++) {
                RDMYuLuModel *model=[[RDMYuLuModel alloc]init];
                
                NSDictionary *diction=[data objectAtIndex:i];
                if (![kFormatterSring([diction objectForKey:@"pic"]) isEmpty]) {
                    model.imageURL=kFormatterSring([diction objectForKey:@"pic"]);
                    model.content=kFormatterSring([diction objectForKey:@"title"]);
                    model.imageHeight=kFormatterSring([diction objectForKey:@"pic_h"]);
                    model.imageWidht=kFormatterSring([diction objectForKey:@"pic_w"]);
                    model.str_id=kFormatterSring([diction objectForKey:@"id"]);
                    
                    [_dataSource addObject:model];
                    
                    if (![[FMDBManager shareInstance] searchDataFMDBWithTableName:kTableName ID:kFormatterSring([diction objectForKey:@"id"])]) {
                        [[FMDBManager shareInstance] insertDataToFMDBWithTableName:kTableName ID:kFormatterSring([diction objectForKey:@"id"]) imageURL:kFormatterSring([diction objectForKey:@"pic"]) content:kFormatterSring([diction objectForKey:@"title"]) imageHeight:kFormatterSring([diction objectForKey:@"pic_h"]) imageWidht:kFormatterSring([diction objectForKey:@"pic_w"])];

                    }
                    

                }
            }

        }else{

            id array=respose;
            
            NSArray *data=[NSArray arrayWithArray:array];
            
            for (int i=0; i<[data count]; i++) {
                RDMYuLuModel *model=[[RDMYuLuModel alloc]init];
                
                NSDictionary *diction=[data objectAtIndex:i];
                if (![kFormatterSring([diction objectForKey:@"pic"]) isEmpty]) {
                    model.imageURL=kFormatterSring([diction objectForKey:@"pic"]);
                    model.content=kFormatterSring([diction objectForKey:@"title"]);
                    model.imageHeight=kFormatterSring([diction objectForKey:@"pic_h"]);
                    model.imageWidht=kFormatterSring([diction objectForKey:@"pic_w"]);
                    model.str_id=kFormatterSring([diction objectForKey:@"id"]);
                    
                    [_dataSource addObject:model];
                    
                    if (![[FMDBManager shareInstance] searchDataFMDBWithTableName:kTableName ID:kFormatterSring([diction objectForKey:@"id"])]) {
                        [[FMDBManager shareInstance] insertDataToFMDBWithTableName:kTableName ID:kFormatterSring([diction objectForKey:@"id"]) imageURL:kFormatterSring([diction objectForKey:@"pic"]) content:kFormatterSring([diction objectForKey:@"title"]) imageHeight:kFormatterSring([diction objectForKey:@"pic_h"]) imageWidht:kFormatterSring([diction objectForKey:@"pic_w"])];
                    }

                }
            }

        }
        
    } FailureBlock:^(NSError *error) {
        [weakself endRefresh];

    } FinishBlock:^{
        [weakself getNunXinMeiWenData];

    }];
    
}

/**
 *  暖心美文
 */

- (void)getNunXinMeiWenData {
    __weak RDMYuLuViewController *weakself=self;

    [[AFHTTPClickManager shareInstance] postRequestWithPath:kNuanXinMeiWenHttp params:@{@"count":@"50",@"daystr":[self getRandomTime]} isHeader:NO LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        id array=respose;
        
        NSArray *data=[NSArray arrayWithArray:array];
        
        for (int i=0; i<[data count]; i++) {
            RDMYuLuModel *model=[[RDMYuLuModel alloc]init];
            
            NSDictionary *diction=[data objectAtIndex:i];
            model.imageURL=kFormatterSring([diction objectForKey:@"RealUrl"]);
            model.content=kFormatterSring([diction objectForKey:@"Title"]);
            model.imageHeight=kFormatterSring([diction objectForKey:@"Height"]);
            model.imageWidht=kFormatterSring([diction objectForKey:@"Width"]);
            model.str_id=kFormatterSring([diction objectForKey:@"ItemID"]);
            
            [_dataSource addObject:model];
            
            if (![[FMDBManager shareInstance] searchDataFMDBWithTableName:kTableName ID:kFormatterSring([diction objectForKey:@"ItemID"])]) {
                [[FMDBManager shareInstance] insertDataToFMDBWithTableName:kTableName ID:kFormatterSring([diction objectForKey:@"id"]) imageURL:kFormatterSring([diction objectForKey:@"RealUrl"]) content:kFormatterSring([diction objectForKey:@"Title"]) imageHeight:kFormatterSring([diction objectForKey:@"Height"]) imageWidht:kFormatterSring([diction objectForKey:@"Width"])];
                
            }
            
        }
        
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{
        [weakself reloadData];

        [weakself getZaoAnWanAnData];

    }];
}

/**
 *  早安晚安语录
 */
- (void)getZaoAnWanAnData {
    
    __weak RDMYuLuViewController *weakself=self;
    
    [[AFHTTPClickManager shareInstance] getRequestWithPath:kZaoAnWanAnHTTP params:@{@"page":[NSString stringWithFormat:@"%ld",(long)_currentPage]} isHeader:NO LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        NSArray *data=[respose objectForKey:@"data"];
        
        for (int i=0; i<[data count]; i++) {
            RDMYuLuModel *model=[[RDMYuLuModel alloc]init];
            
            NSDictionary *diction=[data objectAtIndex:i];
            
            if (![kFormatterSring([diction objectForKey:@"Img"]) isEmpty]) {
                
                model.imageURL=kFormatterSring([diction objectForKey:@"Img"]);
                model.content=kFormatterSring([diction objectForKey:@"Title"]);
                model.imageHeight=kFormatterSring([diction objectForKey:@"ImgH"]);
                model.imageWidht=kFormatterSring([diction objectForKey:@"ImgW"]);
                model.str_id=kFormatterSring([diction objectForKey:@"Id"]);
                [_dataSource addObject:model];
                
                
                if (! [[FMDBManager shareInstance] searchDataFMDBWithTableName:kTableName ID:kFormatterSring([diction objectForKey:@"Id"])]) {
                    [[FMDBManager shareInstance] insertDataToFMDBWithTableName:kTableName ID:kFormatterSring([diction objectForKey:@"Id"]) imageURL:kFormatterSring([diction objectForKey:@"Img"]) content:kFormatterSring([diction objectForKey:@"Title"]) imageHeight:kFormatterSring([diction objectForKey:@"ImgH"]) imageWidht:kFormatterSring([diction objectForKey:@"ImgW"])];
                }

            }
        }
        
        
        
    } FailureBlock:^(NSError *error) {
        [weakself endRefresh];
    } FinishBlock:^{
        
        [weakself reloadData];

    }];
    
    
    
}


/**
 *  刷新
 */
- (void)reloadData {
    [self endRefresh];

    [_tableView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



/**
 *  分享
 *
 *  @param shareText     分享文字
 *  @param shareImageURL 分享图片
 */
- (void)shareText:(NSString *)shareText imageURL:(NSString *)shareImageURL {
    /**
     *  微信分享设置
     */
    
    //当分享消息类型为图文时，点击分享内容会跳转到预设的链接，设置方法如下
    //[UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
    
    //如果是朋友圈，则替换平台参数名即可
    //[UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";

    
    //设置微信好友title方法为
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"一张照片，一幅场景";

    //设置微信朋友圈title方法替换平台参数名即可
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = shareText;

    
    
    /**
     *  QQ分享设置
     */
    
    //QQ设置点击分享内容跳转链接调用下面的方Å法
    //[UMSocialData defaultData].extConfig.qqData.url = @"itms-apps://itunes.apple.com/app/id1144002840";

    //Qzone设置点击分享内容跳转链接替换平台参数名即可
    //[UMSocialData defaultData].extConfig.qzoneData.url = @"itms-apps://itunes.apple.com/app/id1144002840";

    
    
    //QQ设置title方法为
    [UMSocialData defaultData].extConfig.qqData.title = @"一张照片，一幅场景";

    //Qzone设置title方法将平台参数名替换即可
    [UMSocialData defaultData].extConfig.qzoneData.title = @"一句情话，一段回忆";

    
    // 如果是网络图片，需要设置
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:shareImageURL];
    
    //分享内嵌图片
    //UIImage *shareImage = [UIImage imageNamed:@"rdm_shareIcon"];
    
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kUMAPPKEY
                                      shareText:shareText
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone]
                                       delegate:self];
    
}



//下面可以设置根据点击不同的分享平台，设置不同的分享文字
-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
//    if ([platformName isEqualToString:UMShareToQzone]) {
//        socialData.shareText = @"一句情话，一段回忆";
//    }
//    else if([platformName isEqualToString:UMShareToQQ]){
//        socialData.shareText = @"一张照片，一幅场景";
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
