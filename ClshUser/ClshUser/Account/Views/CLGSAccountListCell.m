//
//  CLGSAccountListCell.m
//  粗粮
//
//  Created by wutaobo on 16/5/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSAccountListCell.h"
#import "Masonry.h"

@interface CLGSAccountListCell ()

@property (nonatomic, assign) CGFloat leftWidth;
@end

@implementation CLGSAccountListCell

#pragma makr <lazyLoad>
-(UILabel *)dot{
    if (!_dot) {
        _dot=[[UILabel alloc]init];
        _dot.backgroundColor=[UIColor redColor];
        _dot.font=[UIFont systemFontOfSize:10*pro];
        _dot.textColor=[UIColor whiteColor];
        _dot.layer.cornerRadius=10*pro;
        _dot.layer.borderColor=[UIColor clearColor].CGColor;
        _dot.layer.borderWidth=0;
        _dot.text=@"1";
        _dot.textAlignment=NSTextAlignmentCenter;
        _dot.layer.masksToBounds=YES;
    }
    return _dot;
}

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
        _leftLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = [UIColor lightGrayColor];
        _rightLabel.font = [UIFont systemFontOfSize:14*pro];
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
    [self addSubview:self.dot];
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
        make.height.mas_equalTo(@(15*pro));
    }];
    [_dot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLabel.mas_right).with.offset(3*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20*pro, 20*pro));
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLabel.mas_right);
        make.right.equalTo(weakSelf.mas_right).with.offset(-55*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.mas_equalTo(@(15*pro));
    }];
}

-(void)setLeftStr:(NSString *)leftStr
{
    _leftStr = leftStr;
    self.leftLabel.text = leftStr;
    CGSize size = [NSString sizeWithStr:self.leftLabel.text font:[UIFont systemFontOfSize:18*pro] width:160];
    [self.leftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        self.leftWidth = size.width;
    }];
    
}

#pragma mark - setter getter
-(void)setNotOpenLuckyDrawCount:(NSString *)notOpenLuckyDrawCount
{
    _notOpenLuckyDrawCount = notOpenLuckyDrawCount;
    if ([notOpenLuckyDrawCount isEqualToString:@"0"]) {
        _dot.hidden = YES;
    }else
    {
        _dot.hidden = NO;
        _dot.text = notOpenLuckyDrawCount;
    }
}

@end
