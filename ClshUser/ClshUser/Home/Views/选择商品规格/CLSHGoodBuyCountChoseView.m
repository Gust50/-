//
//  CLSHGoodBuyCountChoseView.m
//  ClshUser
//
//  Created by wutaobo on 16/6/24.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHGoodBuyCountChoseView.h"
#import "KBCountView.h"
#import "Masonry.h"

@interface CLSHGoodBuyCountChoseView()<KBCountViewDelegate>
@property (nonatomic, strong) UILabel *buyCount; ///<购买数量Label
@property (nonatomic, strong) KBCountView *countView;  ///<选择购买数量
@property (nonatomic, strong) UILabel *line;

@end
@implementation CLSHGoodBuyCountChoseView

#pragma mark-getter setter
-(UILabel *)buyCount{
    if (!_buyCount) {
        _buyCount=[[UILabel alloc]init];
        _buyCount.font = [UIFont systemFontOfSize:14*pro];
        _buyCount.text = @"购买数量";
    }
    return _buyCount;
}

-(UILabel *)line{
    if (!_line) {
        _line=[[UILabel alloc]init];
        _line.backgroundColor = backGroundColor;
    }
    return _line;
}

-(KBCountView *)countView
{
    if (!_countView) {
        _countView = [[KBCountView alloc] init];
        _countView.layer.cornerRadius = 3.0;
        _countView.layer.masksToBounds = YES;
        _countView.delegate=self;
    }
    return _countView;
}

#pragma mark-init UI
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.buyCount];
    [self addSubview:self.countView];
    [self addSubview:self.line];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_buyCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(100*pro, 20*pro));
    }];
    
    [_countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.size.mas_equalTo(CGSizeMake(100*pro, 25*pro));
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(2*pro);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(2*pro));
    }];
}


#pragma mark <KBCountViewDelegate>
-(void)KBCountViewMinus:(NSString *)numner{
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeShoppingNumbers:)])
    {
        [self.delegate changeShoppingNumbers:numner];
    }
}

-(void)KBCountViewPlus:(NSString *)number{
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeShoppingNumbers:)])
    {
        [self.delegate changeShoppingNumbers:number];
    }
}

-(void)KBCountViewOther:(NSString *)number
{
    
}

#pragma mark - setter getter
-(void)setMaxNumber:(NSInteger)maxNumber
{
    _maxNumber = maxNumber;
    self.countView.maxNumber = maxNumber;
    self.countView.currentNum = @"1";
}

@end
