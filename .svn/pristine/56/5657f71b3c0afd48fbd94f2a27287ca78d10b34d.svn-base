//
//  KBDatabaseManagerTool.m
//  ClshUser
//
//  Created by kobe on 16/7/8.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBDatabaseManagerTool.h"
#import "CLSHClassifyModel.h"
#import "FMDB.h"
@implementation KBDatabaseManagerTool
//定义一个静态数据库变量
static FMDatabase *_db;

+(void)initialize{
    
    //数据库文件路径
    NSString *filePath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"classify.sqlite"];
    NSLog(@"dbFilePath = %@",filePath);
    //创建数据库
    _db=[FMDatabase databaseWithPath:filePath];
    if (![_db open]) return;
    
    //创建表
   BOOL create=[_db executeUpdate:@"CREATE TABLE IF NOT EXISTS clsh_classify_table(id integer PRIMARY KEY,classifyModel blob NOT NULL)"];
    if (create) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
}

+(void)saveClassifyModelData:(CLSHClassifyModel *)model{
    
    NSDictionary *dict=[model mj_keyValues];
    
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:dict];
    BOOL insert=[_db executeUpdateWithFormat:@"INSERT INTO clsh_classify_table (classifyModel) VALUES (%@)",data];
    if (insert) {
         NSLog(@"插入数据成功");
    }else{
         NSLog(@"插入数据失败");
    }
}

+(void)updateSaveClassifyModelData:(CLSHClassifyModel *)model{
    NSDictionary *dict=[model mj_keyValues];
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:dict];
     BOOL update= [_db executeUpdate:@"UPDATE clsh_classify_table SET classifyModel=?",data];
    if (update) {
         NSLog(@"更新数据成功");
    }else{
         NSLog(@"更新数据失败");
    }
}

+(CLSHClassifyModel *)fetchClassifyModelData{
    FMResultSet *set=[_db executeQueryWithFormat:@"SELECT *FROM clsh_classify_table"];
    CLSHClassifyModel *model;
    while (set.next) {
        NSDictionary *dict=[NSKeyedUnarchiver unarchiveObjectWithData:[set objectForColumnName:@"classifyModel"]];
        model=[CLSHClassifyModel mj_objectWithKeyValues:dict];
    }
    return model;
}
@end
