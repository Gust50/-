//
//  CLGSAccountBottomView.m
//  粗粮
//
//  Created by kobe on 16/5/20.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSAccountBottomView.h"
#import "KBLabel.h"
#import "Masonry.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface CLGSAccountBottomView()
{
    UITapGestureRecognizer *labelTapGesture;
}
/** 申请提现 */
@property(nonatomic,strong)KBLabel *pointDetail;
/** 积分详情 */
@property(nonatomic,strong)KBLabel *fetchMoney;

@property(nonatomic,strong)UILabel *middleLine;

@end

@implementation CLGSAccountBottomView

#pragma mark <lazyLoad>
-(UILabel *)balance{
    if (!_balance) {
        _balance=[[UILabel alloc]init];
        _balance.text = @"余额：1288.00元";
        _balance.textAlignment = NSTextAlignmentCenter;
        _balance.textColor = [UIColor whiteColor];
        _balance.font = [UIFont systemFontOfSize:13*pro];
    }
    return _balance;
}

-(KBLabel *)fetchMoney{
    if (!_fetchMoney) {
        _fetchMoney=[[KBLabel alloc]init];
        _fetchMoney.type=bottomLine;
        _fetchMoney.text=@"申请提现";
        _fetchMoney.textColor = [UIColor whiteColor];
        _fetchMoney.font=[UIFont systemFontOfSize:11*pro];
        _fetchMoney.labelFont=[UIFont systemFontOfSize:11*pro];
        _fetchMoney.lineColor=[UIColor whiteColor];
        _fetchMoney.textAlignment = NSTextAlignmentCenter;
        _fetchMoney.userInteractionEnabled = YES;
        labelTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addLabelGesture:)];
        [_fetchMoney addGestureRecognizer:labelTapGesture];
    }
    return _fetchMoney;
}

-(UILabel *)spreadPoint{
    if (!_spreadPoint) {
        _spreadPoint=[[UILabel alloc]init];
        _spreadPoint.text = @"推广积分：200分";
        _spreadPoint.textColor = [UIColor whiteColor];
        _spreadPoint.font = [UIFont systemFontOfSize:13*pro];
        _spreadPoint.textAlignment = NSTextAlignmentCenter;
    }
    return _spreadPoint;
}

-(KBLabel *)pointDetail{
    if (!_pointDetail) {
        _pointDetail=[[KBLabel alloc]init];
        _pointDetail.type=bottomLine;
        _pointDetail.text=@"积分详情";
        _pointDetail.textColor = [UIColor whiteColor];
        _pointDetail.font=[UIFont systemFontOfSize:11*pro];
        _pointDetail.labelFont=[UIFont systemFontOfSize:11*pro];
        _pointDetail.lineColor=[UIColor whiteColor];
        _pointDetail.textAlignment = NSTextAlignmentCenter;
        _pointDetail.userInteractionEnabled = YES;
        labelTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addLabelGesture:)];
        [_pointDetail addGestureRecognizer:labelTapGesture];
    }
    return _pointDetail;
}

-(UILabel *)middleLine{
    if (!_middleLine) {
        _middleLine=[[UILabel alloc]init];
        _middleLine.backgroundColor = [UIColor whiteColor];
    }
    return _middleLine;
}

- (void)addLabelGesture:(UITapGestureRecognizer *)recognizer
{
    if (self.applicationWithdrawalsBlock) {
        self.applicationWithdrawalsBlock();
    }
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = RGBAColor(0, 0, 0, 0.5);
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.balance];
    [self addSubview:self.fetchMoney];
    [self addSubview:self.spreadPoint];
    [self addSubview:self.pointDetail];
    [self addSubview:self.middleLine];
    [self updateConstraints];
    
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    
    [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(5*pro);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-5*pro);
        make.width.mas_equalTo(@(1));
    }];
    
    
    [_balance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(_middleLine.mas_left);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    
    [_spreadPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(_middleLine.mas_right);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(20*pro));
        
    }];
    
    [_fetchMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_balance.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(_middleLine.mas_left);
        make.height.mas_equalTo(@(15*pro));
        
    }];
    
    [_pointDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_spreadPoint.mas_bottom);
        make.left.equalTo(_middleLine.mas_right);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(15*pro));
    }];
    
}






@end
