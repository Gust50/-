//
//  CLSHOrderDetailHeadView.m
//  ClshUser
//
//  Created by arom on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHOrderDetailHeadView.h"
#import "Masonry.h"

@implementation CLSHOrderDetailHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIImageView *)icon{

    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"专卖店"];
    }
    return _icon;
}

- (UILabel *)nameLabel{

    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text =@"订单详情";
        _nameLabel.font = [UIFont systemFontOfSize:13*pro];
    }
    return _nameLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.icon];
    [self addSubview: self.nameLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(15*pro));
        
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
    }];
}


@end
