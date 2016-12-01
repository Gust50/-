//
//  CLGSAccountListDotCell.m
//  粗粮
//
//  Created by wutaobo on 16/5/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSAccountListDotCell.h"
#import "CLGSDotView.h"

@interface CLGSAccountListDotCell ()


@end

@implementation CLGSAccountListDotCell

#pragma mark <init>
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier nameArray:(NSArray *)nameArray iconArray:(NSArray *)iconArray {
    
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createButton:nameArray iconButtn:iconArray];
    }
    return self;
}

//计算创建按钮
-(void)createButton:(NSArray *)count iconButtn:(NSArray *)iconArray{
    
    CGFloat originalX=10;
    CGFloat originalY=10;
    CGFloat btnW=(SCREENWIDTH-10*2-10*3)/4;
    CGFloat btnH=40;
    
    for (int i=0; i<count.count; i++) {
        UIButton *btn=[[UIButton alloc]init];
        btn.titleEdgeInsets=UIEdgeInsetsMake(35, 0, 0, 0);
        btn.imageEdgeInsets=UIEdgeInsetsMake(0, 30, 10, 0);
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitle:count[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:iconArray[i]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        if (originalX>SCREENWIDTH-10) {
            originalX=10;
            originalY+=35;
            btn.frame=CGRectMake(originalX, originalY, btnW, btnH);
            originalX+=(btnW+10);
        }else{
            btn.frame=CGRectMake(originalX, originalY, btnW, btnH);
            originalX+=(btnW+10);
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
