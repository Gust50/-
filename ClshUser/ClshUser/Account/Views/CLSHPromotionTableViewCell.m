//
//  CLSHPromotionTableViewCell.m
//  ClshUser
//
//  Created by kobe on 16/9/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHPromotionTableViewCell.h"
#import "Masonry.h"
@implementation CLSHPromotionTableViewCell



//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = RGBColor(51, 51, 51);
        _label.font = [UIFont systemFontOfSize:15*pro];
        _label.text = @"11111";
    }
    return _label;
}

- (UILabel *)labelDeltail{
    if (!_labelDeltail) {
        _labelDeltail = [[UILabel alloc] init];
        _labelDeltail.textColor = RGBColor(102, 102, 102);
        _labelDeltail.font = [UIFont systemFontOfSize:11*pro];
        _labelDeltail.text = @"2222";
    }
    return _labelDeltail;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.label];
    [self addSubview:self.labelDeltail];

    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(8*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(8*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-8*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_labelDeltail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(8*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-8*pro);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-8*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
}



@end
