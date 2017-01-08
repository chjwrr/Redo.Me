//
//  AFHTTPClickManager.m
//  ModelProduct
//
//  Created by apple on 16/1/13.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "AFHTTPClickManager.h"

@implementation AFHTTPClickManager

+ (id)shareInstance {
    static AFHTTPClickManager *manager=nil;
    static dispatch_once_t dispathoncet;
    dispatch_once(&dispathoncet, ^{
        manager=[[AFHTTPClickManager alloc]init];
    });
    
    return manager;
}

- (void)cancelRequest {
    [self.operationQueue cancelAllOperations];
}


- (void)postRequestWithPath:(NSString *)path params:(NSDictionary *)params isHeader:(BOOL)isheader LoadingBolck:(RequestLoadingBlock)loadingblock SuccessBlock:(RequestSuccessBlock)successBlock FailureBlock:(RequestFailureBlock)failureBlock FinishBlock:(RequestFinishBlock)finishBlock{
    
    loadingblock();
    
    if (isheader) {
        /*-----------用于参数再head里面的请求-------------*/
        //给请求的serializer new一个对象，这一步千万不能忘，不然后面的配置都无效！！
        
        self.requestSerializer=[AFJSONRequestSerializer new];
        [self.requestSerializer setValue:@"" forHTTPHeaderField:@"apikey"];
    }
   
    
    self.responseSerializer=[AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/plain", @"text/html", nil];
    
    

    [self POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *rootDic=(NSDictionary *)responseObject;
        
        successBlock(rootDic);
        finishBlock();
        NSLog(@"POST 请求接口：%@\n请求参数：%@\n请求结果：%@",path,params,rootDic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
        finishBlock();
        
        NSLog(@"POST 请求接口：%@\n请求参数：%@\n出错原因：%@",path,params,error);
        
    }];
    
    
}
- (void)getRequestWithPath:(NSString *)path params:(NSDictionary *)params isHeader:(BOOL)isheader LoadingBolck:(RequestLoadingBlock)loadingblock SuccessBlock:(RequestSuccessBlock)successBlock FailureBlock:(RequestFailureBlock)failureBlock FinishBlock:(RequestFinishBlock)finishBlock{
    
    loadingblock();
    
    
    if (isheader) {
        /*-----------用于参数再head里面的请求-------------*/
        //给请求的serializer new一个对象，这一步千万不能忘，不然后面的配置都无效！！
        
        self.requestSerializer=[AFJSONRequestSerializer new];
        [self.requestSerializer setValue:@"" forHTTPHeaderField:@"apikey"];
    }
    
    self.responseSerializer=[AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/plain", @"text/html", nil];
    
    
    
    [self GET:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *rootDic=(NSDictionary *)responseObject;
        
        successBlock(rootDic);
        finishBlock();
        NSLog(@"GET 请求接口：%@\n 请求参数：%@\n请求结果：%@",path,params,rootDic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
        finishBlock();
        
        NSLog(@"GET 请求接口：%@\n请求参数：%@\n出错原因：%@",path,params,error);
        
    }];

    
    
}


- (void)downLoadRequestWithURL:(NSString *)url filePath:(NSString *)filepath contentName:(NSString *)contentname progressBlock:(DownLoadProgressBlock)progressblock completSuccessBlock:(DownLoadCompletionSuccessBlock)completsuccessblock failureBlock:(DownLoadCompletionFailureBlock)failureblock {
    
    NSURL *downURL=[NSURL URLWithString:url];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:downURL];
    
    
    
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager=[[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    
    
    NSURLSessionDownloadTask *downLoadTask=[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
        
        progressblock((float)1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"path  %@",path);
        return [NSURL fileURLWithPath:path];
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
        
        completsuccessblock([filePath path]);
        
    }];
    
    [downLoadTask resume];
    
}


- (void)upLoadRequestWithURL:(NSString *)url uploadData:(id)data progressBlock:(UpLoadProgressBlock)progressblock completSuccessBlock:(UpLoadCompletionSuccessBlock)completsuccessblock failureBlock:(UpLoadCompletionFailureBlock)failureblock {
    
    
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager=[[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionUploadTask*uploadTask=[manager uploadTaskWithRequest:request fromData:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progressblock((float)1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error == nil) {
            completsuccessblock();
        }else{
            failureblock(error);
        }
    }];
    
    [uploadTask resume];
    
}

@end
