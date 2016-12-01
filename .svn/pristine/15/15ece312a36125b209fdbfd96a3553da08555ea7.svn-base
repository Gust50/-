//
//  CLGSAccountListCell.m
//  粗粮
//
//  Created by wutaobo on 16/5/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSAccountListCell.h"
#import "Masonry.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface CLGSAccountListCell ()

@end

@implementation CLGSAccountListCell

#pragma makr <lazyLoad>
-(UIImageView *)imageV{
    if (!_imageV) {
        _imageV=[[UIImageView alloc]init];
    }
    return _imageV;
}

- (UILabel *)leftLabel
{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textColor = [UIColor blackColor];
        _leftLabel.font = [UIFont systemFontOfSize:14*pro];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = [UIColor lightGrayColor];
        _rightLabel.font = [UIFont systemFontOfSize:12*pro];
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.imageV];
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(25*pro, 25*pro));
    }];
    
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageV.mas_right).with.offset(10*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(150*pro, 15*pro));
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right).with.offset(-30*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.mas_equalTo(@(15*pro));
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
