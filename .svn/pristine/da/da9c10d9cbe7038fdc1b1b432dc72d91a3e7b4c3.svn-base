//
//  KBCacheTool.m
//  ClshUser
//
//  Created by kobe on 16/7/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBCacheTool.h"

@implementation KBCacheTool

+(NSString *)caculatorCacheSize{
    
    float tmpSize = [[SDImageCache sharedImageCache] getSize] / 1024 /1024;
    NSString *clearCacheSizeStr = tmpSize >= 1 ? [NSString stringWithFormat:@"%.2fM",tmpSize] : [NSString stringWithFormat:@"%.2fK",tmpSize * 1024];
    return clearCacheSizeStr;
}

+(void)clearCache{
    
    [[SDImageCache sharedImageCache] clearDisk];
}
@end
