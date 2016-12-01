//
//  CLGSDetailCommentCell.m
//  粗粮
//
//  Created by kobe on 16/5/18.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSDetailCommentCell.h"
#import "Masonry.h"
#import "CLGSStarRate.h"
#import "CLSHNeighborhoodModel.h"
#import "CLSHHomeRemarkModel.h"
#import "KBDateFormatter.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface CLGSDetailCommentCell()

{
    CLGSStarRate *starRate;
    CGFloat remarkHeight;   ///<评论高度
}
@property(nonatomic,strong)UIImageView *userIcon;
@property(nonatomic,strong)UILabel *userName;
@property(nonatomic,strong)UILabel *remarkTime;
@property(nonatomic,strong)UIView *starRateView;
@property (nonatomic,strong)UIImageView *firstImage;   ///<评价图片
@property (nonatomic,strong)UIImageView *secondImage;   ///<评价图片
@property (nonatomic,strong)UIImageView *thirdImage;   ///<评价图片
@property (nonatomic,strong)UIImageView *fourImage;   ///<评价图片

@property(nonatomic,strong)UILabel *remark;

@end

@implementation CLGSDetailCommentCell

#pragma mark <lazyLoad>
-(UIImageView *)userIcon{
    if (!_userIcon) {
        _userIcon=[[UIImageView alloc]init];
        _userIcon.image = [UIImage imageNamed:@"EvaluateUserIcon"];
        _userIcon.layer.masksToBounds = YES;
        _userIcon.layer.cornerRadius = 20*pro;
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
        _remarkTime.font = [UIFont systemFontOfSize:10*pro];
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
        _praiseButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5*pro, 0, 0);
        [_praiseButton setImage:[UIImage imageNamed:@"Praise_normal"] forState:UIControlStateNormal];
        
        [_praiseButton setTitle:@"(23)" forState:UIControlStateNormal];
        [_praiseButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _praiseButton.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        [_praiseButton addTarget:self action:@selector(praise) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _praiseButton;
}

-(UILabel *)remark{
    if (!_remark) {
        _remark=[[UILabel alloc]init];
        _remark.text = @"安利一个";
        _remark.font = [UIFont systemFontOfSize:12*pro];
        _remark.numberOfLines = 0;
    }
    return _remark;
}

-(UIImageView *)firstImage
{
    if (!_firstImage) {
        _firstImage = [[UIImageView alloc] init];
    }
    return _firstImage;
}

-(UIImageView *)secondImage
{
    if (!_secondImage) {
        _secondImage = [[UIImageView alloc] init];
    }
    return _secondImage;
}

-(UIImageView *)thirdImage
{
    if (!_thirdImage) {
        _thirdImage = [[UIImageView alloc] init];
    }
    return _thirdImage;
}

-(UIImageView *)fourImage
{
    if (!_fourImage) {
        _fourImage = [[UIImageView alloc] init];
        
    }
    return _fourImage;
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
    [self addSubview:self.userIcon];
    [self addSubview:self.userName];
    [self addSubview:self.remarkTime];
    [self addSubview:self.starRateView];
    [self addSubview:self.praiseButton];
    [self addSubview:self.remark];
    [self addSubview:self.firstImage];
    [self addSubview:self.secondImage];
    [self addSubview:self.thirdImage];
    [self addSubview:self.fourImage];
    [self updateConstraints];
}


-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    [_userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(8*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(8*pro);
        make.size.mas_equalTo(CGSizeMake(40*pro, 40*pro));
    }];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userIcon.mas_right).with.offset(5*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(15*pro);
        make.height.mas_equalTo(@(20*pro));
        make.width.mas_equalTo(@(100*pro));
    }];
    
    [_remarkTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(15*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(1);
        make.size.mas_equalTo(CGSizeMake(120*pro, 20*pro));
    }];
    
    [_starRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userIcon.mas_bottom).with.offset(5*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(20*pro);
        make.size.mas_equalTo(CGSizeMake(120*pro, 15*pro));
    }];
    
    [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userIcon.mas_bottom).with.offset(5*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(1);
        make.size.mas_equalTo(CGSizeMake(80*pro, 15*pro));
    }];
    
    
    [_remark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_starRateView.mas_bottom).with.offset(5*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
    }];
    
    [_remark mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(remarkHeight*pro);
    }];
    
    [_firstImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.top.equalTo(_remark.mas_bottom).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-50*pro)/4, (SCREENWIDTH-50*pro)/4));
    }];
    
    [_secondImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_firstImage.mas_right).with.offset(10*pro);
        make.top.equalTo(_remark.mas_bottom).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-50*pro)/4, (SCREENWIDTH-50*pro)/4));
    }];
    
    [_thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_secondImage.mas_right).with.offset(10*pro);
        make.top.equalTo(_remark.mas_bottom).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-50*pro)/4, (SCREENWIDTH-50*pro)/4));
    }];
    
    [_fourImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_thirdImage.mas_right).with.offset(10*pro);
        make.top.equalTo(_remark.mas_bottom).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-50*pro)/4, (SCREENWIDTH-50*pro)/4));
    }];
    
}

- (void)praise{

    self.praiseblock();
}

- (void)setModel:(CLSHNeighborhoodMerchantRemarkListModel *)model{

    _model = model;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:nil];
    self.userName.text = model.name;
    NSDate * date = [[KBDateFormatter shareInstance] dateFromTimeInterval:([model.assessmentTime doubleValue]/1000.0)];
    NSString * timeStr = [[KBDateFormatter shareInstance] stringFromDate:date];
    self.remarkTime.text = timeStr;
    
    starRate=[[CLGSStarRate alloc]initWithFrame:CGRectMake(0, 0, 60, 20) numberOfStars:5];
    starRate.scorePercent=(CGFloat)model.score/5;
    [_starRateView addSubview:starRate];
    NSString *praiseString = [NSString stringWithFormat:@"(%.f)", model.supportCount];
    [self.praiseButton setTitle:praiseString forState:(UIControlStateNormal)];
    if (model.supportCount == 1) {
        [_praiseButton setImage:[UIImage imageNamed:@"Praise_select"] forState:UIControlStateNormal];
    }else
    {
        [_praiseButton setImage:[UIImage imageNamed:@"Praise_normal"] forState:UIControlStateNormal];
    }
    self.remark.text = model.content;
    
    CGSize size = [NSString sizeWithStr:self.remark.text font:[UIFont systemFontOfSize:12*pro] width:SCREENWIDTH-20*pro];
    remarkHeight = size.height;
    
    _firstImage.image = nil;
    _secondImage.image = nil;
    _thirdImage.image = nil;
    _fourImage.image = nil;
    NSMutableArray *array = [NSMutableArray arrayWithObjects:_firstImage, _secondImage, _thirdImage, _fourImage, nil];
    for (int i = 0; i < model.image.count; i++) {
        UIImageView *arrayImage = array[i];
        [arrayImage sd_setImageWithURL:[NSURL URLWithString:model.image[i]] placeholderImage:nil];
    }
    
}

- (void)setRemarKListModel:(CLSHHomeRemarkListModel *)remarKListModel{

    _remarKListModel = remarKListModel;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:remarKListModel.avatar] placeholderImage:nil];
    self.userName.text = remarKListModel.name;
    NSDate * timeIntervalData = [[KBDateFormatter shareInstance] dateFromTimeInterval:([remarKListModel.assessmentTime doubleValue]/1000.0)];
    NSString * timeStr = [[KBDateFormatter shareInstance]stringFromDate:timeIntervalData];
    self.remarkTime.text = timeStr;
    starRate=[[CLGSStarRate alloc]initWithFrame:CGRectMake(0, 0, 60, 20) numberOfStars:5];
    starRate.scorePercent=[remarKListModel.score floatValue]/5;
    [_starRateView addSubview:starRate];
    NSString *praiseString = [NSString stringWithFormat:@"(%@)", [remarKListModel.supportCount stringValue]];
    [self.praiseButton setTitle:praiseString forState:(UIControlStateNormal)];
    if ([remarKListModel.supportCount integerValue] == 1) {
        [_praiseButton setImage:[UIImage imageNamed:@"Praise_select"] forState:UIControlStateNormal];
    }else
    {
        [_praiseButton setImage:[UIImage imageNamed:@"Praise_normal"] forState:UIControlStateNormal];
    }
    self.remark.text = remarKListModel.content;
    CGSize size = [NSString sizeWithStr:self.remark.text font:[UIFont systemFontOfSize:12*pro] width:SCREENWIDTH-20*pro];
    remarkHeight = size.height;
    
    _firstImage.image = nil;
    _secondImage.image = nil;
    _thirdImage.image = nil;
    _fourImage.image = nil;
    NSMutableArray *array = [NSMutableArray arrayWithObjects:_firstImage, _secondImage, _thirdImage, _fourImage, nil];
    for (int i = 0; i < remarKListModel.image.count; i++) {
        UIImageView *arrayImage = array[i];
        [arrayImage sd_setImageWithURL:[NSURL URLWithString:remarKListModel.image[i]] placeholderImage:nil];
    }
}


@end
