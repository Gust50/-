//
//  CLSHNeighborhoodModel.m
//  ClshUser
//
//  Created by kobe on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNeighborhoodModel.h"

@implementation CLSHNeighborhoodModel

-(void)fetchNeighborhoodData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Neighborhood_Merchant];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}

@end




@implementation CLSHNeighborhoodJqueryModel

+ (NSDictionary *)mj_objectClassInArray{

    return @{@"sliderAd":[CLSHNeighborhoodJqueryListModel class],@"shopIndustry":[CLSHNeighborhoodSquareModel class]};
}

-(void)fetchNeighborhoodJqueryData:(NSDictionary *)params
                          callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Neighborhood_Jquery];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            CLSHNeighborhoodJqueryModel *model=[CLSHNeighborhoodJqueryModel mj_objectWithKeyValues:baseModel.content];
            
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



@implementation CLSHNeighborhoodJqueryListModel

@end

//@2
@implementation CLSHNeighborhoodSquareModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"industryID":@"ID"};
}

@end


@implementation CLSHNeighborhoodMerchantLeftModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"shopCategories":[CLSHNeighborhoodMerchantLeftCategoryListModel class]};
    
}
-(void)fetchNeighborhoodMerchantLeftData:(NSDictionary *)params
                                callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Neighborhood_MerchantProduct];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            
            CLSHNeighborhoodMerchantLeftModel * neighbourhoodMerchantLeftModel = [CLSHNeighborhoodMerchantLeftModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,neighbourhoodMerchantLeftModel);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}
@end



@implementation CLSHNeighborhoodMerchantLeftCategoryListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"leftCategoryID":@"id"};
}
@end



@implementation CLSHNeighborhoodMerchantRightModel

+(NSDictionary *)mj_objectClassInArray{

    return @{@"goodsList":[CLSHNeighborhoodMerchantRightGoodsListModel class]};
}

-(void)fetchNeighborhoodMerchantRightData:(NSDictionary *)params
                                 callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Neighborhood_MerchantProductCategory];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
       
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess || baseModel.code == ResponseWarmMessage) {
            CLSHNeighborhoodMerchantRightModel * model = [CLSHNeighborhoodMerchantRightModel mj_objectWithKeyValues:baseModel.content];
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



@implementation CLSHNeighborhoodMerchantRightGoodsListModel

+ (NSDictionary *)mj_objectClassInArray{
 
    return @{@"products":[CLSHNeighborhoodMerchantRightGoodsListProductsModel class],@"images":[CLSHNeighborhoodMerchantRightGoodsImagesModel class]};
}
@end

/**
 *  多规格下产品
 */
@implementation CLSHNeighborhoodMerchantRightGoodsListProductsModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"productsId":@"id"};
}
@end



@implementation CLSHNeighborhoodMerchantRightGoodsImagesModel

@end



@implementation CLSHNeighborhoodMerchantRemarkModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"assessments":[CLSHNeighborhoodMerchantRemarkListModel class]};
}
-(void)fetchNeighborhoodMerchantRemarkData:(NSDictionary *)params
                                  callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Neighborhood_MerchantRamark];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHNeighborhoodMerchantRemarkModel * model = [CLSHNeighborhoodMerchantRemarkModel mj_objectWithKeyValues:baseModel.content];
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


@implementation CLSHNeighborhoodMerchantRemarkListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"remarkId":@"id"};
}

@end


@implementation CLSHNeighborhoodMerchantRemarkAnswerModel

@end

@implementation CLSHNeighborhoodMerchantIntroductModel

-(void)fetchNeighborhoodMerchantIntroductData:(NSDictionary *)params
                                     callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Neighborhood_MerchantIntroduce];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHNeighborhoodMerchantIntroductModel * model = [CLSHNeighborhoodMerchantIntroductModel mj_objectWithKeyValues:baseModel.content];
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


@implementation CLSHNeighborhoodMerchantProductGoodsModel

- (void)fetchNeighborhoodMerchantProductDetailData:(NSString *)str callBack:(void (^)(BOOL, id))completion{
    
    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Neighborhood_merChantProductDetail];
    [[KBHttpTool shareKBHttpToolManager] postNoJson:url postData:str success:^(id response) {
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            CLSHNeighborhoodMerchantProductGoodsModel * model = [CLSHNeighborhoodMerchantProductGoodsModel mj_objectWithKeyValues:baseModel.content];
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




@implementation CLSHNeighborhoodMerchantProductDetailGoodsModel

+ (NSDictionary *)mj_objectClassInArray{

    return @{@"specificationItems":[CLSHNeighborhoodMerchantProductSpecificationModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"goodsId":@"id"};
}


@end



@implementation CLSHNeighborhoodMerchantProductSpecificationModel

+ (NSDictionary *)mj_objectClassInArray{

    return @{@"entries":[CLSHNeighborhoodMerchantProductDetailSpecificationModel class]};
}

@end



@implementation CLSHNeighborhoodMerchantProductDetailSpecificationModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"specificationId":@"id"};
}

@end



@class CLSHNeighbourhoodServiceListModel;
@implementation CLSHNeighbourHoodServiceModel


+ (NSDictionary *)mj_objectClassInArray{

    return @{@"items":[CLSHNeighbourhoodServiceListModel class]};
}

- (void)fetchNeighbourhoodServiceData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Neighborhood_Merchant];
   
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            CLSHNeighbourHoodServiceModel * model = [CLSHNeighbourHoodServiceModel mj_objectWithKeyValues:baseModel.content];
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



@implementation CLSHNeighbourhoodServiceListModel


@end









