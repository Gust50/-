//
//  CLSHHomeRecommandCell.m
//  ClshUser
//
//  Created by arom on 16/11/22.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHHomeRecommandCell.h"
#import "CLGSStarRate.h"
#import "CLSHHomeModel.h"
#import "CLSHNeighborhoodModel.h"

@interface CLSHHomeRecommandCell (){

     CLGSStarRate *cLGSStarRate;
}

@property (nonatomic, strong)UIImageView *iconView;
@property (nonatomic, strong)UILabel *bussinessNameLabel;
@property (nonatomic, strong)UIButton *bussinessDistanceLabel;
@property (nonatomic, strong)UILabel *bussinessDescribeLabel;
@property (nonatomic, strong)UIView *bussinessRateView;
@property (nonatomic, strong)UILabel *bussinessCommentLabel;
@property (nonatomic, strong)UILabel *bussinessCountLabel;
@property (nonatomic, strong)UIView * lineView;
@property (nonatomic, strong)UIImageView *awardImageView;
@property (nonatomic, strong)UILabel *awardLabel;
@property (nonatomic, strong)UIImageView *deleveryImageView;
@property (nonatomic, strong)UILabel *deleveryLabel;
@property (nonatomic, strong)UIView *line1View;
@end

@implementation CLSHHomeRecommandCell
#pragma mark <lazyload>
- (UIImageView *)iconView{

    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 5*pro;
    }
    return _iconView;
}

- (UILabel *)bussinessNameLabel{

    if (!_bussinessNameLabel) {
        _bussinessNameLabel = [[UILabel alloc] init];
        _bussinessNameLabel.font = [UIFont systemFontOfSize:12*pro];
        _bussinessNameLabel.textColor = RGBColor(51, 51, 51);
        _bussinessNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _bussinessNameLabel;
}

- (UIButton *)bussinessDistanceLabel{

    if (!_bussinessDistanceLabel) {
        _bussinessDistanceLabel = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_bussinessDistanceLabel setTitleColor:RGBColor(153, 153, 153) forState:(UIControlStateNormal)];
        _bussinessDistanceLabel.titleLabel.font = [UIFont systemFontOfSize:10*pro];
        [_bussinessDistanceLabel setImage:[UIImage imageNamed:@"LocationMerchant"] forState:(UIControlStateNormal)];
    }
    return _bussinessDistanceLabel;
}

- (UILabel *)bussinessDescribeLabel{

    if (!_bussinessDescribeLabel) {
        _bussinessDescribeLabel = [[UILabel alloc] init];
        _bussinessDescribeLabel.textColor = RGBColor(153, 153, 153);
        _bussinessDescribeLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return _bussinessDescribeLabel;
}

- (UIView *)bussinessRateView{

    if (!_bussinessRateView) {
        _bussinessRateView = [[UIView alloc] init];
    }
    return _bussinessRateView;
}

- (UILabel *)bussinessCommentLabel{

    if (!_bussinessCommentLabel) {
        _bussinessCommentLabel = [[UILabel alloc] init];
        _bussinessCommentLabel.textColor = RGBColor(255, 96, 0);;
        _bussinessCommentLabel.font = [UIFont systemFontOfSize:10*pro];
        _bussinessCommentLabel.text = @"1688条评论";
        NSMutableAttributedString *businessCommandsStr = [[NSMutableAttributedString alloc] initWithString:_bussinessCommentLabel.text];
        [businessCommandsStr addAttribute:NSForegroundColorAttributeName value:RGBColor(102, 102, 102) range:NSMakeRange(_bussinessCommentLabel.text.length-3, 3)];
        _bussinessCommentLabel.attributedText = businessCommandsStr;
    }
    return _bussinessCommentLabel;
}

- (UILabel *)bussinessCountLabel{

    if (!_bussinessCountLabel) {
        _bussinessCountLabel = [[UILabel alloc] init];
        _bussinessCountLabel.textColor = RGBColor(102, 102, 102);
        _bussinessCountLabel.font = [UIFont systemFontOfSize:10*pro];
        _bussinessCountLabel.text = @"月销88单";
        NSScanner *scanner = [NSScanner scannerWithString:_bussinessCountLabel.text];
        [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
        int number;
        [scanner scanInt:&number];
        NSString *str = [NSString stringWithFormat:@"%d", number];
        NSMutableAttributedString *businessCountsStr = [[NSMutableAttributedString alloc] initWithString:_bussinessCountLabel.text];
        [businessCountsStr addAttribute:NSForegroundColorAttributeName value:RGBColor(255, 96, 0) range:NSMakeRange(2, str.length)];
        _bussinessCountLabel.attributedText = businessCountsStr;
    }
    return _bussinessCountLabel;
}

- (UIView *)lineView{

    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGBColor(153, 153, 153);
    }
    return _lineView;
}

- (UIImageView *)awardImageView{

    if (!_awardImageView) {
        _awardImageView = [[UIImageView alloc] init];
        _awardImageView.image = [UIImage imageNamed:@"awardImage"];
    }
    return _awardImageView;
}

- (UILabel *)awardLabel{

    if (!_awardLabel) {
        _awardLabel = [[UILabel alloc] init];
//        _awardLabel.textColor = RGBColor(153, 153, 153);
        _awardLabel.font = [UIFont systemFontOfSize:10*pro];
    }
    return _awardLabel;
}

- (UIImageView *)deleveryImageView{

    if (!_deleveryImageView) {
        _deleveryImageView = [[UIImageView alloc] init];
        _deleveryImageView.image = [UIImage imageNamed:@"deleveryImage"];
    }
    return _deleveryImageView;
}

- (UILabel *)deleveryLabel{

    if (!_deleveryLabel) {
        _deleveryLabel = [[UILabel alloc] init];
        _deleveryLabel.textColor = RGBColor(153, 153, 153);
        _deleveryLabel.font = [UIFont systemFontOfSize:10*pro];
    }
    return _deleveryLabel;
}

- (UIView *)line1View{

    if (!_line1View) {
        _line1View = [[UIView alloc] init];
        _line1View.backgroundColor = RGBColor(153, 153, 153);
    }
    return _line1View;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.iconView];
    
    [self addSubview:self.bussinessDistanceLabel];
    [self addSubview:self.bussinessNameLabel];
    [self addSubview:self.bussinessDescribeLabel];
    [self addSubview:self.bussinessRateView];
    [self addSubview:self.bussinessCommentLabel];
    [self addSubview:self.bussinessCountLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.awardImageView];
    [self addSubview:self.awardLabel];
    [self addSubview:self.deleveryImageView];
    [self addSubview:self.deleveryLabel];
    [self addSubview:self.line1View];
    
    //添加评星
    cLGSStarRate=[[CLGSStarRate alloc]initWithFrame:CGRectMake(0, 0, 60*pro, 15*pro) numberOfStars:5];
    cLGSStarRate.userInteractionEnabled=NO;
    [_bussinessRateView addSubview:cLGSStarRate];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80*pro, 80*pro));
        make.left.equalTo(weakSelf.mas_left).with.offset(8*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(8*pro);
    }];
    
    [_bussinessNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconView.mas_top);
        make.left.equalTo(_iconView.mas_right).with.offset(8*pro);
        make.width.equalTo(@(150*pro));
        make.height.equalTo(@(20*pro));
    }];
    
    [_bussinessDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-8*pro);
        make.height.equalTo(@(20*pro));
        make.top.equalTo(_iconView.mas_top);
    }];
    
    [_bussinessDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).with.offset(8*pro);
        make.top.equalTo(_bussinessNameLabel.mas_bottom).with.offset(5*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-8*pro);
        make.height.equalTo(@(20*pro));
    }];
    
    [_bussinessRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).with.offset(8*pro);
        make.top.equalTo(_bussinessDescribeLabel.mas_bottom).with.offset(5*pro);
        make.size.mas_equalTo(CGSizeMake(70*pro, 20*pro));
    }];
    
    [_bussinessCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bussinessRateView.mas_right).with.offset(20*pro);
        make.top.equalTo(_bussinessDescribeLabel.mas_bottom).with.offset(5*pro);
        make.height.equalTo(@(20*pro));
    }];
    
    [_bussinessCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-8*pro);
        make.top.equalTo(_bussinessDescribeLabel.mas_bottom).with.offset(5*pro);
        make.height.equalTo(@(20*pro));
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bussinessRateView.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(_bussinessCountLabel.mas_bottom).with.offset(5*pro);
        make.height.equalTo(@1);
    }];
    
    [_awardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_bussinessRateView.mas_left);
        make.size.mas_equalTo(CGSizeMake(20*pro, 20*pro));
        make.top.equalTo(_lineView.mas_bottom).with.offset(5*pro);
    }];
    
    [_awardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_awardImageView.mas_right).with.offset(5*pro);
        make.centerY.equalTo(_awardImageView.mas_centerY);
        
    }];
    
    [_deleveryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_awardImageView.mas_left);
        make.size.mas_equalTo(CGSizeMake(20*pro, 20*pro));
        make.top.equalTo(_awardImageView.mas_bottom).with.offset(5*pro);
    }];
    
    [_deleveryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_deleveryImageView.mas_right).with.offset(5*pro);
        make.centerY.equalTo(_deleveryImageView.mas_centerY);
    }];
    [_line1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(_deleveryImageView.mas_bottom).with.offset(5*pro);
    }];
}

- (void)setRecommentListModel:(CLSHHomeRecommentListModel *)recommentListModel{

    _recommentListModel = recommentListModel;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:recommentListModel.iamge] placeholderImage:nil];
//    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:recommentListModel.iamge]]];
//    [_iconView performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
    _bussinessNameLabel.text = recommentListModel.name;
    _bussinessDescribeLabel.text = recommentListModel.subTtitle;
    cLGSStarRate.scorePercent = (float)recommentListModel.score/5;
    if (recommentListModel.distance  >= 1000) {
        float distance = recommentListModel.distance/1000;
        [_bussinessDistanceLabel setTitle:[NSString stringWithFormat:@"%.1fkm",distance] forState:(UIControlStateNormal)];
    }else{
        
        [_bussinessDistanceLabel setTitle:[NSString stringWithFormat:@"%.0fm",recommentListModel.distance ] forState:(UIControlStateNormal)];
    }
    
    NSString * str = [NSString stringWithFormat:@"{%li}条评论",(long)recommentListModel.reviewCount];
    _bussinessCommentLabel.attributedText = [NSString attriTipBySpecialSymbolWithTipStr:str normalColor:RGBColor(102, 102, 102) highColor:RGBColor(255, 96, 0) normalSize:10*pro highSize:10*pro];
    NSString * str1 = [NSString stringWithFormat:@"月销{%li}单",(long)recommentListModel.monthSales ];
    _bussinessCountLabel.attributedText = [NSString attriTipBySpecialSymbolWithTipStr:str1 normalColor:RGBColor(102, 102, 102) highColor:RGBColor(255, 96, 0) normalSize:10*pro highSize:10*pro];
    _awardLabel.attributedText = [NSString attriTipBySpecialSymbolWithTipStr:recommentListModel.giftTitle normalColor:RGBColor(153, 153, 153) highColor:RGBColor(255, 96, 0) normalSize:10*pro highSize:10*pro];
    if (recommentListModel.isTakeSelf && recommentListModel.isBusinessDistribution) {
        _deleveryLabel.text = [NSString stringWithFormat:@"配送方式：商家配送，到店自提"];
    }else if (recommentListModel.isBusinessDistribution && !recommentListModel.isTakeSelf){
    
        _deleveryLabel.text = [NSString stringWithFormat:@"配送方式：商家配送"];
    }else{
    
        _deleveryLabel.text = [NSString stringWithFormat:@"配送方式：到店自提"];
    }
    
}

- (void)setServiceListModel:(CLSHNeighbourhoodServiceListModel *)serviceListModel{
    
    _serviceListModel = serviceListModel;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:serviceListModel.iamge] placeholderImage:nil];
    self.bussinessNameLabel.text = serviceListModel.name;
    self.bussinessDescribeLabel.text = serviceListModel.subTitle;
    cLGSStarRate.scorePercent = (float)serviceListModel.score/5;
    if (serviceListModel.distance  >= 1000) {
        float distance = serviceListModel.distance/1000;
        [_bussinessDistanceLabel setTitle:[NSString stringWithFormat:@"%.1fkm",distance] forState:(UIControlStateNormal)];
    }else{
        
        [_bussinessDistanceLabel setTitle:[NSString stringWithFormat:@"%.0fm",serviceListModel.distance ] forState:(UIControlStateNormal)];
    }
    
    NSString * str = [NSString stringWithFormat:@"{%li}条评论",(long)serviceListModel.reviewCount];
    _bussinessCommentLabel.attributedText = [NSString attriTipBySpecialSymbolWithTipStr:str normalColor:RGBColor(102, 102, 102) highColor:RGBColor(255, 96, 0) normalSize:12*pro highSize:12*pro];
    NSString * str1 = [NSString stringWithFormat:@"月销{%li}单",(long)serviceListModel.monthSales ];
    _bussinessCountLabel.attributedText = [NSString attriTipBySpecialSymbolWithTipStr:str1 normalColor:RGBColor(102, 102, 102) highColor:RGBColor(255, 96, 0) normalSize:12*pro highSize:12*pro];
    _awardLabel.attributedText = [NSString attriTipBySpecialSymbolWithTipStr:serviceListModel.giftTitle normalColor:RGBColor(102, 102, 102) highColor:[UIColor redColor] normalSize:12*pro highSize:12*pro];
    if (serviceListModel.isTakeSelf && serviceListModel.isBussessDistribution) {
        _deleveryLabel.text = [NSString stringWithFormat:@"配送方式：商家配送，到店自提"];
    }else if (serviceListModel.isBussessDistribution && !serviceListModel.isTakeSelf){
        
        _deleveryLabel.text = [NSString stringWithFormat:@"配送方式：商家配送"];
    }else{
        
        _deleveryLabel.text = [NSString stringWithFormat:@"配送方式：到店自提"];
    }
}
@end
