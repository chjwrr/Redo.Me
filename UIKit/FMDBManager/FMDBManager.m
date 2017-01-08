//
//  FMDBManager.m
//  ModelProduct
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "FMDBManager.h"

@interface FMDBManager ()

@property (nonatomic,strong)FMDatabase *fmdb;

@end

@implementation FMDBManager

+ (id)shareInstance {
    static FMDBManager *manager=nil;
    static dispatch_once_t dicpatchonce;
    dispatch_once(&dicpatchonce, ^{
        manager=[[FMDBManager alloc]init];
    });
    return manager;
    
}

- (void)openFMDB {
    
    /*
     文件路径有三种情况
     
     （1）具体文件路径
     
     　　如果不存在会自动创建
     
     
     
     （2）空字符串@""
     
     　　会在临时目录创建一个空的数据库
     
     　　当FMDatabase连接关闭时，数据库文件也被删除
     
     
     
     （3）nil
     
     　　会创建一个内存中临时数据库，当FMDatabase连接关闭时，数据库会被销毁
     

     */
  
    
    
}

- (void)initFMDB {
    if (!_fmdb) {
        _fmdb=[FMDatabase databaseWithPath:kFMDBPath];
    }
    [_fmdb open];

}

/**
 *  创建数据表
 *
 *  @param tableName 数据表名称
 */
- (void)createDataToFMDBWithTableName:(NSString *)tableName {
    
    NSLog(@"kFMDBPath  %@",kFMDBPath);

    [self initFMDB];
    
    if ([_fmdb open]) {
        
        //创建表
        //ID 是主键
        NSString *cteateSQL=[NSString stringWithFormat:@"create table if not exists '%@' ('%@' INTEGER PRIMARY KEY,'%@','%@','%@','%@','%@');",tableName,@"primaryID",@"ID",@"imageURL",@"content",@"imageHeight",@"imageWidht"];

        //NSString *cteateSQL=[NSString stringWithFormat:@"create table if not exists '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT,'%@','%@','%@','%@');",tableName,@"ID",@"imageURL",@"content",@"imageHeight",@"imageWidht"];
        
        //NSString *cteateSQL=[NSString stringWithFormat:@"create table if not exists '%@' ('%@','%@','%@');",tableName,@"age",@"sex",@"name"];
        
        
        BOOL res= [_fmdb executeUpdate:cteateSQL];
        
        if (res) {
            NSLog(@"数据表 tableName创建成功");
        }else{
            NSLog(@"数据表 tableName创建失败");
        }

        [_fmdb close];
        
    }
}

/**
 *  向数据表里面插入数据
 *
 *  @param tableName   数据表名称
 *  @param ID          id
 *  @param imageURL    imageURL
 *  @param content     content
 *  @param imageHeight imageHeight
 *  @param imageWidht  imageWidht
 */
- (void)insertDataToFMDBWithTableName:(NSString *)tableName ID:(NSString *)ID imageURL:(NSString *)imageURL content:(NSString *)content imageHeight:(NSString *)imageHeight imageWidht:(NSString *)imageWidht{
    [self initFMDB];
    
    //是否存在表
    if (![_fmdb tableExists:tableName]) {
        [self createDataToFMDBWithTableName:tableName];
    }
    
    if ([_fmdb open]) {
        
        
        //插入数据  id 为主键   插入数据如果主键一样，则插入失败。只要主键不一样，就会插入成功
        
        NSString *insertSQL=[NSString stringWithFormat:@"insert into '%@' ('ID','imageURL','content','imageHeight','imageWidht') values ('%@','%@','%@','%@','%@');",tableName,ID,imageURL,content,imageHeight,imageWidht];
        
        BOOL insertRes=[_fmdb executeUpdate:insertSQL];

        if (insertRes) {
            NSLog(@"数据表 tableName插入成功");
        }else{
            NSLog(@"数据表 tableName插入失败");
        }
        

        [_fmdb close];
        
    }
}

/**
 *  删除数据表里面的所有数据
 *
 *  @param tableName 数据表名称
 */
- (void)deleteAllDataFMDBWithTableName:(NSString *)tableName {
    [self initFMDB];
    
    //是否存在表
    if (![_fmdb tableExists:tableName]) {
        return;
    }

    if ([_fmdb open]) {
        //删除
        NSString *deleteSQL=[NSString stringWithFormat:@"delete from %@",tableName];
        
        BOOL deleteRes=[_fmdb executeUpdate:deleteSQL];
        if (deleteRes) {
            NSLog(@"数据表 tableName删除成功");
        }else{
            NSLog(@"数据表 tableName删除失败");
        }
        
        
        [_fmdb close];
    }
}

/**
 *  修改数据表中的数据
 *
 *  @param tableName 数据表名称
 */
- (void)changeDataToFMDBWithTableName:(NSString *)tableName {
    [self initFMDB];
    
    //是否存在表
    if (![_fmdb tableExists:tableName]) {
        return;
    }
    

    if ([_fmdb open]) {
        
        //修改数据
        
        NSString *changeSQL=[NSString stringWithFormat:@"update %@ set 'age'='111' where 'age'='18';",tableName];
        
        
        BOOL changeRes=[_fmdb executeUpdate:changeSQL];
        
        if (changeRes) {
            NSLog(@"数据表 tableName修改成功");
        }else{
            NSLog(@"数据表 tableName修改失败");
        }

        [_fmdb close];
    }
}

/**
 *  删除数据表中某一条数据
 *
 *  @param tableName 数据表名称
 */
- (void)deleteOneDataFMDBWithTableName:(NSString *)tableName {
    [self initFMDB];
    
    //是否存在表
    if (![_fmdb tableExists:tableName]) {
        return;
    }
    

    if ([_fmdb open]) {
        
        //删除数据
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete from %@ where %@ = '%@'",
                               tableName, @"name", @"张三"];
        BOOL aares = [_fmdb executeUpdate:deleteSql];
        
        if (!aares) {
            NSLog(@"error when delete db table");
        } else {
            NSLog(@"success to delete db table");
        }

        [_fmdb close];
    }
}

/**
 *  查找数据表符合的数据
 *
 *  @param tableName 数据表名称  
 *  
 *  @param ID        查询数据字段
 */
- (BOOL)searchDataFMDBWithTableName:(NSString *)tableName ID:(NSString *)strID{
    [self initFMDB];
    
    //是否存在表
    if (![_fmdb tableExists:tableName]) {
        return NO;
    }
    
    
    if ([_fmdb open]) {
        
        //查询数据
        
        NSString *searchSQL=[NSString stringWithFormat:@"select * from %@ where ID = '%@'",tableName,strID];
        
        FMResultSet *resultData=[_fmdb executeQuery:searchSQL];
        
        BOOL isHas=NO;
        while ([resultData next]) {
            isHas=YES;
            
            NSLog(@"已经存在啦！！！");
        }
        
        [_fmdb close];
        
        return isHas;
    }
    return NO;
}


/**
 *  查找数据表所有的数据
 *
 *  @param tableName 数据表名称
 */
- (NSMutableArray *)searchDataFMDBWithTableName:(NSString *)tableName {
    [self initFMDB];
    
    //是否存在表
    if (![_fmdb tableExists:tableName]) {
        return nil;
    }
    
    
    if ([_fmdb open]) {
        
        //查询数据
        
        NSMutableArray *dataSource=[NSMutableArray array];
        NSString *searchSQL=[NSString stringWithFormat:@"select * from %@",tableName];
        
        FMResultSet *resultData=[_fmdb executeQuery:searchSQL];
        
        while ([resultData next]) {
            NSString * ID = [resultData stringForColumn:@"ID"];
            NSString * imageURL = [resultData stringForColumn:@"imageURL"];
            NSString * content = [resultData stringForColumn:@"content"];
            NSString * imageHeight = [resultData stringForColumn:@"imageHeight"];
            NSString * imageWidht = [resultData stringForColumn:@"imageWidht"];
            
            
            NSDictionary *diction=@{@"id":ID,
                                    @"imageURL":imageURL,
                                    @"content":content,
                                    @"imageHeight":imageHeight,
                                    @"imageWidht":imageWidht};

            [dataSource addObject:diction];
        }
        
        

        [_fmdb close];
        
        return dataSource;
    }
    return nil;
}





@end
