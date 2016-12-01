//
//  KBCircleBackTopView.m
//  粗粮
//
//  Created by kobe on 16/5/19.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "KBCircleBackTopView.h"
#import "Masonry.h"


@interface KBCircleBackTopView()

@property(nonatomic,strong)UIButton *topButton;

@end

@implementation KBCircleBackTopView

#pragma mark <lazyLoad>
-(UIButton *)topButton{
    if (!_topButton) {
        _topButton=[[UIButton alloc]init];
        [_topButton setImage:[UIImage imageNamed:@"backTop"] forState:UIControlStateNormal];
        [_topButton addTarget:self action:@selector(backTopResponse:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topButton;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.layer.cornerRadius=frame.size.height/2;
        self.layer.masksToBounds=YES;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    [self addSubview:self.topButton];
    [self updateConstraints];
}


#pragma mark <otherResponse>
-(void)backTopResponse:(UIButton *)button{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(backTop:)]) {
        
        [self.delegate backTop:self];
        
    }
}


-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_topButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}

@end
