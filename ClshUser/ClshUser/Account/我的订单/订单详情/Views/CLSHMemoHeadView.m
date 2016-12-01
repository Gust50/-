//
//  CLSHMemoHeadView.m
//  ClshUser
//
//  Created by arom on 16/9/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMemoHeadView.h"
#import "Masonry.h"

@implementation CLSHMemoHeadView

- (UIImageView *)icon{
    
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"EmailIcon"];
    }
    return _icon;
}

- (UILabel *)nameLabel{
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text =@"买家留言";
        _nameLabel.font = [UIFont systemFontOfSize:13*pro];
    }
    return _nameLabel;
}

- (UILabel *)describeLabel{

    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.textColor = RGBColor(51, 51, 51);
        _describeLabel.font = [UIFont systemFontOfSize:12*pro];
        _describeLabel.textAlignment = NSTextAlignmentLeft;
        _describeLabel.numberOfLines = 0;
    }
    return _describeLabel;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        [self initUI];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI{
    
    [self addSubview:self.icon];
    [self addSubview: self.nameLabel];
    [self addSubview:self.describeLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
    WS(weakSelf);
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(16*pro));
        make.width.equalTo(@(15*pro));
        
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(10*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.equalTo(@(65*pro));
        make.height.equalTo(@(20*pro));
    }];
    
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_nameLabel.mas_right).with.offset(3*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*pro));
        make.right.equalTo(weakSelf.mas_right).with.offset(-5*pro);
    }];
}


@end
