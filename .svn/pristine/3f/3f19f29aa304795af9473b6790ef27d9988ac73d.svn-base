//
//  CLGSNeighborhoodHeadReusableView.m
//  粗粮
//
//  Created by wutaobo on 16/5/20.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSNeighborhoodHeadReusableView.h"
#import "Masonry.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface CLGSNeighborhoodHeadReusableView ()
@property (nonatomic, strong) UIButton *locationButton;
@property (nonatomic, strong) UILabel *bottomLabel;
@end

@implementation CLGSNeighborhoodHeadReusableView

#pragma mark-getter setter
-(UIButton *)locationButton{
    if (!_locationButton) {
        _locationButton=[[UIButton alloc]init];
        [_locationButton setImage:[UIImage imageNamed:@"NearbyLocation"] forState:UIControlStateNormal];
        [_locationButton setTitle:@"离我最近" forState:UIControlStateNormal];
        [_locationButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _locationButton.titleLabel.font = [UIFont systemFontOfSize:14*pro];
    }
    return _locationButton;
}

-(UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel=[[UILabel alloc]init];
        _bottomLabel.backgroundColor = RGBColor(221, 222, 223);
    }
    return _bottomLabel;
}

#pragma mark-init UI
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.locationButton];
    [self addSubview:self.bottomLabel];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-2*pro);
        make.width.mas_equalTo(@(90*pro));
    }];
    
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH, 1));
    }];
}


@end
