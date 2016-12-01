//
//  CLSHTransferCountsCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/15.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHTransferCountsCell.h"
#import "Masonry.h"

@interface CLSHTransferCountsCell ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *transferCountLabel;
@property (nonatomic, strong) UITextField *inputCount;
@end

@implementation CLSHTransferCountsCell

#pragma mark-getter setter
-(UILabel *)transferCountLabel{
    if (!_transferCountLabel) {
        _transferCountLabel=[[UILabel alloc]init];
        _transferCountLabel.textColor = [UIColor blackColor];
        _transferCountLabel.font = [UIFont systemFontOfSize:13*pro];
        _transferCountLabel.text = @"转入数量";
    }
    return _transferCountLabel;
}

-(UITextField *)inputCount{
    if (!_inputCount) {
        _inputCount=[[UITextField alloc]init];
        _inputCount.font = [UIFont systemFontOfSize:12*pro];
        _inputCount.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputCount.placeholder = @"转入数量须大于100张";
       
    }
    return _inputCount;
}

#pragma mark-init UI

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
        self.inputCount.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange)  name:UITextFieldTextDidChangeNotification object:nil];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)textFieldDidChange{
    
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    
    info[@"foodstamps"]=self.inputCount.text;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"FoodstampsTransferBanlance" object:nil userInfo:info];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text intValue] > [self.useFoodstamps intValue]) {
        textField.text = nil;
        [MBProgressHUD showError:@"粮票不足!"];
    }
}

-(void)setupUI{
    [self addSubview:self.transferCountLabel];
    [self addSubview:self.inputCount];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_transferCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(70*pro, 30*pro));
    }];
    
    [_inputCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_transferCountLabel.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(30*pro));
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.inputCount resignFirstResponder];
    return YES;
}

-(void)setUseFoodstamps:(NSString *)useFoodstamps
{
    _useFoodstamps = useFoodstamps;
}

@end
