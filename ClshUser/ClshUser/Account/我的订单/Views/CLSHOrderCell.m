//
//  CLSHOrderCell.m
//  ClshUser
//
//  Created by kobe on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHOrderCell.h"
#import "Masonry.h"
#import "CLSHAccountOrderModel.h"

@interface CLSHOrderCell ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIView *middleView;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIView *totalPriceView;

@property(nonatomic,strong)UIImageView *shopIcon;
@property(nonatomic,strong)UILabel *shopName;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)UIButton *orderState;

@property(nonatomic,strong)UIImageView *showImage;
@property(nonatomic,strong)UILabel *showDescribe;

@property(nonatomic,strong)UIImageView * image;
@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UILabel *totalPrice;
@property (nonatomic, assign) CGFloat bottomViewHeight;

//@property(nonatomic,strong)UIButton * doButton;
//@property(nonatomic,strong)UIButton * notDoButton;
@end

@implementation CLSHOrderCell

#pragma makr <lazyLoad>
-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc]init];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

-(UIView *)middleView{
    if (!_middleView) {
        _middleView=[[UIView alloc]init];
        
    }
    return _middleView;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView=[[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}


-(UIView *)totalPriceView{
    if (!_totalPriceView) {
        _totalPriceView=[[UIView alloc]init];
        _totalPriceView.backgroundColor = [UIColor whiteColor];
    }
    return _totalPriceView;
}


-(UIImageView *)shopIcon{
    if (!_shopIcon) {
        _shopIcon=[[UIImageView alloc]init];
        _shopIcon.image = [UIImage imageNamed:@"专卖店"];
    }
    return _shopIcon;
}

-(UILabel *)shopName{
    if (!_shopName) {
        _shopName=[[UILabel alloc]init];
        _shopName.text = @"天天新鲜卖点  >";
        _shopName.font = [UIFont systemFontOfSize:13*pro];
    }
    return _shopName;
}

-(UIImageView *)arrow{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
    }
    return _arrow;
}

-(UIButton *)orderState{
    if (!_orderState) {
        _orderState=[[UIButton alloc]init];
        [_orderState setTitle:@"拒付款" forState:UIControlStateNormal];
        _orderState.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        [_orderState setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    }
    return _orderState;
}

-(UILabel *)totalPrice{
    if (!_totalPrice) {
        _totalPrice=[[UILabel alloc]init];
        _totalPrice.textAlignment = NSTextAlignmentRight;
        _totalPrice.font = [UIFont systemFontOfSize:12*pro];
        _totalPrice.text = @"共1件商品 实付款：￥128";
    }
    return _totalPrice;
}

- (UIImageView *)image{

    if (!_image) {
        _image = [[UIImageView alloc] init];
    }
    return _image;
}

-(UIScrollView *)scrollView{

    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = NO;//设置分页
//        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.backgroundColor = backGroundColor;
    }
    return _scrollView;
}

- (UIImageView *)showImage{

    if (!_showImage) {
        _showImage = [[UIImageView alloc] init];
    }
    return _showImage;
}

- (UILabel *)showDescribe{

    if (!_showDescribe) {
        _showDescribe = [[UILabel alloc] init];
        _showDescribe.textColor = RGBColor(100, 100, 100);
        _showDescribe.font = [UIFont systemFontOfSize:12*pro];
        _showDescribe.numberOfLines = 0;
    }
    return _showDescribe;
}

//- (UIButton *)doButton{
//
//    if (!_doButton) {
//        _doButton = [[UIButton alloc] init];
//        _doButton.layer.borderColor = ([UIColor redColor]).CGColor;
//        _doButton.layer.borderWidth = 1;
//        _doButton.layer.masksToBounds = YES;
//        _doButton.layer.cornerRadius = 5;
//        _doButton.titleLabel.font = [UIFont systemFontOfSize:11*pro];
//        [_doButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
//        [_doButton addTarget:self action:@selector(doButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
//    }
//    return _doButton;
//}
//
//- (UIButton *)notDoButton{
//
//    if (!_notDoButton) {
//        _notDoButton = [[UIButton alloc] init];
//        _notDoButton.layer.borderColor = RGBColor(153,153,153).CGColor;
//        _notDoButton.layer.borderWidth = 1;
//        _notDoButton.layer.masksToBounds = YES;
//        _notDoButton.layer.cornerRadius = 5;
//        _notDoButton.titleLabel.font = [UIFont systemFontOfSize:11*pro];
//        [_notDoButton setTitleColor:RGBColor(153,153,153) forState:(UIControlStateNormal)];
//        [_notDoButton addTarget:self action:@selector(notDoButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
//    }
//    return _notDoButton;
//}


- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.headerView];
    [_headerView addSubview:self.shopIcon];
    [_headerView addSubview:self.shopName];
    [_headerView addSubview:self.orderState];
    
    [self addSubview:self.middleView];
    
//    [self addSubview:self.bottomView];
    
    [self addSubview:self.totalPriceView];
    [self.totalPriceView addSubview:self.totalPrice];
    
//    self.bottomViewHeight=40;
    [self updateConstraints];
}


-(void)updateConstraints{
    [super updateConstraints];
     WS(weakSelf);
    
    //header
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(40*pro));
    }];
    
    [_shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_headerView.mas_left).with.offset(10*pro);
        make.centerY.equalTo(_headerView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20*pro, 20*pro));
    }];
    
    [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_shopIcon.mas_right).with.offset(10*pro);
        make.centerY.equalTo(_headerView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(200*pro, 20*pro));
    }];
    
    [_orderState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_headerView.mas_right).with.offset(-10*pro);
        make.centerY.equalTo(_headerView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60*pro, 20*pro));

    }];
    
    
    //middleView
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerView.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(80*pro));
    }];
    
    
    //totalPriceView
    [_totalPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleView.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(40*pro));
    }];
    
    [_totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_totalPriceView.mas_centerY);
        make.right.equalTo(_totalPriceView.mas_right).with.offset(-10*pro);
        make.left.equalTo(_totalPriceView.mas_left).with.offset(10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_totalPriceView.mas_bottom).with.offset(1);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(weakSelf.bottomViewHeight));
    }];
    
    [_bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(@(weakSelf.bottomViewHeight));
    }];
    
    [_showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleView.mas_top).with.offset(8*pro);
        make.left.equalTo(_middleView.mas_left).with.offset(8*pro);
        make.bottom.equalTo(_middleView.mas_bottom).with.offset(-8*pro);
        make.width.mas_equalTo(@(64*pro));
    }];
    [_showDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_showImage.mas_right).with.offset(8*pro);
        make.top.equalTo(_middleView.mas_top).with.offset(8*pro);
        make.right.equalTo(_middleView.mas_right).with.offset(-8*pro);
        make.bottom.equalTo(_middleView.mas_bottom).with.offset(-8*pro);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_middleView.mas_left).with.offset(8*pro);
        make.top.equalTo(_middleView.mas_top).with.offset(0);
        make.right.equalTo(_middleView.mas_right).with.offset(-8*pro);
        make.bottom.equalTo(_middleView.mas_bottom).with.offset(0);
    }];
    
//    [_doButton mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.right.equalTo(_bottomView.mas_right).with.offset(-8);
//        make.top.equalTo(_bottomView.mas_top).with.offset(5);
//        make.bottom.equalTo(_bottomView.mas_bottom).with.offset(-5);
//        make.width.equalTo(@60);
//    }];
//    [_notDoButton mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.right.equalTo(_doButton.mas_left).with.offset(-8);
//        make.top.equalTo(_bottomView.mas_top).with.offset(5);
//        make.bottom.equalTo(_bottomView.mas_bottom).with.offset(-5);
//        make.width.equalTo(@60);
//    }];
//    [_notDoButton mas_updateConstraints:^(MASConstraintMaker *make) {
//        
//    }];
    
}

#pragma mark <getter setter>

- (void)setModel:(CLSHAccountOrderListModel *)model{


//    [_doButton removeFromSuperview];
//    [_notDoButton removeFromSuperview];
    _model = model;
    self.shopName.text = [NSString stringWithFormat:@"%@ >",model.name];
    self.totalPrice.text = [NSString stringWithFormat:@"共%ld件商品 订单金额:￥%.2lf",model.orderItems.count,model.orderAmount];
    
    NSLog(@">>>>>>>>>>>>>模型状态>>>>>>>>>>%@",model.status);
    
    for (UIView *btn in _bottomView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            
            [btn removeFromSuperview];
        }
    }
    
    for ( UIView *imageView in _scrollView.subviews) {
        if ([imageView isKindOfClass:[UIImageView class]]) {
            
            [imageView removeFromSuperview];
        }
    }
    

    
    if ([model.status isEqualToString:@"pendingPayment"]) {
        [self.orderState setTitle:@"待付款" forState:(UIControlStateNormal)];
        
        }else if ([model.status isEqualToString:@"pendingReview"]){
    
        [self.orderState setTitle:@"待发货" forState:(UIControlStateNormal)];
        
    }else if ([model.status isEqualToString:@"pendingShipment"]){
        
        [self.orderState setTitle:@"待发货" forState:(UIControlStateNormal)];

    }else if ([model.status isEqualToString:@"received"]){
        
        [self.orderState setTitle:@"待评价" forState:(UIControlStateNormal)];
        
    }else if ([model.status isEqualToString:@"shipped"]){
        
        [self.orderState setTitle:@"待收货" forState:(UIControlStateNormal)];
        
    }else if ([model.status isEqualToString:@"completed"]){
        
        
    }else if ([model.status isEqualToString:@"failed"]){
        
        [self.orderState setTitle:@"已取消" forState:(UIControlStateNormal)];
        [self.orderState setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
    }else if ([model.status isEqualToString:@"canceled"]){
        
        [self.orderState setTitle:@"已取消" forState:(UIControlStateNormal)];
        [self.orderState setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
        
        
    }else if ([model.status isEqualToString:@"denied"]){
        
        [self.orderState setTitle:@"已取消" forState:(UIControlStateNormal)];

    }else if ([model.status isEqualToString:@"customerReviewed"] || [model.status isEqualToString:@"ownerReplied"]){
    
        [self.orderState setTitle:@"已完成" forState:(UIControlStateNormal)];
    }else if ([model.status isEqualToString:@"cancelReview"]){
    
        [self.orderState setTitle:@"退款中" forState:(UIControlStateNormal)];
    }

    if ([model.orderItems count]==1) {
        
        [self.middleView addSubview:self.showImage];
        [self.middleView addSubview:self.showDescribe];
        CLSHAccountOrderProductListModel * productModel = [[CLSHAccountOrderProductListModel alloc] init];
        productModel = [model.orderItems lastObject];
        [self.showImage sd_setImageWithURL:[NSURL URLWithString:productModel.image] placeholderImage:nil];
        self.showDescribe.text = productModel.goodsName;
        
    }else if ([model.orderItems count] != 1){
    
        [self.middleView addSubview:self.scrollView];
        self.scrollView.contentSize = CGSizeMake(80*model.orderItems.count, 80);
        CLSHAccountOrderProductListModel * productModel = [[CLSHAccountOrderProductListModel alloc] init];
        for (int i=0; i<[model.orderItems count]; i++) {
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(64*i+8*i, 8, 64, 64)];
            imageView.userInteractionEnabled = YES;
            productModel = model.orderItems[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:productModel.image] placeholderImage:nil];
            
            [_scrollView addSubview:imageView];
        }
        
    }
}

//- (void)doButtonClick{
//
//    if (self.doButtonblock) {
//       self.doButtonblock();
//    }
//}
//
//- (void)notDoButtonClick{
//    if (self.notDoButtonblock) {
//        self.notDoButtonblock();
//    }
//}


@end
