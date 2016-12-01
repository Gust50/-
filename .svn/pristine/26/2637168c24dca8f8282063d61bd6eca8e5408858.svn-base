//
//  CLGSHomeRecommandCell.m
//  粗粮
//
//  Created by kobe on 16/5/16.
//  Copyright © 2016年 胡天虎. All rights reserved.
//  商家推荐

#import "CLGSHomeRecommandCell.h"
#import "CLGSStarRate.h"
#import "Masonry.h"
#import "CLSHNeighborhoodModel.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface CLGSHomeRecommandCell()
{
    CLGSStarRate *cLGSStarRate;
}

@property(nonatomic,strong)UIImageView *businessIcon;
@property(nonatomic,strong)UILabel  *businessName;
@property(nonatomic,strong)UIButton *businessDistance;
@property(nonatomic,strong)UILabel  *businessDescribe;
/** 商家信誉度 */
@property(nonatomic,strong)UIView  *businessRate;
@property(nonatomic,strong)UILabel *businessCommands;
@property(nonatomic,strong)UILabel *businessCounts;
@property(nonatomic,strong)UILabel *businessAddress;
@property(nonatomic,strong)UILabel *businessTopLine;
@property(nonatomic,strong)UILabel *businessBottomLine;
/** 动态创建配送按钮方式 */
@property(nonatomic,strong)UIView *businessDelivery;
@property (nonatomic, strong) UIView *bottomLine;     ///<下划线

@end

@implementation CLGSHomeRecommandCell

#pragma mark <lazyLoad>
-(UIImageView *)businessIcon{
    if (!_businessIcon) {
        _businessIcon=[[UIImageView alloc]init];
        _businessIcon.image = [UIImage imageNamed:@"ShopPicture"];
        _businessIcon.layer.masksToBounds=YES;
        _businessIcon.layer.cornerRadius=3.0;
//        _businessIcon.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _businessIcon;
}

-(UILabel *)businessName{
    if (!_businessName) {
        _businessName=[[UILabel alloc]init];
        _businessName.font = [UIFont systemFontOfSize:13*pro];
        _businessName.textColor = RGBColor(51, 51, 51);
        _businessName.text = @"粗粮生活自营店";
    }
    return _businessName;
}

-(UIButton *)businessDistance{
    if (!_businessDistance) {
        _businessDistance=[[UIButton alloc]init];
        [_businessDistance setImage:[UIImage imageNamed:@"LocationMerchant"] forState:UIControlStateNormal];
        [_businessDistance setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _businessDistance.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        _businessDistance.titleLabel.textColor = RGBColor(153, 153, 153);
        [_businessDistance setTitle:@"660m" forState:UIControlStateNormal];
    }
    return _businessDistance;
}

-(UILabel *)businessTopLine{
    if (!_businessTopLine) {
        _businessTopLine=[[UILabel alloc]init];
        _businessTopLine.backgroundColor =backGroundColor;
    }
    return _businessTopLine;
}

-(UILabel *)businessDescribe{
    if (!_businessDescribe) {
        _businessDescribe=[[UILabel alloc]init];
        _businessDescribe.font = [UIFont systemFontOfSize:10*pro];
        _businessDescribe.textColor = RGBColor(102, 102, 102);
        _businessDescribe.text = @"四川卤味特色小吃，服务到家";
    }
    return _businessDescribe;
}

-(UIView *)businessRate{
    if (!_businessRate) {
        _businessRate=[[UIView alloc]init];
    }
    return _businessRate;
}

-(UILabel *)businessCommands{
    if (!_businessCommands) {
        _businessCommands=[[UILabel alloc]init];
        _businessCommands.font = [UIFont systemFontOfSize:10*pro];
        _businessCommands.textColor = RGBColor(255, 96, 0);
        _businessCommands.text = @"1688条评论";
        
        NSMutableAttributedString *businessCommandsStr = [[NSMutableAttributedString alloc] initWithString:_businessCommands.text];
        [businessCommandsStr addAttribute:NSForegroundColorAttributeName value:RGBColor(102, 102, 102) range:NSMakeRange(_businessCommands.text.length-3, 3)];
        _businessCommands.attributedText = businessCommandsStr;
        
    }
    return _businessCommands;
}

-(UILabel *)businessCounts{
    if (!_businessCounts) {
        _businessCounts=[[UILabel alloc]init];
        _businessCounts.font = [UIFont systemFontOfSize:10*pro];
        _businessCounts.textColor = RGBColor(102, 102, 102);
        _businessCounts.text = @"月销1688单";
        //截取数字
        NSScanner *scanner = [NSScanner scannerWithString:_businessCounts.text];
        [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
        int number;
        [scanner scanInt:&number];
        NSString *str = [NSString stringWithFormat:@"%d", number];
        NSMutableAttributedString *businessCountsStr = [[NSMutableAttributedString alloc] initWithString:_businessCounts.text];
        [businessCountsStr addAttribute:NSForegroundColorAttributeName value:RGBColor(255, 96, 0) range:NSMakeRange(2, str.length)];
        _businessCounts.attributedText = businessCountsStr;
    }
    return _businessCounts;
}

-(UILabel *)businessAddress{
    if (!_businessAddress) {
        _businessAddress=[[UILabel alloc]init];
        _businessAddress.font = [UIFont systemFontOfSize:10*pro];
        _businessAddress.textColor = RGBColor(102, 102, 102);
        _businessAddress.text = @"地址：深圳市龙岗区中心城天安数码城3栋b座1406室";
    }
    return _businessAddress;
}

-(UILabel *)businessBottomLine{
    if (!_businessBottomLine) {
        _businessBottomLine=[[UILabel alloc]init];
        _businessBottomLine.backgroundColor =backGroundColor;
    }
    return _businessBottomLine;
}
-(UIView *)businessDelivery{
    if (!_businessDelivery) {
        _businessDelivery=[[UIView alloc]init];
        _businessDelivery.userInteractionEnabled = NO;
        
    }
    return _businessDelivery;
}


-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine=[[UIView alloc]init];
        _bottomLine.backgroundColor=backGroundColor;
    }
    return _bottomLine;
}

#pragma mark <init>
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark <add UI>
-(void)initUI{
    [self addSubview:self.businessIcon];
    [self addSubview:self.businessName];
    [self addSubview:self.businessDistance];
    [self addSubview:self.businessTopLine];
    [self addSubview:self.businessDescribe];
    [self addSubview:self.businessRate];
    [self addSubview:self.businessCommands];
    [self addSubview:self.businessCounts];
    [self addSubview:self.businessAddress];
    [self addSubview:self.businessBottomLine];
    [self addSubview:self.businessDelivery];
    [self addSubview:self.bottomLine];
    
    //添加评星
    cLGSStarRate=[[CLGSStarRate alloc]initWithFrame:CGRectMake(0, 0, 60*pro, 15*pro) numberOfStars:5];
    cLGSStarRate.userInteractionEnabled=NO;
    [_businessRate addSubview:cLGSStarRate];
    

    [self updateConstraints];
}


-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_businessIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*pro, 100*pro));
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
    }];
    
    [_businessName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(20*pro);
        make.left.equalTo(_businessIcon.mas_right).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(120*pro, 16*pro));
    }];
    
    [_businessDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(23*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 16*pro));
    }];
    
    [_businessTopLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_businessIcon.mas_right).with.offset(10*pro);
        make.top.equalTo(_businessName.mas_bottom).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(1*pro));
    }];
    
    [_businessDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_businessTopLine.mas_bottom).with.offset(10*pro);
        make.left.equalTo(_businessIcon.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(12*pro);
    }];
    
    [_businessRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_businessIcon.mas_right).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(70*pro, 12*pro));
        make.top.equalTo(_businessDescribe.mas_bottom).with.offset(0);
    }];
    
    [_businessCommands mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_businessRate.mas_right).with.offset(10*pro);
        make.top.equalTo(_businessDescribe.mas_bottom).with.offset(5*pro);
        make.size.mas_equalTo(CGSizeMake(60*pro, 12*pro));
    }];
    
    [_businessCounts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_businessCommands.mas_right).with.offset(5*pro);
        make.top.equalTo(_businessDescribe.mas_bottom).with.offset(5*pro);
        make.size.mas_equalTo(CGSizeMake(60*pro, 12*pro));

    }];
    
    [_businessAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_businessRate.mas_bottom).with.offset(10*pro);
        make.left.equalTo(_businessIcon.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(12*pro));
    }];
    
    [_businessBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_businessAddress.mas_bottom).with.offset(10*pro);
        make.left.equalTo(_businessIcon.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(1*pro));
    }];
    
    [_businessDelivery mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_businessBottomLine.mas_bottom).with.offset(0*pro);
        make.left.equalTo(_businessIcon.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(30*pro));
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_businessDelivery.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
}

#pragma mark - setter getter
-(void)setRecommentListModel:(CLSHHomeRecommentListModel *)recommentListModel
{
    _recommentListModel = recommentListModel;
    [self.businessIcon sd_setImageWithURL:[NSURL URLWithString:recommentListModel.iamge] placeholderImage:nil];
    self.businessName.text = recommentListModel.name;
    self.businessDescribe.text = recommentListModel.subTtitle;
    
    
    //底部动态创建按钮
    if (recommentListModel.isTakeSelf && recommentListModel.isBusinessDistribution && recommentListModel.giftTitle.length!=0) {
        
        UIButton * discountBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        discountBtn.frame = CGRectMake(0, 5*pro, 50*pro, 20*pro);
        discountBtn.backgroundColor = [UIColor orangeColor];
        [discountBtn setTitle:recommentListModel.giftTitle forState:(UIControlStateNormal)];
        discountBtn.titleLabel.font = [UIFont systemFontOfSize:8*pro];
        [_businessDelivery addSubview:discountBtn];
        
        UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        businessBtn.frame = CGRectMake(55*pro, 5*pro, 60*pro, 20*pro);
        [businessBtn setBackgroundImage:[UIImage imageNamed:@"icon1"] forState:(UIControlStateNormal)];
        [_businessDelivery addSubview:businessBtn];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(120*pro, 5*pro, 60*pro, 20*pro);
        [btn setBackgroundImage:[UIImage imageNamed:@"icon"] forState:(UIControlStateNormal)];
        [_businessDelivery addSubview:btn];
        
    } else{
        
        if (recommentListModel.isTakeSelf && recommentListModel.giftTitle.length !=0) {
            
            UIButton * discountBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            discountBtn.frame = CGRectMake(0, 5*pro, 50*pro, 20*pro);
            discountBtn.backgroundColor = [UIColor orangeColor];
            [discountBtn setTitle:recommentListModel.giftTitle forState:(UIControlStateNormal)];
            discountBtn.titleLabel.font = [UIFont systemFontOfSize:8*pro];
            [_businessDelivery addSubview:discountBtn];
            
            UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            businessBtn.frame = CGRectMake(55*pro, 5*pro, 60*pro, 20*pro);
            [businessBtn setBackgroundImage:[UIImage imageNamed:@"icon1"] forState:(UIControlStateNormal)];
            [_businessDelivery addSubview:businessBtn];
        }
        
        if (recommentListModel.isBusinessDistribution && recommentListModel.giftTitle.length!=0) {
            
            UIButton * discountBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            discountBtn.frame = CGRectMake(0, 5*pro, 50*pro, 20*pro);
            discountBtn.backgroundColor = [UIColor orangeColor];
            [discountBtn setTitle:recommentListModel.giftTitle forState:(UIControlStateNormal)];
            discountBtn.titleLabel.font = [UIFont systemFontOfSize:8*pro];
            [_businessDelivery addSubview:discountBtn];
            
            UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            businessBtn.frame = CGRectMake(55*pro, 5*pro, 60*pro, 20*pro);
            [businessBtn setBackgroundImage:[UIImage imageNamed:@"icon"] forState:(UIControlStateNormal)];
            [_businessDelivery addSubview:businessBtn];
        }
        
        if (recommentListModel.isBusinessDistribution && recommentListModel.isTakeSelf && recommentListModel.giftTitle.length ==0) {
            UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            businessBtn.frame = CGRectMake(0, 5*pro, 60*pro, 20*pro);
            [businessBtn setBackgroundImage:[UIImage imageNamed:@"icon1"] forState:(UIControlStateNormal)];
            [_businessDelivery addSubview:businessBtn];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(65*pro, 5*pro, 60*pro, 20*pro);
            [btn setBackgroundImage:[UIImage imageNamed:@"icon"] forState:(UIControlStateNormal)];
            [_businessDelivery addSubview:btn];
            
        }
        
        if (recommentListModel.isTakeSelf && recommentListModel.giftTitle.length == 0 && !recommentListModel.isBusinessDistribution){
            
            UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            businessBtn.frame = CGRectMake(0, 5*pro, 60*pro, 20*pro);
            [businessBtn setBackgroundImage:[UIImage imageNamed:@"icon1"] forState:(UIControlStateNormal)];
            [_businessDelivery addSubview:businessBtn];
        }
        
        if (recommentListModel.isBusinessDistribution && recommentListModel.giftTitle.length ==0 && !recommentListModel.isTakeSelf) {
            UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            businessBtn.frame = CGRectMake(0, 5*pro, 60*pro, 20*pro);
            [businessBtn setBackgroundImage:[UIImage imageNamed:@"icon"] forState:(UIControlStateNormal)];
            [_businessDelivery addSubview:businessBtn];
        }
        
        if (recommentListModel.giftTitle.length !=0 && !recommentListModel.isTakeSelf && !recommentListModel.isBusinessDistribution) {
            UIButton * discountBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            discountBtn.frame = CGRectMake(0, 5*pro, 50*pro, 20*pro);
            discountBtn.backgroundColor = [UIColor orangeColor];
            [discountBtn setTitle:recommentListModel.giftTitle forState:(UIControlStateNormal)];
            discountBtn.titleLabel.font = [UIFont systemFontOfSize:8*pro];
            [_businessDelivery addSubview:discountBtn];
            
        }
        
    }

//    if (recommentListModel.isTakeSelf && recommentListModel.isBusinessDistribution) {
//        
//        
//        UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        businessBtn.frame = CGRectMake(0, 5, 70*pro, 20*pro);
//        businessBtn.layer.borderWidth = 0.5;
//        businessBtn.layer.borderColor = systemColor.CGColor;
//        [businessBtn setImage:[UIImage imageNamed:@"ico1"] forState:UIControlStateNormal];
//        [businessBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
//        [businessBtn setTitle:@"到店自提" forState:UIControlStateNormal];
//        [businessBtn setTitleColor:systemColor forState:UIControlStateNormal];
//        businessBtn.titleLabel.font = [UIFont systemFontOfSize:10*pro];
//        [_businessDelivery addSubview:businessBtn];
//        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(60*pro+10+10, 5, 70*pro, 20*pro);
//        btn.layer.borderWidth = 0.5;
//        btn.layer.borderColor = RGBColor(242, 51, 47).CGColor;
//        [btn setImage:[UIImage imageNamed:@"ico"] forState:UIControlStateNormal];
//        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
//        [btn setTitle:@"商家配送" forState:UIControlStateNormal];
//        [btn setTitleColor:RGBColor(242, 51, 47) forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:10*pro];
//        [_businessDelivery addSubview:btn];
//        
//    } else{
//        
////        for (UIView *view in _businessDelivery.subviews) {
////            [view removeFromSuperview];
////        }
//        if (recommentListModel.isTakeSelf) {
//            
//            
//            
//            UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            businessBtn.frame = CGRectMake(0, 5, 70*pro, 20*pro);
//            businessBtn.layer.borderWidth = 0.5;
//            businessBtn.layer.borderColor = systemColor.CGColor;
//            [businessBtn setImage:[UIImage imageNamed:@"ico1"] forState:UIControlStateNormal];
//            [businessBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
//            [businessBtn setTitle:@"到店自提" forState:UIControlStateNormal];
//            [businessBtn setTitleColor:systemColor forState:UIControlStateNormal];
//            businessBtn.titleLabel.font = [UIFont systemFontOfSize:10*pro];
//            [_businessDelivery addSubview:businessBtn];
//        }
//        if (recommentListModel.isBusinessDistribution) {
//            UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            businessBtn.frame = CGRectMake(0, 5, 70*pro, 20*pro);
//            businessBtn.layer.borderWidth = 0.5;
//            businessBtn.layer.borderColor = RGBColor(242, 51, 47).CGColor;
//            [businessBtn setImage:[UIImage imageNamed:@"ico"] forState:UIControlStateNormal];
//            [businessBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
//            [businessBtn setTitle:@"商家配送" forState:UIControlStateNormal];
//            [businessBtn setTitleColor:RGBColor(242, 51, 47) forState:UIControlStateNormal];
//            businessBtn.titleLabel.font = [UIFont systemFontOfSize:10*pro];
//            [_businessDelivery addSubview:businessBtn];
//        }
//
//    }
    
    //用户星级
    cLGSStarRate.scorePercent = (float)recommentListModel.score/5;
    self.businessAddress.text = [NSString stringWithFormat:@"地址:%@",recommentListModel.address];
    if (recommentListModel.distance  >= 1000) {
        float distance = recommentListModel.distance/1000;
        [self.businessDistance setTitle:[NSString stringWithFormat:@"%.1fkm",distance] forState:(UIControlStateNormal)];
    }else{
    
        [self.businessDistance setTitle:[NSString stringWithFormat:@"%.0fm",recommentListModel.distance ] forState:(UIControlStateNormal)];
    }
    
    self.businessCommands.text = [NSString stringWithFormat:@"%li条评论",(long)recommentListModel.reviewCount];
    self.businessCounts.text = [NSString stringWithFormat:@"月销%li单",(long)recommentListModel.monthSales ];
    
}

- (void)setServiceListModel:(CLSHNeighbourhoodServiceListModel *)serviceListModel{

    _serviceListModel = serviceListModel;
    
    [self.businessIcon sd_setImageWithURL:[NSURL URLWithString:serviceListModel.iamge] placeholderImage:nil];
    self.businessName.text = serviceListModel.name;
    self.businessDescribe.text = serviceListModel.subTitle;
    
    //底部动态创建按钮
    if (serviceListModel.isTakeSelf && serviceListModel.isBussessDistribution && serviceListModel.giftTitle.length!=0) {
        
        UIButton * discountBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        discountBtn.frame = CGRectMake(0, 5*pro, 50*pro, 20*pro);
        discountBtn.backgroundColor = [UIColor orangeColor];
        [discountBtn setTitle:serviceListModel.giftTitle forState:(UIControlStateNormal)];
        discountBtn.titleLabel.font = [UIFont systemFontOfSize:10*pro];
        [_businessDelivery addSubview:discountBtn];
        
        UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        businessBtn.frame = CGRectMake(55*pro, 5*pro, 60*pro, 20*pro);
        [businessBtn setBackgroundImage:[UIImage imageNamed:@"icon1"] forState:(UIControlStateNormal)];
        [_businessDelivery addSubview:businessBtn];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(120*pro, 5*pro, 60*pro, 20*pro);
        [btn setBackgroundImage:[UIImage imageNamed:@"icon"] forState:(UIControlStateNormal)];
        [_businessDelivery addSubview:btn];
        
    } else{
        
        if (serviceListModel.isTakeSelf && serviceListModel.giftTitle.length !=0) {
            
            UIButton * discountBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            discountBtn.frame = CGRectMake(0, 5*pro, 50*pro, 20*pro);
            discountBtn.backgroundColor = [UIColor orangeColor];
            [discountBtn setTitle:serviceListModel.giftTitle forState:(UIControlStateNormal)];
            discountBtn.titleLabel.font = [UIFont systemFontOfSize:10*pro];
            [_businessDelivery addSubview:discountBtn];
            
            UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            businessBtn.frame = CGRectMake(55*pro, 5*pro, 60*pro, 20*pro);
            [businessBtn setBackgroundImage:[UIImage imageNamed:@"icon1"] forState:(UIControlStateNormal)];
            [_businessDelivery addSubview:businessBtn];
        }
        
        if (serviceListModel.isBussessDistribution && serviceListModel.giftTitle.length!=0) {
            
            UIButton * discountBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            discountBtn.frame = CGRectMake(0, 5*pro, 50*pro, 20*pro);
            discountBtn.backgroundColor = [UIColor orangeColor];
            [discountBtn setTitle:serviceListModel.giftTitle forState:(UIControlStateNormal)];
            discountBtn.titleLabel.font = [UIFont systemFontOfSize:10*pro];
            [_businessDelivery addSubview:discountBtn];
            
            UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            businessBtn.frame = CGRectMake(55*pro, 5*pro, 60*pro, 18*pro);
            [businessBtn setBackgroundImage:[UIImage imageNamed:@"icon"] forState:(UIControlStateNormal)];
            [_businessDelivery addSubview:businessBtn];
        }
        
        if (serviceListModel.isBussessDistribution && serviceListModel.isTakeSelf && serviceListModel.giftTitle.length ==0) {
            UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            businessBtn.frame = CGRectMake(0, 5*pro, 60*pro, 15*pro);
            [businessBtn setBackgroundImage:[UIImage imageNamed:@"icon1"] forState:(UIControlStateNormal)];
            [_businessDelivery addSubview:businessBtn];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(65*pro, 5*pro, 60*pro, 20*pro);
            [btn setBackgroundImage:[UIImage imageNamed:@"icon"] forState:(UIControlStateNormal)];
            [_businessDelivery addSubview:btn];

        }
        
        if (serviceListModel.isTakeSelf && serviceListModel.giftTitle.length == 0 && !serviceListModel.isBussessDistribution){
        
            UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            businessBtn.frame = CGRectMake(0, 5*pro, 60*pro, 20*pro);
            [businessBtn setBackgroundImage:[UIImage imageNamed:@"icon1"] forState:(UIControlStateNormal)];
            [_businessDelivery addSubview:businessBtn];
        }
        
        if (serviceListModel.isBussessDistribution && serviceListModel.giftTitle.length ==0 && !serviceListModel.isTakeSelf) {
            UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            businessBtn.frame = CGRectMake(0, 5*pro, 60*pro, 20*pro);
            [businessBtn setBackgroundImage:[UIImage imageNamed:@"icon"] forState:(UIControlStateNormal)];
            [_businessDelivery addSubview:businessBtn];
        }
        
        if (serviceListModel.giftTitle.length !=0 && !serviceListModel.isTakeSelf && !serviceListModel.isBussessDistribution) {
            UIButton * discountBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            discountBtn.frame = CGRectMake(0, 5*pro, 50*pro, 20*pro);
            discountBtn.backgroundColor = [UIColor orangeColor];
            [discountBtn setTitle:serviceListModel.giftTitle forState:(UIControlStateNormal)];
            discountBtn.titleLabel.font = [UIFont systemFontOfSize:10*pro];
            [_businessDelivery addSubview:discountBtn];

        }
        
    }
    
    //用户星级
    cLGSStarRate.scorePercent = (float)serviceListModel.score/5;
    self.businessAddress.text = [NSString stringWithFormat:@"地址:%@",serviceListModel.address];
//    if ([serviceListModel.distance floatValue] >= 1000) {
//        float distance = (float)[serviceListModel.distance floatValue]/1000;
//        [self.businessDistance setTitle:[NSString stringWithFormat:@"%.1fkm",distance] forState:(UIControlStateNormal)];
//    }else{
//        
//        [self.businessDistance setTitle:[NSString stringWithFormat:@"%.0fm",[serviceListModel.distance floatValue]] forState:(UIControlStateNormal)];
//    }
    
//    self.businessCommands.text = [NSString stringWithFormat:@"%.0f条评论",[serviceListModel.reviewCount floatValue]];
//    self.businessCounts.text = [NSString stringWithFormat:@"月销%.0f单",[serviceListModel.monthSales floatValue]];
    
}

@end
