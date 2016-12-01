//
//  CLSHMerchantShopModel.m
//  ClshUser
//
//  Created by kobe on 16/6/11.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMerchantShopModel.h"

@implementation CLSHMerchantShopModel


+(NSDictionary *)mj_objectClassInArray{
    return @{@"items":[CLSHMerchantShopListModel class]};
}

-(void)fetchHomeFarmProductData:(NSDictionary *)params
                       callBack:(void (^)(BOOL, id _Nonnull))compeltion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_FactoryShop];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHMerchantShopModel *model=[CLSHMerchantShopModel mj_objectWithKeyValues:baseModel.content];
            compeltion(YES,model);
        }else{
            //错误信息
            compeltion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        compeltion(NO,ServerError);
    }];
}

@end

@implementation CLSHMerchantShopListModel
//+(NSDictionary *)mj_replacedKeyFromPropertyName
//{
//    return @{@"goodsId":@"id"};
//}

@end
