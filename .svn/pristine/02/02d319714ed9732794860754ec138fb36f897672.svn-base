//
//  CLSHCommontableViewCell.m
//  ClshUser
//
//  Created by arom on 16/9/29.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHCommontableViewCell.h"

@implementation CLSHCommontableViewCell

#pragma mark -- 懒加载
- (UILabel *)describeLabel{

    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.textColor = RGBColor(242, 51, 47);;
        _describeLabel.font = [UIFont systemFontOfSize:11*pro];
        _describeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _describeLabel;
}

- (UILabel *)commonLabel{

    if (!_commonLabel) {
        _commonLabel = [[UILabel alloc] init];
        _commonLabel.textColor = RGBColor(51, 51, 51);;
        _commonLabel.font = [UIFont systemFontOfSize:13*pro];
        _commonLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _commonLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.commonLabel];
    [self addSubview:self.describeLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_commonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(8*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(30*pro));
    }];
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.equalTo(@(30*pro));
    }];
}

@end
