//
//  CLSHYestodayDataTableViewCell.h
//  ClshUser
//
//  Created by arom on 16/11/21.
//  Copyright © 2016年 50. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLSHOpenDataModel;
@interface CLSHYestodayDataTableViewCell : UITableViewCell

@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UILabel *yestodayDataLabel;
@property (nonatomic, strong)UIView *line1View;
@property (nonatomic, strong)UILabel *transLateSumDescribeLabel;
@property (nonatomic, strong)UILabel *translateSumLabel;
@property (nonatomic, strong)UIView *line2View;
@property (nonatomic, strong)UILabel *AwardDescribeLabel;
@property (nonatomic, strong)UILabel *AwardLabel;
@property (nonatomic, strong)UIView *line3View;
@property (nonatomic, strong)UILabel *profitDescribeLabel;
@property (nonatomic, strong)UILabel *profirLabel;
@property (nonatomic, strong)UILabel *attenLabel;

@property (nonatomic, strong)CLSHOpenDataModel *model;

@end
