//
//  CLSHMyFoodstampsHelpWebVC.m
//  ClshUser
//
//  Created by wutaobo on 16/6/16.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMyFoodstampsHelpWebVC.h"
#import "CLSHFetchTitleModel.h"

@interface CLSHMyFoodstampsHelpWebVC ()
{
    CLSHFetchTitleModel *titleModel;        ///<文章数据模型
    NSMutableDictionary *params;            ///<传入文章id参数
}

@end

@implementation CLSHMyFoodstampsHelpWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
}

#pragma mark <loadData>
- (void)loadData
{
    titleModel = [[CLSHFetchTitleModel alloc] init];
    params = [NSMutableDictionary dictionary];
    params[@"articleId"] = self.titleID;
    [titleModel fetchFetchTitleData:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            titleModel = result;
            [self.webView loadHTMLString:titleModel.content baseURL:nil];
            
        }
    }];
}

#pragma mark - setter getter
-(void)setTitleID:(NSString *)titleID
{
    _titleID = titleID;
}

-(void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    [self.navigationItem setTitle:titleStr];
}

@end
