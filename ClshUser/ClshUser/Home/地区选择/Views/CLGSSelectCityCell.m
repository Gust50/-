//
//  CLGSSelectCityCell.m
//  粗粮
//
//  Created by kobe on 16/5/16.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSSelectCityCell.h"

@interface CLGSSelectCityCell()


@end

@implementation CLGSSelectCityCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier array:(NSArray *)array{

    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createButton:array];
    }
    return self;
}

//计算创建按钮
-(void)createButton:(NSArray *)count{
    
    CGFloat originalX=10;
    CGFloat originalY=5;
    CGFloat btnW=(SCREENWIDTH-10*2-5*3)/4;
    CGFloat btnH=30;
    
    for (int i=0; i<count.count; i++) {
        UIButton *btn=[[UIButton alloc]init];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = RGBColor(230, 230, 230).CGColor;
        [btn setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
        [btn setTitle:count[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13*pro];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(ClickButton:) forControlEvents:(UIControlEventTouchUpInside)];
        
        if (originalX>SCREENWIDTH-10) {
            originalX=10;
            originalY+=35;
            btn.frame=CGRectMake(originalX, originalY*pro, btnW, btnH*pro);
            originalX+=(btnW+5);
        }else{
            btn.frame=CGRectMake(originalX, originalY*pro, btnW, btnH*pro);
            originalX+=(btnW+5);
        }
        [self addSubview:btn];
    }
}

- (void)ClickButton:(UIButton *)sender{

    if (self.ClickButtonblock) {
        self.ClickButtonblock(sender.tag);
    }
}

#pragma mark <getter setter>
-(void)setButtonArray:(NSArray *)buttonArray{
    _buttonArray=buttonArray;
    
}

@end
