//
//  CLSHFactoryEvaluationTableViewCell.h
//  ClshUser
//
//  Created by arom on 16/7/13.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^cameraBlock)();
typedef void(^delectImageBlock)(NSIndexPath *indexPath,NSInteger buttonTag);
typedef void(^startRateBlock)(NSInteger score);
typedef void(^commentTextBlock)(NSString *content);

@class CLSHAccountOrderDetailOneModel;
@interface CLSHFactoryEvaluationTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView * image;       ///<商品图片
@property (nonatomic,strong)UITextView * evaluationView;  ///<评价
@property (nonatomic,strong)UIButton * cameraButton;        ///<相机button
@property (nonatomic,strong)UIScrollView * scrollview;      ///<滑动视图
@property (nonatomic,strong)UILabel * attentionLable;       ///<注意事项
@property (nonatomic,strong)UIView * lineView;
@property (nonatomic,strong)UIView * starRateView;          ///<星级

@property (nonatomic,copy)NSString * placeHolder;           ///<默认文字
@property (nonatomic,strong)UIColor * placeholderColor;     ///<默认文字颜色

@property (nonatomic,strong)NSMutableArray * picArr;

@property (nonatomic,copy)cameraBlock camerablock;
@property (nonatomic, copy) delectImageBlock delectImageBlock;
@property (nonatomic, copy) startRateBlock startRateBlock;
@property (nonatomic, copy) commentTextBlock commentTextBlock;



@property (nonatomic,strong)CLSHAccountOrderDetailOneModel * model;
@property (nonatomic, assign) NSIndexPath *indexPath;    ///<index


@end
