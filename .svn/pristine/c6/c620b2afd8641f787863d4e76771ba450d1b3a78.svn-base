//
//  CLSHClassifyModel.m
//  ClshUser
//
//  Created by kobe on 16/6/7.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHClassifyModel.h"

@implementation CLSHClassifyModel

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"rootProductCategories":[CLSHClassifyRootModel class]};
}

-(void)fetchClassifyModel:(NSDictionary *)params
                 callBack:(void (^)(BOOL, id))completion
{

    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Classify_Product];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            
            CLSHClassifyModel *model=[CLSHClassifyModel mj_objectWithKeyValues:baseModel.content];
            if (model.hasNew) {
                completion(YES,model);
            }else{
                
            }
            
        }else if (baseModel.code==ResponseOperaError){
//             completion(NO,@"已经加载最新数据");
        }
        else{
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}

@end

@implementation CLSHClassifyRootModel


@end


@implementation CLSHClassifyProductCategoryModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"menuID":@"id"};
}

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"children":[CLSHClassifyProductSecCategoryModel class]};
}

@end


@implementation CLSHClassifyProductSecCategoryModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"menuID":@"id"};
}

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"children":[CLSHClassifyProductSecCategoryItemModel class]};
}

@end


@implementation CLSHClassifyProductSecCategoryItemModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"menuID":@"id"};
}

@end


@class CLSHGoodsListDetailModel;
@implementation CLSHGoodsListModel

+ (NSDictionary *)mj_objectClassInArray{

    return @{@"goodsList":[CLSHGoodsListDetailModel class]};
}

- (void)fetchGoodsListModel:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion{

    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Classify_GoodsList];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
       
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            CLSHGoodsListModel *model=[CLSHGoodsListModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}



@end

@class CLSHGoodsListDetailModel;
@implementation CLSHGoodsSearchModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"goodsList":[CLSHGoodsListDetailModel class]};
}

- (void)fetchSearchGoodsModel:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion{
    
    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Classify_SearchList];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            CLSHGoodsSearchModel *model=[CLSHGoodsSearchModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
    
}

@end


@implementation CLSHGoodsListDetailModel

@end



@implementation CLSHHotSearchModel

- (void)fetchHotSearchModel:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Classify_HotSearch];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:params success:^(id response) {
        
        completion(YES,response);
        
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}

@end
