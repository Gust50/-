//
//  CLSHHomeShoppingDetailSizeView.m
//  ClshUser
//
//  Created by kobe on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHomeShoppingDetailSizeView.h"
#import "Masonry.h"

@interface CLSHHomeShoppingDetailSizeView ()

@property(nonatomic,strong)UIImageView *arrow;

@end

@implementation CLSHHomeShoppingDetailSizeView


-(UILabel *)shopSize{
    
    if (!_shopSize) {
        _shopSize=[[UILabel alloc]init];
        _shopSize.font=[UIFont systemFontOfSize:14];
        _shopSize.text=@"颜色、尺寸";
    }
    return _shopSize;
}

-(UIImageView *)arrow{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
    }
    return _arrow;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        
        [self initUI];
    }
    return self;
}


-(void)initUI{
    
    [self addSubview:self.shopSize];
    [self addSubview:self.arrow];
    [self updateConstraints];
    
}

-(void)updateConstraints{
    
    [super updateConstraints];
    WS(weakSelf);
    
    [_shopSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
}
@end
