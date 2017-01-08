//
//  AFHTTPClickManager.h
//  ModelProduct
//
//  Created by apple on 16/1/13.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void(^RequestLoadingBlock)(void);
typedef void(^RequestSuccessBlock)(NSDictionary* respose);
typedef void(^RequestFailureBlock)(NSError *error);
typedef void(^RequestFinishBlock)(void);

typedef void(^DownLoadProgressBlock)(CGFloat progress);
typedef void(^DownLoadCompletionSuccessBlock)(NSString *filePath);
typedef void(^DownLoadCompletionFailureBlock)(NSError *error);


typedef void(^UpLoadProgressBlock)(CGFloat progress);
typedef void(^UpLoadCompletionSuccessBlock)(void);
typedef void(^UpLoadCompletionFailureBlock)(NSError *error);


@interface AFHTTPClickManager : AFHTTPSessionManager

+ (id)shareInstance;

/**
 *  取消网络请求
 */
- (void)cancelRequest;

/**
 *  POST 请求
 *
 *  @param path         请求地址
 *  @param params       请求参数
 *  @param isheader     是否包含header
 *  @param loadingblock 请求中block
 *  @param successBlock 请求成功block
 *  @param failureBlock 请求失败blogk
 *  @param finishBlock  请求完成block
 */
- (void)postRequestWithPath:(NSString *)path params:(NSDictionary *)params isHeader:(BOOL)isheader LoadingBolck:(RequestLoadingBlock)loadingblock SuccessBlock:(RequestSuccessBlock)successBlock FailureBlock:(RequestFailureBlock)failureBlock FinishBlock:(RequestFinishBlock)finishBlock;


/**
 *  GET 请求
 *
 *  @param path         请求地址
 *  @param params       请求参数
 *  @param isheader     是否包含header
 *  @param loadingblock 请求中block
 *  @param successBlock 请求成功block
 *  @param failureBlock 请求失败blogk
 *  @param finishBlock  请求完成block
 */
- (void)getRequestWithPath:(NSString *)path params:(NSDictionary *)params isHeader:(BOOL)isheader LoadingBolck:(RequestLoadingBlock)loadingblock SuccessBlock:(RequestSuccessBlock)successBlock FailureBlock:(RequestFailureBlock)failureBlock FinishBlock:(RequestFinishBlock)finishBlock;


/**
 *  下载请求
 *
 *  @param url                 下载地址
 *  @param filepath            存储路径
 *  @param contentname         文件名
 *  @param progressblock       下载进度block
 *  @param completsuccessblock 加载完成block
 *  @param failureblock        下载失败block
 */
- (void)downLoadRequestWithURL:(NSString *)url filePath:(NSString *)filepath contentName:(NSString *)contentname progressBlock:(DownLoadProgressBlock)progressblock completSuccessBlock:(DownLoadCompletionSuccessBlock)completsuccessblock failureBlock:(DownLoadCompletionFailureBlock)failureblock;


/**
 *  上传请求
 *
 *  @param url                 上传地址
 *  @param data                上传数据
 *  @param progressblock       上传进度block
 *  @param completsuccessblock 上传完成block
 *  @param failureblock        上传失败block
 */
- (void)upLoadRequestWithURL:(NSString *)url uploadData:(id)data progressBlock:(UpLoadProgressBlock)progressblock completSuccessBlock:(UpLoadCompletionSuccessBlock)completsuccessblock failureBlock:(UpLoadCompletionFailureBlock)failureblock;


@end
