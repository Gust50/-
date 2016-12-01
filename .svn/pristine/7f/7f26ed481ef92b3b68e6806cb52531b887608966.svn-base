//
//  CLSHFirstCommentCell.m
//  ClshUser
//
//  Created by arom on 16/6/14.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHFirstCommentCell.h"
#import "Masonry.h"
#import "CLGSStarRate.h"
#import "CLSHHomeProductDetailModel.h"
#import "NSString+KBExtension.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface CLSHFirstCommentCell (){

    
}

@property(nonatomic,strong)UILabel *firstComment;
@property(nonatomic,strong)UIImageView *userIcon;
@property(nonatomic,strong)UILabel *userName;
@property(nonatomic,strong)UILabel *remark;
@property(nonatomic,strong)UIButton *allRemark;
@property (nonatomic,assign)CGFloat labelHeight;

@end

@implementation CLSHFirstCommentCell

#pragma mark <lazyLoad>

-(UILabel *)firstComment{
    if (!_firstComment) {
        _firstComment=[[UILabel alloc]init];
        _firstComment.font=[UIFont systemFontOfSize:13*pro];
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
        _userName.font = [UIFont systemFontOfSize:13*pro];
        _userIcon.layer.masksToBounds = YES;
        _userIcon.layer.cornerRadius = 20*pro;
    }
    return _userName;
}

-(UILabel *)remark{
    if (!_remark) {
        _remark=[[UILabel alloc]init];
        _remark.text = @"作为一个IOS程序员，闲的时候也想自己做一个app练练手，又苦于没有UI设计，也没有好的idea，所以只能先模仿别人的App了，但是也会遇到以下问题";
        _remark.font = [UIFont systemFontOfSize:11*pro];
        _remark.numberOfLines = 0;
        self.labelHeight = 20*pro;
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
        _allRemark.titleLabel.font=[UIFont systemFontOfSize:13*pro];
        [_allRemark setTitle:@"查看全部评价" forState:UIControlStateNormal];
        [_allRemark setTitleColor:systemColor forState:UIControlStateNormal];
        [_allRemark addTarget:self action:@selector(seeAllRemark) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allRemark;
}

#pragma mark <init>
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


#pragma mark <add UI>
-(void)setupUI{
    [self addSubview:self.firstComment];
    [self addSubview:self.userIcon];
    [self addSubview:self.userName];
    [self addSubview:self.remark];
    [self addSubview:self.allRemark];
    
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    
    [_firstComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(5*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(15*pro));
    }];
    
    [_userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstComment.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(5*pro);
        make.size.mas_equalTo(CGSizeMake(40*pro, 40*pro));
    }];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userIcon.mas_right).with.offset(10*pro);
        make.top.equalTo(_firstComment.mas_bottom).with.offset(15*pro);
        make.size.mas_equalTo(CGSizeMake(100*pro, 20*pro));
    }];
    
    [_remark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userIcon.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        
    }];
    
    [_remark mas_updateConstraints:^(MASConstraintMaker *make) {
        
       make.height.mas_equalTo(@(_labelHeight));
        
    }];
    
    [_allRemark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*pro);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(120, 30*pro));
    }];
}

- (void)setProductDetailRemarkModel:(CLSHHomeProductDetailRemarkModel *)ProductDetailRemarkModel{
    
    _ProductDetailRemarkModel = ProductDetailRemarkModel;
    self.firstComment.text = [NSString stringWithFormat:@"商品评价(%ld)",[ProductDetailRemarkModel.totalReviewCount integerValue]];
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:ProductDetailRemarkModel.image] placeholderImage:nil];
    self.userName.text = ProductDetailRemarkModel.name;
    self.remark.text = ProductDetailRemarkModel.content;
    
    CGSize  size = [NSString sizeWithStr:ProductDetailRemarkModel.content font:[UIFont systemFontOfSize:18] width:SCREENWIDTH-20*pro];
    self.labelHeight = size.height;
    NSLog(@"-------------%lf",self.labelHeight);
    
}

//查看全部评价
- (void)seeAllRemark
{
    if (self.seeAllRemarkBlock) {
        self.seeAllRemarkBlock();
    }
}

@end
