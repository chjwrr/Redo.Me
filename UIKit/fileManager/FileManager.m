//
//  FileManager.m
//  NSFileManager测试
//
//  Created by apple on 15/5/5.
//  Copyright (c) 2015年 CHJ. All rights reserved.
//

#import "FileManager.h"
#import <UIKit/UIKit.h>

#define kMyWayFilePath            @"MyWayData"   //总目录文件夹

#define kMyWayVideoFilePath       @"MyWayVideo"  //视频文件夹

#define kMyWayAudeoFilePath       @"MyWayAudeo"  //音频文件夹

#define kMyWayImageFilePath       @"MyWayImgae"  //图片文件夹

#define kMyWayNewsFilePath        @"MyWayNew"   //新闻文件夹


@implementation FileManager

+ (id)shareIntance{
    static FileManager *manager=nil;
    static dispatch_once_t disonce;
    dispatch_once(&disonce, ^{
        manager=[[FileManager alloc]init];
    });
    return manager;
}

-(void)dirHome{
    //NSString *dirHome=NSHomeDirectory();
}
//获取Documents目录
-(NSString *)dirDoc{
    //[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}
//获取Library目录
-(void)dirLib{
    //[NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
   // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
   //NSString *libraryDirectory = [paths objectAtIndex:0];
}
//获取Cache目录
-(void)dirCache{
    //NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //NSString *cachePath = [cacPath objectAtIndex:0];
}
//获取Tmp目录
-(void)dirTmp{
    //[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    //NSString *tmpDirectory = NSTemporaryDirectory();
}
//创建目录
- (void)creatMyWayFilePath {
    NSString *documentsPath =[self dirDoc];
    NSFileManager *fileManager = [NSFileManager defaultManager];
   
    //根目录文件夹
    NSString *mywayFilePath=[documentsPath stringByAppendingPathComponent:kMyWayFilePath];
    
    //判断是否存在根目录文件夹
    BOOL isHasFilePath=[fileManager isExecutableFileAtPath:mywayFilePath];
    if (!isHasFilePath) {
        NSLog(@"不存在，新建根目录文件夹");
        
        BOOL isCreatFilePath=[fileManager createDirectoryAtPath:mywayFilePath withIntermediateDirectories:YES attributes:nil error:nil];
        if (isCreatFilePath) {
            NSLog(@"创建成功，继续新建子文件夹");
            
            //视频文件夹
            NSString *videoFilePath=[mywayFilePath stringByAppendingPathComponent:kMyWayVideoFilePath];
            BOOL isCreatVideo=[fileManager createDirectoryAtPath:videoFilePath withIntermediateDirectories:YES attributes:nil error:nil];
            if (isCreatVideo) {
                NSLog(@"视频文件夹创建成功");
            }
            //音频文件夹
            NSString *audeoFilePath=[mywayFilePath stringByAppendingPathComponent:kMyWayAudeoFilePath];
            BOOL isCreataudeo=[fileManager createDirectoryAtPath:audeoFilePath withIntermediateDirectories:YES attributes:nil error:nil];
            if (isCreataudeo) {
                NSLog(@"音频文件夹创建成功");
            }
            //视频文件夹
            NSString *imageFilePath=[mywayFilePath stringByAppendingPathComponent:kMyWayImageFilePath];
            BOOL isCreatImage=[fileManager createDirectoryAtPath:imageFilePath withIntermediateDirectories:YES attributes:nil error:nil];
            if (isCreatImage) {
                NSLog(@"图片文件夹创建成功");
            }

            
        }
        
    }else{
        NSLog(@"根目录文件夹已经存在");
    }
}

/*---------------------------------------返回文件夹目录 begin-------------------------------------------*/

- (NSString *)FilePath:(NSString *)path {
    NSString *documentsPath =[self dirDoc];
    
    //根目录文件夹
    NSString *mywayFilePath=[documentsPath stringByAppendingPathComponent:kMyWayFilePath];
   
    //文件夹
    NSString *imageFilePath=[mywayFilePath stringByAppendingPathComponent:path];
    
    return imageFilePath;
}
- (NSString *)imageFilePath {
    return [self FilePath:kMyWayImageFilePath];
}

- (NSString *)audeoFilePath {
    return [self FilePath:kMyWayAudeoFilePath];
}

- (NSString *)videoFilePath {
    return [self FilePath:kMyWayVideoFilePath];
}
/*---------------------------------------返回文件夹目录 end-------------------------------------------*/


/*---------------------------------------移除某一个文件 begin-------------------------------------------*/

- (void)removeFilePath:(NSString *)filePath itemName:(NSString *)name{
    NSString *documentsPath =[self dirDoc];
    
    //根目录文件夹
    NSString *mywayFilePath=[documentsPath stringByAppendingPathComponent:kMyWayFilePath];

    NSString *Directory = [mywayFilePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",filePath,name]];

    NSFileManager *fileManager = [NSFileManager defaultManager];

   BOOL isRemove= [fileManager removeItemAtPath:Directory error:nil];
    if (isRemove) {
        NSLog(@"删除成功");
    }
}

- (void)removeAudeoFilePathWithItemName:(NSString *)name {
    [self removeFilePath:kMyWayAudeoFilePath itemName:name];
}
- (void)removeVideoFilePathWithItemName:(NSString *)name {
    [self removeFilePath:kMyWayVideoFilePath itemName:name];
}
- (void)removeImageFilePathWithItemName:(NSString *)name {
    [self removeFilePath:kMyWayImageFilePath itemName:name];
}
/*---------------------------------------移除某一个文件 end-------------------------------------------*/

/*---------------------------------------移除文件夹里面的所有数据 begin-------------------------------------------*/

- (void)removeAllItemFilePath:(NSString *)filePath{
    NSString *documentsPath =[self dirDoc];
    
    //根目录文件夹
    NSString *mywayFilePath=[documentsPath stringByAppendingPathComponent:kMyWayFilePath];
    
    NSString *Directory = [mywayFilePath stringByAppendingPathComponent:filePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
   //文件夹里面所有的文件的名字 数组
    NSArray *list=[fileManager contentsOfDirectoryAtPath:Directory error:nil];
    
    //遍历删除
    for (NSString *fileName in list) {
        NSString *itemPath=[Directory stringByAppendingPathComponent:fileName];
        if ([fileManager fileExistsAtPath:itemPath]) {
            [fileManager removeItemAtPath:itemPath error:nil];
        }
    }

}

- (void)removeAllVideoItems {
    [self removeAllItemFilePath:kMyWayVideoFilePath];
}
- (void)removeAllAudeoItems {
    [self removeAllItemFilePath:kMyWayAudeoFilePath];
}
- (void)removeAllImageItems {
    [self removeAllItemFilePath:kMyWayImageFilePath];
}
/*---------------------------------------移除文件夹里面的所有数据 end-------------------------------------------*/


/*---------------------------------------获取文件夹里面的所有数据 begin-------------------------------------------*/

- (NSArray *)getAllItemFilePath:(NSString *)filePath{
    
    NSMutableArray *items=[[NSMutableArray alloc]init];
    NSString *documentsPath =[self dirDoc];
    
    //根目录文件夹
    NSString *mywayFilePath=[documentsPath stringByAppendingPathComponent:kMyWayFilePath];
    
    NSString *Directory = [mywayFilePath stringByAppendingPathComponent:filePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //文件夹里面所有的文件的名字 数组
    NSArray *list=[fileManager contentsOfDirectoryAtPath:Directory error:nil];
    
    //遍历获取
    for (NSString *fileName in list) {
        if (![fileName isEqualToString:@".DS_Store"]) {//.DS_Store为临时文件
            NSString *itemPath=[Directory stringByAppendingPathComponent:fileName];
            if ([fileManager fileExistsAtPath:itemPath]) {
                [items addObject:itemPath];
            }

        }
    }
    
    return (NSArray *)items;
}

- (NSArray *)getAllVideoItems {
    return [self getAllItemFilePath:kMyWayVideoFilePath];
}
- (NSArray *)getAllAudeoItems {
    return [self getAllItemFilePath:kMyWayAudeoFilePath];
}
- (NSArray *)getAllImageItems {
    return  [self getAllItemFilePath:kMyWayImageFilePath];
}

/*---------------------------------------获取文件夹里面的所有数据 end-------------------------------------------*/



/*---------------------------------------获取文件夹里面的所有数据 end-------------------------------------------*/

- (void)saveContent:(NSDictionary *)content ToFilePath:(NSString *)filepath {
    NSString *documentsPath =[self dirDoc];
    
    ///Users/chj/Library/Developer/CoreSimulator/Devices/F875B07E-687B-44C2-A3D6-10DE752C0BAE/data/Containers/Data/Application/4BB43375-89B3-4203-B0B6-42A2C03A8BC2/Documents/MyWayData/MyWayNew/weiNews.txt
    
    NSString *filep=[documentsPath stringByAppendingPathComponent:kMyWayFilePath];
    
    NSString *file=[filep stringByAppendingPathComponent:kMyWayNewsFilePath];
    
    NSString *filePath=[file stringByAppendingPathComponent:filepath];
    
    
    NSData *data=[NSJSONSerialization dataWithJSONObject:content options:NSJSONWritingPrettyPrinted error:nil];
    
    [data writeToFile:filePath atomically:YES];
    
    
    
    
}
/*获取新闻文件夹数据*/
- (NSDictionary *)getContentFromFilePath:(NSString *)filepath {
    
    NSString *documentsPath =[self dirDoc];
    
    NSString *filep=[documentsPath stringByAppendingPathComponent:kMyWayFilePath];
    
    NSString *file=[filep stringByAppendingPathComponent:kMyWayNewsFilePath];
    
    NSString *filePath=[file stringByAppendingPathComponent:filepath];
    
    NSString *string=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSData *data=[string dataUsingEncoding:NSUTF8StringEncoding];
    
    if (data == nil) {
        return nil;
    }
    
    NSDictionary *diction=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    return diction;
}



@end
