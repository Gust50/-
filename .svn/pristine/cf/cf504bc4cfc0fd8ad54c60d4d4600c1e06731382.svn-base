//
//  CLSHTodayDataTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/11/21.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHTodayDataTableViewCell.h"
#import "CLSHOpenDataModel.h"

@implementation CLSHTodayDataTableViewCell

#pragma mark <lazy load>
- (UIView *)backView{
    
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 10;
    }
    return _backView;
}

- (UILabel *)todayDataLabel{

    if (!_todayDataLabel) {
        _todayDataLabel = [[UILabel alloc] init];
        _todayDataLabel.text = @"今日平台数据";
        _todayDataLabel.textColor = systemColor;
        _todayDataLabel.font = [UIFont systemFontOfSize:12*pro];
        _todayDataLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _todayDataLabel;
}

- (UIView *)line1View{
    
    if (!_line1View) {
        _line1View = [[UIView alloc] init];
        _line1View.backgroundColor = RGBColor(220, 220, 220);
    }
    return _line1View;
}

- (UILabel *)transformNumDescribeLabel{

    if (!_transformNumDescribeLabel) {
        _transformNumDescribeLabel = [[UILabel alloc] init];
        _transformNumDescribeLabel.text = @"交易金额";
        _transformNumDescribeLabel.font = [UIFont systemFontOfSize:12*pro];
        _transformNumDescribeLabel.textColor = RGBColor(102, 102, 102);
    }
    return _transformNumDescribeLabel;
}

- (UILabel *)transformNumLabel{

    if (!_transformNumLabel) {
        _transformNumLabel = [[UILabel alloc] init];
        _transformNumLabel.textColor = RGBColor(239, 47, 12);
        _transformNumLabel.font = [UIFont systemFontOfSize:12*pro];
        _transformNumLabel.textAlignment = NSTextAlignmentRight;
    }
    return _transformNumLabel;
}

- (UIView *)line2View{
    
    if (!_line2View) {
        _line2View = [[UIView alloc] init];
        _line2View.backgroundColor = RGBColor(220, 220, 220);
    }
    return _line2View;
}

- (UILabel *)profitDescribeLabel{
    
    if (!_profitDescribeLabel) {
        _profitDescribeLabel = [[UILabel alloc] init];
        _profitDescribeLabel.text = @"利润金额";
        _profitDescribeLabel.textColor = RGBColor(102, 102, 102);
        _profitDescribeLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return _profitDescribeLabel;
}

- (UILabel *)profitLabel{
    
    if (!_profitLabel) {
        _profitLabel = [[UILabel alloc] init];
        _profitLabel.textColor = RGBColor(239, 47, 12);
        _profitLabel.font = [UIFont systemFontOfSize:12*pro];
        _profitLabel.textAlignment = NSTextAlignmentRight;
    }
    return _profitLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = RGBColor(44, 170, 87);
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.backView];
    [_backView addSubview:self.todayDataLabel];
    [_backView addSubview:self.line1View];
    [_backView addSubview:self.transformNumDescribeLabel];
    [_backView addSubview:self.transformNumLabel];
    [_backView addSubview:self.line2View];
    [_backView addSubview:self.profitDescribeLabel];
    [_backView addSubview:self.profitLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [_todayDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top);
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_line1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_todayDataLabel.mas_bottom);
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.height.equalTo(@1);
    }];
    
    [_transformNumDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line1View.mas_bottom);
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_transformNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line1View.mas_bottom);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.bottom.equalTo(_transformNumDescribeLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [_profitDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2View.mas_bottom);
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2View.mas_bottom);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.height.equalTo(@(30*pro));
    }];
}

- (void)setModel:(CLSHOpenDataModel *)model{

    _model = model;
    
    NSString *VlumeNum = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:model.todayVolume]];
    _transformNumLabel.text = [NSString stringWithFormat:@"%@",VlumeNum];
    NSString *profitNum = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:model.todayProfit]];
    _profitLabel.text = [NSString stringWithFormat:@"%@",profitNum];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
