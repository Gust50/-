//
//  CLSHHomeModel.m
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHomeModel.h"

@implementation CLSHHomeModel

@end

@implementation CLSHHomeJqueryModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"sliderAd":[CLSHHomeJqueryListModel class]};
}

-(void)fetchHomeData:(NSDictionary *)params
            callBack:(void (^)(BOOL, id  _Nonnull))completion
{
    
     NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_JquaryURL];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHHomeJqueryModel *model=[CLSHHomeJqueryModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}
@end

@implementation CLSHHomeJqueryListModel

@end

@implementation CLSHHomeProductModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"items":[CLSHHomeProductListModel class]};
}

-(void)fetchHomeFarmProductData:(NSDictionary *)params
                       callBack:(void (^)(BOOL, id  _Nonnull))completion
{
    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_FarmProdcut];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHHomeProductModel *model=[CLSHHomeProductModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        
         completion(NO,ServerError);
    }];
}
@end

@implementation CLSHHomeProductListModel

@end

@implementation CLSHHomeRecommentModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"items":[CLSHHomeRecommentListModel class]};
}

-(void)fetchHomeRecommendData:(NSDictionary *)params
                     callBack:(void (^)(BOOL, id  _Nonnull))completion
{
    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_RecommendProdcut];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            CLSHHomeRecommentModel *model=[CLSHHomeRecommentModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
         completion(NO,ServerError);
    }];
}
@end

@implementation CLSHHomeRecommentListModel


@end

@implementation CLSHDiscoverJqueryModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"sliderAd":[CLSHDiscoverJqueryListModel class]};
}

-(void)fetchDiscoverJqueryData:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Discover_JquaryURL];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHDiscoverJqueryModel *model=[CLSHDiscoverJqueryModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end

@implementation CLSHDiscoverJqueryListModel



@end

@implementation CLSHDiscoverRecommentModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"items":[CLSHDiscoverRecommentListModel class]};
}

-(void)fetchDiscoverRecommentData:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Discover_FarmProdcutRecommend];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            CLSHDiscoverRecommentModel *model=[CLSHDiscoverRecommentModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}


@end

@implementation CLSHDiscoverRecommentListModel


@end