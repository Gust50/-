//
//  CLSHWalletTaskSearchCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHWalletTaskSearchCell.h"
#import "Masonry.h"

@interface CLSHWalletTaskSearchCell ()

@property (nonatomic, strong) UILabel *middleLine;  ///<分割线

//@property (nonatomic, strong) UIButton *searchTask; ///<查看任务

@end

@implementation CLSHWalletTaskSearchCell

#pragma mark-lazyLoad
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.font = [UIFont systemFontOfSize:14*pro];
        
    }
    return _title;
}

-(UILabel *)middleLine{
    if (!_middleLine) {
        _middleLine = [[UILabel alloc]init];
        _middleLine.backgroundColor = RGBColor(212, 212, 212);
        
    }
    return _middleLine;
}

-(UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc]init];
        _content.textColor = RGBColor(102, 102, 102);
        _content.font = [UIFont systemFontOfSize:12*pro];
        _content.numberOfLines = 0;
    }
    return _content;
}

-(UIButton *)searchTask
{
    if (!_searchTask) {
        _searchTask = [[UIButton alloc] init];
        _searchTask.backgroundColor = systemColor;
        [_searchTask setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _searchTask.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        _searchTask.layer.cornerRadius = 5.0;
        _searchTask.layer.masksToBounds = YES;
        [_searchTask setTitle:@"查看" forState:UIControlStateNormal];
        [_searchTask addTarget:self action:@selector(seeInvitateTask) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchTask;
}

#pragma mark-init UI
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.title];
    [self addSubview:self.searchTask];
    [self addSubview:self.middleLine];
    [self addSubview:self.content];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_searchTask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(70*pro, 25*pro));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(_searchTask.mas_left).with.offset(-10*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.height.mas_equalTo(@(25*pro));
    }];
    
    [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(1));
    }];
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleLine.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(30*pro));
    }];
}

- (void)seeInvitateTask
{
    if (self.seeInvitateTaskBlock) {
        self.seeInvitateTaskBlock();
    }
}

@end
