//
//  CLGSCategoryCell.m
//  粗粮
//
//  Created by kobe on 16/5/19.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSCategoryCell.h"
#import "Masonry.h"
#import "CLSHClassifyModel.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface CLGSCategoryCell()

@end


@implementation CLGSCategoryCell

#pragma mark <lazyLoad>
-(UIImageView *)icon{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
    }
    return _icon;
}

-(UILabel *)name{
    if (!_name) {
        _name=[[UILabel alloc]init];
        _name.textAlignment=NSTextAlignmentCenter;
        _name.font = [UIFont systemFontOfSize:10*pro];
        _name.textColor = RGBColor(120, 120, 120);
    }
    return _name;
}

#pragma mark <init>
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


#pragma mark <UI>
-(void)setupUI{
    
    [self addSubview:self.icon];
    [self addSubview:self.name];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(8*pro);
        //make.centerX.equalTo(weakSelf.mas_centerX);
        make.left.equalTo(weakSelf.mas_left).with.offset(8*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-8*pro);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-25*pro);
        //make.size.mas_equalTo(CGSizeMake(60*pro, 45*pro));
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_bottom).with.offset(5*pro);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-5*pro);
//        make.height.mas_equalTo(@(12*pro));
    }];
    
}

//-(void)prepareForReuse{
//    [super prepareForReuse];
//    self.name.text=nil;
//    self.icon.image=nil;
//}
- (void)setModel:(CLSHClassifyProductSecCategoryItemModel *)model{
    
    _model = model;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.name.text = model.name;
}
@end
