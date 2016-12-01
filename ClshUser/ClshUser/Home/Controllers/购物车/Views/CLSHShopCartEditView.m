//
//  CLSHShopCartEditView.m
//  ClshUser
//
//  Created by wutaobo on 16/6/20.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHShopCartEditView.h"
#import "Masonry.h"

@interface CLSHShopCartEditView()
{
    BOOL isSelectAll;
}
@property(nonatomic,strong)UIButton *selectButton;
@property(nonatomic,strong)UIButton *deleteButton;
@end

@implementation CLSHShopCartEditView

-(UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton=[[UIButton alloc]init];
        _selectButton.tag=1;
        _selectButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10*pro, 0, 0);
        [_selectButton setTitle:@"全选" forState:UIControlStateNormal];
        _selectButton.titleLabel.font = [UIFont systemFontOfSize:14*pro];
        [_selectButton setImage:[UIImage imageNamed:@"Order_normal"] forState:UIControlStateNormal];
        [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(selectCartGoodsButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

-(UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton=[[UIButton alloc]init];
        _deleteButton.layer.cornerRadius = 2.0;
        _deleteButton.layer.masksToBounds = YES;
        _deleteButton.layer.borderWidth = 1.0;
        _deleteButton.layer.borderColor = systemColor.CGColor;
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleteButton.backgroundColor=systemColor;
        _deleteButton.tag=2;
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:14*pro];
        [_deleteButton addTarget:self action:@selector(delectGoodsButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.selectButton];
    [self addSubview:self.deleteButton];
    [self updateConstraints];
}

-(void)updateConstraints{
    
    [super updateConstraints];
    WS(weakSelf);
    
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.mas_equalTo(@(weakSelf.width/5));
    }];
    
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20*pro);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
}


-(void)selectCartGoodsButton:(UIButton *)btn{
    
    if ([btn.imageView.image isEqual:[UIImage imageNamed:@"Order_normal"]]) {
        [btn setImage:[UIImage imageNamed:@"Order_select"] forState:UIControlStateNormal];
        isSelectAll = YES;
    }else
    {
        [btn setImage:[UIImage imageNamed:@"Order_normal"] forState:UIControlStateNormal];
        isSelectAll = NO;
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCartAllGoods:)]) {
        [self.delegate selectCartAllGoods:isSelectAll];
    }
}


-(void)delectGoodsButton:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(delectCartGoods)]) {
        [self.delegate delectCartGoods];
    }
}

-(void)setIsShowSelectAll:(BOOL)isShowSelectAll{
    _isShowSelectAll=isShowSelectAll;
    
    if (isShowSelectAll)
    {
        [self.selectButton setImage:[UIImage imageNamed:@"Order_select"] forState:UIControlStateNormal];
    }else{
         [self.selectButton setImage:[UIImage imageNamed:@"Order_normal"] forState:UIControlStateNormal];
    }
}
@end
