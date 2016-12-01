//
//  CLSHHomeShoppingDetailCommentView.m
//  ClshUser
//
//  Created by kobe on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHomeShoppingDetailCommentView.h"
#import "Masonry.h"
#import "CLGSStarRate.h"

@implementation CLSHHomeShoppingDetailCommentView


#pragma mark <lazyLoad>

-(UILabel *)firstComment{
    if (!_firstComment) {
        _firstComment=[[UILabel alloc]init];
        _firstComment.font=[UIFont systemFontOfSize:14];
        _firstComment.text=@"商品评价 (3)";
    }
    return _firstComment;
}

-(UIImageView *)userIcon{
    if (!_userIcon) {
        _userIcon=[[UIImageView alloc]init];
        _userIcon.image = [UIImage imageNamed:@"EvaluateUserIcon"];
    }
    return _userIcon;
}

-(UILabel *)userName{
    if (!_userName) {
        _userName=[[UILabel alloc]init];
        _userName.text = @"愤怒的小鸟";
        _userName.font = [UIFont systemFontOfSize:12*pro];
    }
    return _userName;
}

-(UILabel *)remarkTime{
    if (!_remarkTime) {
        _remarkTime=[[UILabel alloc]init];
        _remarkTime.text = @"2016-05-04 15:30";
        _remarkTime.font = [UIFont systemFontOfSize:12*pro];
    }
    return _remarkTime;
}

-(UIView *)starRateView{
    if (!_starRateView) {
        _starRateView=[[UIView alloc]init];
    }
    return _starRateView;
}

-(UIButton *)praiseButton{
    if (!_praiseButton) {
        _praiseButton=[[UIButton alloc]init];
        [_praiseButton setImage:[UIImage imageNamed:@"Praise_normal"] forState:UIControlStateNormal];
        [_praiseButton setTitle:@"(23)" forState:UIControlStateNormal];
        [_praiseButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _praiseButton.titleLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return _praiseButton;
}

-(UILabel *)remark{
    if (!_remark) {
        _remark=[[UILabel alloc]init];
        _remark.text = @"安利一个";
        _remark.font = [UIFont systemFontOfSize:12*pro];
    }
    return _remark;
}


-(UIButton *)allRemark{
    if (!_allRemark) {
        _allRemark=[[UIButton alloc]init];
        _allRemark.layer.cornerRadius=5.0;
        _allRemark.layer.masksToBounds=YES;
        _allRemark.layer.borderColor=systemColor.CGColor;
        _allRemark.layer.borderWidth=1.0;
        [_allRemark setTitleColor:systemColor forState:UIControlStateNormal];
        _allRemark.titleLabel.font=[UIFont systemFontOfSize:14];
        [_allRemark setTitle:@"查看全部评价" forState:UIControlStateNormal];
        [_allRemark setTitleColor:systemColor forState:UIControlStateNormal];
    }
    return _allRemark;
}

#pragma mark <init>

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

#pragma mark <add UI>
-(void)setupUI{
    [self addSubview:self.firstComment];
    [self addSubview:self.userIcon];
    [self addSubview:self.userName];
    [self addSubview:self.remarkTime];
    [self addSubview:self.starRateView];
    [self addSubview:self.praiseButton];
    [self addSubview:self.remark];
    [self addSubview:self.allRemark];
    
    starRate=[[CLGSStarRate alloc]initWithFrame:CGRectMake(0, 0, 80, 20) numberOfStars:5];
    starRate.scorePercent=0.5;
    [_starRateView addSubview:starRate];
    
    [self updateConstraints];
}


-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    
    [_firstComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(5);
        make.left.equalTo(weakSelf.mas_left).with.offset(5*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        make.height.mas_equalTo(@(15));
    }];
    
    [_userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstComment.mas_bottom).with.offset(5*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(5*pro);
        make.size.mas_equalTo(CGSizeMake(40*pro, 40*pro));
    }];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userIcon.mas_right).with.offset(5*pro);
        make.top.equalTo(_firstComment.mas_bottom).with.offset(15*pro);
        make.height.mas_equalTo(@(20*pro));
        make.width.mas_equalTo(@(100*pro));
    }];
    
    [_remarkTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstComment.mas_bottom).with.offset(15*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(1);
        make.size.mas_equalTo(CGSizeMake(120*pro, 20*pro));
    }];
    
    [_starRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userIcon.mas_bottom).with.offset(5*pro);
        make.left.equalTo(weakSelf.mas_left);
        make.size.mas_equalTo(CGSizeMake(120*pro, 15*pro));
    }];
    
    [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userIcon.mas_bottom).with.offset(5*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(1);
        make.size.mas_equalTo(CGSizeMake(80*pro, 15*pro));
    }];
    
    
    [_remark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_starRateView.mas_bottom).with.offset(5*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(5*pro);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_allRemark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_remark.mas_bottom).with.offset(5);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
}


@end
