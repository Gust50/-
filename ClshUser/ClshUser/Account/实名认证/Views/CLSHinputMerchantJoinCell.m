//
//  CLSHinputMerchantJoinCell.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHinputMerchantJoinCell.h"
#import "Masonry.h"

@interface CLSHinputMerchantJoinCell ()<UITextFieldDelegate>

@end
@implementation CLSHinputMerchantJoinCell

-(UILabel *)leftName
{
    if (!_leftName) {
        _leftName = [[UILabel alloc] init];
        _leftName.text = @"店铺名称:";
        _leftName.font = [UIFont systemFontOfSize:13*pro];
    }
    return _leftName;
}

-(UITextField *)inputInfo
{
    if (!_inputInfo) {
        _inputInfo = [[UITextField alloc] init];
        _inputInfo.font = [UIFont systemFontOfSize:13*pro];
        _inputInfo.placeholder = @"请输入店铺名称";
        _inputInfo.borderStyle = UITextBorderStyleNone;
        _inputInfo.userInteractionEnabled = YES;
        _inputInfo.delegate = self;
    }
    return _inputInfo;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.leftName];
    [self addSubview:self.inputInfo];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_leftName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(70*pro, 20*pro));
    }];
    
    [_inputInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_leftName.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-10*pro);
        make.height.mas_equalTo(@(30*pro));
    }];
}

#pragma mark <UITextFieldDelegate>

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(nameLabel:inputName:)]) {
        [self.delegate nameLabel:self.leftName.text inputName:self.inputInfo.text];
    }
    return YES;
}
@end
