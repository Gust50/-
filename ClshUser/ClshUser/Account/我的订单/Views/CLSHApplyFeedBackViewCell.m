//
//  CLSHApplyFeedBackViewCell.m
//  ClshUser
//
//  Created by arom on 16/8/11.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHApplyFeedBackViewCell.h"
#import "Masonry.h"

@implementation CLSHApplyFeedBackViewCell

#pragma mark -- 懒加载
- (UIButton *)cancelButton{

    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
        [_cancelButton setTitleColor:RGBColor(52, 52, 52) forState:(UIControlStateNormal)];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14*pro];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _cancelButton;
}

- (UILabel *)desbribLabel{

    if (!_desbribLabel) {
        _desbribLabel = [[UILabel alloc] init];
        _desbribLabel.text = @"选择退货原因";
        _desbribLabel.textColor = RGBColor(102, 102, 102);
        _desbribLabel.font = [UIFont systemFontOfSize:14*pro];
        _desbribLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _desbribLabel;
}

- (UIButton *)confirmButton{

    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_confirmButton setTitle:@"确定" forState:(UIControlStateNormal)];
        [_confirmButton setTitleColor:systemColor forState:(UIControlStateNormal)];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:14*pro];
        [_confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _confirmButton;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.cancelButton];
    [self addSubview:self.desbribLabel];
    [self addSubview:self.confirmButton];
    
    [self updateConstraints];
}

- (void)cancelButtonClick{

    if (self.cancelblock) {
        self.cancelblock();
    }
}

- (void)confirmButtonClick{

    if (self.confirmblock) {
        self.confirmblock();
    }
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(8*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(30*pro));
        make.width.equalTo(@(60*pro));
    }];
    
    [_desbribLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_cancelButton.mas_right).with.offset(0);
        make.right.equalTo(_confirmButton.mas_left).with.offset(0);
        make.height.equalTo(@(30*pro));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.right.equalTo(weakSelf.mas_right).with.offset(-8*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(30*pro));
        make.width.equalTo(@(60*pro));
    }];
}



@end
