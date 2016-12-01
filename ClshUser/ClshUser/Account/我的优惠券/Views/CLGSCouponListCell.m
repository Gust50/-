//
//  CLGSCouponListCell.m
//  粗粮
//
//  Created by wutaobo on 16/5/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSCouponListCell.h"

@implementation CLGSCouponListCell


#pragma mark <init>
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier array:(NSArray *)array{
    
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createButton:array];
    }
    return self;
}

//计算创建按钮
-(void)createButton:(NSArray *)count{
    
    CGFloat originalX=10;
    CGFloat originalY=10;
    CGFloat btnW=(SCREENWIDTH-10*2-15*2)/3;
    CGFloat btnH=30;
    
    for (int i=0; i<count.count; i++) {
        UIButton *btn=[[UIButton alloc]init];
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 5.0f;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = RGBColor(0, 149, 68).CGColor;
        [btn setTitleColor:RGBColor(0, 149, 68) forState:UIControlStateNormal];
        [btn setTitle:count[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        if (originalX>SCREENWIDTH-10) {
            originalX=10;
            originalY+=35;
            btn.frame=CGRectMake(originalX, originalY, btnW, btnH);
            originalX+=(btnW+15);
        }else{
            btn.frame=CGRectMake(originalX, originalY, btnW, btnH);
            originalX+=(btnW+15);
        }
        [self addSubview:btn];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
