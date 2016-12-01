//
//  CLSHEvaluationTableViewCell.h
//  ClshUser
//
//  Created by arom on 16/6/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cameraBlock)();
typedef void(^goodCommentBlock)();
typedef void(^middleCommentBlock)();
typedef void(^badCommentBlock)();
typedef void(^delectImageBlock)(NSIndexPath *indexPath,NSInteger buttonTag);
typedef void(^commentTextBlock)(NSString *content);


@class CLSHAccountOrderDetailOneModel;
@interface CLSHEvaluationTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView * image;       ///<商品图片
@property (nonatomic,strong)UITextView * evaluationView;  ///<评价
@property (nonatomic,strong)UIButton * cameraButton;        ///<相机button
@property (nonatomic,strong)UIScrollView * scrollview;      ///<滑动视图
@property (nonatomic,strong)UILabel * attentionLable;       ///<注意事项
@property (nonatomic,strong)UIView * lineView;
@property (nonatomic,strong)UIButton * goodComment;         ///好评
@property (nonatomic,strong)UIButton * middleComment;        ///中评
@property (nonatomic,strong)UIButton * badComment;          ///<差评


@property (nonatomic,copy)NSString * placeHolder;        //默认文字
@property (nonatomic,strong)UIColor * placeholderColor;  //默认文字颜色

@property (nonatomic,strong)NSMutableArray * picArr;

@property (nonatomic,copy)cameraBlock camerablock;
@property (nonatomic,copy)goodCommentBlock goodCommentblock;
@property (nonatomic,copy)middleCommentBlock middleCommentblock;
@property (nonatomic,copy)badCommentBlock badCommentblock;
@property (nonatomic, copy) delectImageBlock delectImageBlock;
@property (nonatomic, copy) commentTextBlock commentTextBlock;


@property (nonatomic,strong)CLSHAccountOrderDetailOneModel * model;
@property (nonatomic, assign) NSIndexPath *indexPath;    ///<index

@end
