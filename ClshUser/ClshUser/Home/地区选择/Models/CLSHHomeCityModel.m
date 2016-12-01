//
//  CLSHHomeCityModel.m
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHomeCityModel.h"

@implementation CLSHHomeCityModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"province":[CLSHHomeCityListModel class]};
}

-(void)fetchHomeCityData:(NSDictionary *)params
                callBack:(void (^)(BOOL, id _Nonnull))compeltion
{
    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_City];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            
            CLSHHomeCityModel *model=[CLSHHomeCityModel mj_objectWithKeyValues:baseModel.content];
            compeltion(YES,model);
        }else{
            compeltion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        
        compeltion(NO,ServerError);
    }];
}

@end

@implementation CLSHHomeCityListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"itemID":@"id"};
}
@end


@implementation CLSHHomeHotCityModel


+(NSDictionary *)mj_objectClassInArray{
    return @{@"items":[CLSHHomeHotCityListModel class]};
}
-(void)fetchHomeHotCityData:(NSDictionary *)params
                   callBack:(void (^)(BOOL, id _Nonnull))compeltion
{
    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_HotCity];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHHomeHotCityModel *model=[CLSHHomeHotCityModel mj_objectWithKeyValues:baseModel.content];
            compeltion(YES,model);
        }else{
            compeltion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        compeltion(NO,ServerError);
    }];

}
@end

@implementation CLSHHomeHotCityListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"itemID":@"id"};
}

@end


@implementation CLSHHomeSearchCityModel


+(NSDictionary *)mj_objectClassInArray{
    return @{@"items":[CLSHHomeSearchCityListModel class]};
}
-(void)fetchHomeSearchCityData:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))compeltion
{
    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_SearchCity];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHHomeSearchCityModel *model=[CLSHHomeSearchCityModel mj_objectWithKeyValues:baseModel.content];
            compeltion(YES,model);
        }else{
            compeltion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        compeltion(NO,ServerError);
    }];
}

@end

@implementation CLSHHomeSearchCityListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"itemID":@"id"};
}

@end


@implementation CLSHHistoryCityModel

@end

