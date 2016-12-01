//
//  CLSHMerchantImageCell.m
//  ClshUser
//
//  Created by wutaobo on 16/7/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHMerchantImageCell.h"
#import "Masonry.h"

@interface CLSHMerchantImageCell ()


@end

@implementation CLSHMerchantImageCell

-(UIImageView *)adImage
{
    if (!_adImage) {
        _adImage = [[UIImageView alloc] init];
        _adImage.image = [UIImage imageNamed:@"Advertising"];
    }
    return _adImage;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.adImage];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_adImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
    }];
}

@end
