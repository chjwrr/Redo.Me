//
//  RDMWenZhangViewController.m
//  ModelProduct
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "RDMWenZhangViewController.h"
#import "RDMWenZhangModel.h"
#import "RDMWenZhangDetailTypeOneViewController.h"
#import "RDMWenZhangDetailTypeTwoViewController.h"

#import "RGCardViewLayout.h"
#import "RGCollectionViewCell.h"


//情感语录文章,不支持https
#define kQingGanYuLuHttp    @"http://123.58.128.174/reader/api/articles/channel.php?app_version=1.0.0&channel=104&market=iOS&os=iOS&version=4"

//一张照片 第一页,支持https
#define kYiZhangZhaoPianFirsstHttp  @"https://news-at.zhihu.com/api/4/theme/11"

//一张照片 更多页,支持https
#define kYiZhangZhaoPianMoreHttp  @"https://news-at.zhihu.com/api/4/theme/11/before/"

@interface RDMWenZhangViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,RGCollectionViewCellDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSString *lastID1;
@property (nonatomic,strong)NSString *lastID2;
@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic)BOOL isRefresh;

@end

@implementation RDMWenZhangViewController

- (void)initDataSource {
    _dataSource=[[NSMutableArray alloc]init];

    _lastID1=[[NSString alloc]init];
    _lastID2=[[NSString alloc]init];
    
    _lastID2=@"0";
     _lastID1=@"0";
}

- (void)initSubViews {
    
    self.view.backgroundColor=[UIColor purpleColor];
    
    RGCardViewLayout *layout=[[RGCardViewLayout alloc]init];
    
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    [self.view addSubview:_collectionView];
    
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.pagingEnabled=YES;
    
    [self.collectionView registerClass:[RGCollectionViewCell class] forCellWithReuseIdentifier:@"RGCollectionViewCell"];


    [self getYiZhangZhaoPianData];

}



/**
 *  重新加载
 */
-(void)refrehData{
    
    [_collectionView setContentOffset:CGPointMake(0, 0) animated:YES];

    
    [_dataSource removeAllObjects];
    
    _lastID2=@"0";
    _lastID1=@"0";
    _isRefresh=YES;

    
    [self getYiZhangZhaoPianData];
}

/**
 *  加载更多
 */
-(void)loadMore{
    [self getQingGanYuLuData];

}

#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数  必须返回1
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

//定义展示的Section的个数   有几个item 就返回几个
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_dataSource count];
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"RGCollectionViewCell";
    RGCollectionViewCell * cell = (RGCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if ([_dataSource count] != 0 && [_dataSource count] > indexPath.section) {
        cell.delegate=self;
        
        cell.tag=indexPath.section+100;
        
        RDMWenZhangModel *model=_dataSource[indexPath.section];
        
        [cell cellForData:model];
    }    
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollView.contentOffset.x====%f",scrollView.contentOffset.x);
    if (scrollView.contentOffset.x == kSCREEN_WIDTH*([_dataSource count]-5)) {
        //倒数第五个自动加载更多
        [self loadMore];
    }
}

/**
 *  RGCollectionViewCellDelegate
 *
 *  @param index 第几个
 */
- (void)didSelectRGCollectionViewCellImage:(NSInteger)index {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kshownormalMenu object:nil];

    RDMWenZhangModel *model=_dataSource[index];
    
    if ([model.type isEqualToString:@"1"]) {
        //情感语录
        RDMWenZhangDetailTypeOneViewController *oneVC=[[RDMWenZhangDetailTypeOneViewController alloc]init];
        oneVC.str_title=model.title;
        oneVC.detailURL=model.detailURL;
        oneVC.imageURL=model.imageURL;
        [self.navigationController pushViewController:oneVC animated:YES];
        
    }else{
        //一张照片
        RDMWenZhangDetailTypeTwoViewController *twoVC=[[RDMWenZhangDetailTypeTwoViewController alloc]init];
        twoVC.str_ID=model.str_id;
        twoVC.imageURL=model.imageURL;

        [self.navigationController pushViewController:twoVC animated:YES];
        
    }
    
}


/**
 *  情感语录  文章
 */
- (void)getQingGanYuLuData {

    __weak RDMWenZhangViewController *weakself=self;
    [[AFHTTPClickManager shareInstance] postRequestWithPath:kQingGanYuLuHttp params:@{@"from":_lastID1} isHeader:NO LoadingBolck:^{
        
    } SuccessBlock:^(NSDictionary *respose) {
        
        NSDictionary *data=[respose objectForKey:@"data"];
        NSArray *articles=[data objectForKey:@"articles"];
        
        for (int i=0; i<[articles count]; i++) {
            NSDictionary *diction=[articles objectAtIndex:i];
            
            RDMWenZhangModel *model=[[RDMWenZhangModel alloc]init];
            model.imageURL=kFormatterSring([diction objectForKey:@"imglink"]);
            model.str_id=kFormatterSring([diction objectForKey:@"id"]);
            model.title=kFormatterSring([diction objectForKey:@"title"]);
            model.detailURL=kFormatterSring([diction objectForKey:@"content_location"]);
            model.type=@"1";

            [_dataSource addObject:model];
        }
        
        RDMWenZhangModel *lastModel=[_dataSource lastObject];
        
        _lastID1=lastModel.str_id;
        
    } FailureBlock:^(NSError *error) {
        
    } FinishBlock:^{
        [weakself upLoadData];

    }];
    
}

/**
 *  一张照片  文章
 */
- (void)getYiZhangZhaoPianData {
    
    __weak RDMWenZhangViewController *weakself=self;
    
    if ([_lastID2 isEqualToString:@"0"]) {
        //第一页
        [[AFHTTPClickManager shareInstance] getRequestWithPath:kYiZhangZhaoPianFirsstHttp params:nil isHeader:NO LoadingBolck:^{
            
        } SuccessBlock:^(NSDictionary *respose) {
            
            NSArray *stories=[respose objectForKey:@"stories"];
            
            for (int i=0; i<[stories count]; i++) {
                NSDictionary *diction=[stories objectAtIndex:i];
                
                RDMWenZhangModel *model=[[RDMWenZhangModel alloc]init];
                model.str_id=kFormatterSring([diction objectForKey:@"id"]);
                model.title=kFormatterSring([diction objectForKey:@"title"]);
                model.type=@"2";
                
                NSArray *images=[diction objectForKey:@"images"];
                if ([images count] != 0) {
                    model.imageURL=kFormatterSring([images objectAtIndex:0]);
                }
                
                [_dataSource addObject:model];
            }
            RDMWenZhangModel *lastModel=[_dataSource lastObject];
            
            _lastID2=lastModel.str_id;
            
        } FailureBlock:^(NSError *error) {
            
        } FinishBlock:^{
            //[weakself upLoadData];
            [weakself getQingGanYuLuData];

        }];

    }else{
        [[AFHTTPClickManager shareInstance] getRequestWithPath:[NSString stringWithFormat:@"%@%@",kYiZhangZhaoPianMoreHttp,_lastID2] params:nil isHeader:NO LoadingBolck:^{
            
        } SuccessBlock:^(NSDictionary *respose) {
            NSArray *stories=[respose objectForKey:@"stories"];
            
            for (int i=0; i<[stories count]; i++) {
                NSDictionary *diction=[stories objectAtIndex:i];
                
                RDMWenZhangModel *model=[[RDMWenZhangModel alloc]init];
                model.str_id=kFormatterSring([diction objectForKey:@"id"]);
                model.title=kFormatterSring([diction objectForKey:@"title"]);
                model.type=@"2";
                
                NSArray *images=[diction objectForKey:@"images"];
                if ([images count] != 0) {
                    model.imageURL=kFormatterSring([images objectAtIndex:0]);
                }
                
                [_dataSource addObject:model];
            }
            
            RDMWenZhangModel *lastModel=[_dataSource lastObject];
            
            _lastID2=lastModel.str_id;
            
        } FailureBlock:^(NSError *error) {
            
        } FinishBlock:^{
            //[weakself upLoadData];
            [weakself getQingGanYuLuData];

            
        }];

    }
    
}
/**
 *  刷新界面
 */
- (void)upLoadData {

    if (_isRefresh) {
        _refreshEndBlock();
    }
    [_collectionView reloadData];
    
    _isRefresh= NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
