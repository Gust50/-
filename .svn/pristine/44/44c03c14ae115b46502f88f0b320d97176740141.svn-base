//
//  CLSCurrentLocationCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSCurrentLocationCell.h"
#import "Masonry.h"

@interface CLSCurrentLocationCell()



@end

@implementation CLSCurrentLocationCell

#pragma mark-getter setter
-(UILabel *)currentLocation{
    if (!_currentLocation) {
        _currentLocation=[[UILabel alloc]init];
        _currentLocation.textColor = RGBColor(51, 51, 51);
        _currentLocation.font = [UIFont systemFontOfSize:14*pro];
//        _currentLocation.text = @"龙岗区天安数码城内";
    }
    return _currentLocation;
}

-(UIButton *)relocation{
    if (!_relocation) {
        _relocation=[[UIButton alloc]init];
        [_relocation setTitle:@"重新定位" forState:UIControlStateNormal];
        [_relocation setTitleColor:systemColor forState:UIControlStateNormal];
        [_relocation setImage:[UIImage imageNamed:@"RelocationIcon"] forState:UIControlStateNormal];
        _relocation.titleLabel.font = [UIFont systemFontOfSize:14*pro];
        [_relocation addTarget:self action:@selector(clicked) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _relocation;
}

#pragma mark-init UI
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.currentLocation];
    [self addSubview:self.relocation];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_relocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 30*pro));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    [_currentLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(30*pro));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
}

- (void)clicked{

//    if (self.delegate && [self.delegate performSelector:@selector(getCurrentLocation)]) {
//        [self.delegate getCurrentLocation];
//    }
    
    if (self.getCurrentLocationblock) {
        self.getCurrentLocationblock();
    }
}

@end
