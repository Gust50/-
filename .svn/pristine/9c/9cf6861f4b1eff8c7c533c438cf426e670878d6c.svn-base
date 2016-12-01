//
//  CLSHHomeDetailSegmentView.m
//  ClshUser
//
//  Created by kobe on 16/6/11.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHomeDetailSegmentView.h"
#import "KBSegmentView.h"
//底部
#import "CLSHHomeShopDetailCollectionView.h"
#import "CLSHHomeShopParametersTableView.h"
#import "CLSHHomeShopRemarkTableView.h"
#import "CLSHHomeProductDetailModel.h"

@interface CLSHHomeDetailSegmentView ()<KBSegmentViewDelegate,CLSHHomeShopDetailCollectionViewDelegate,CLSHHomeShopParametersTableViewDelegate,CLSHHomeShopRemarkTableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)KBSegmentView *kBSegmentView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)CLSHHomeShopDetailCollectionView *cLSHHomeShopDetailCollectionView;
@property(nonatomic,strong)CLSHHomeShopParametersTableView *cLSHHomeShopParametersTableView;
@property(nonatomic,strong)CLSHHomeShopRemarkTableView *cLSHHomeShopRemarkTableView;

@end

@implementation CLSHHomeDetailSegmentView


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self==[super initWithFrame:frame]) {
        [self addSubview:self.kBSegmentView];
        [self addSubview:self.scrollView];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSegment:) name:@"changeTableView" object:nil];
    }
    return self;
}

-(void)changeSegment:(NSNotification *)notification{
    
    NSDictionary *info=notification.userInfo;
    if (info[@"selectSegment"]) {
       _kBSegmentView.selectNum=2;
        [UIView animateWithDuration:0.25 animations:^{
            _scrollView.contentOffset=CGPointMake(2*SCREENWIDTH,0);
        }];
    }
    
}



-(KBSegmentView *)kBSegmentView{
    if (!_kBSegmentView) {
        _kBSegmentView=[KBSegmentView createSegmentFrame:CGRectMake(0, 0, SCREENWIDTH, 40)
                                         segmentTitleArr:@[@"商品详情", @"商品参数", @"商品评价"]
                                         backgroundColor:[UIColor whiteColor]
                                              titleColor:[UIColor blackColor]
                                        selectTitleColor:RGBColor(0, 149, 68)
                                               titleFont:[UIFont systemFontOfSize:14*pro]
                                         bottomLineColor:RGBColor(0, 149, 68)
                                           isVerticleBar:NO
                                                delegate:self];
    }
    return _kBSegmentView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, SCREENWIDTH, SCREENHEIGHT-49-64-40)];
        [_scrollView addSubview:self.cLSHHomeShopDetailCollectionView];
        [_scrollView addSubview:self.cLSHHomeShopParametersTableView];
        [_scrollView addSubview:self.cLSHHomeShopRemarkTableView];
        _scrollView.pagingEnabled=YES;
        _scrollView.delegate=self;
        _scrollView.contentSize=CGSizeMake(SCREENWIDTH*3, SCREENHEIGHT-49-64-40);
    }
    return _scrollView;
}
-(CLSHHomeShopDetailCollectionView *)cLSHHomeShopDetailCollectionView{
    if (!_cLSHHomeShopDetailCollectionView) {
        _cLSHHomeShopDetailCollectionView=[[CLSHHomeShopDetailCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-40-64-50)];
        _cLSHHomeShopDetailCollectionView.delegate=self;
    }
    return _cLSHHomeShopDetailCollectionView;
}

-(CLSHHomeShopParametersTableView *)cLSHHomeShopParametersTableView{
    if (!_cLSHHomeShopParametersTableView) {
        _cLSHHomeShopParametersTableView=[[CLSHHomeShopParametersTableView alloc]initWithFrame:CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT-40-64-50)];
        _cLSHHomeShopParametersTableView.delegate=self;
    }
    return _cLSHHomeShopParametersTableView;
}

-(CLSHHomeShopRemarkTableView *)cLSHHomeShopRemarkTableView{
    if (!_cLSHHomeShopRemarkTableView) {
        _cLSHHomeShopRemarkTableView=[[CLSHHomeShopRemarkTableView alloc]initWithFrame:CGRectMake(SCREENWIDTH*2, 0, SCREENWIDTH, SCREENHEIGHT-40-64-50-49)];
        _cLSHHomeShopRemarkTableView.delegate=self;
    }
    return _cLSHHomeShopRemarkTableView;
}

#pragma mark <KBSegmentViewDelegate>
-(void)selectSegment:(NSInteger)index{
    
    [UIView animateWithDuration:0.25 animations:^{
        _scrollView.contentOffset=CGPointMake(index*SCREENWIDTH,0);
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX=scrollView.contentOffset.x;
    NSInteger page=offsetX/SCREENWIDTH;
    _kBSegmentView.selectNum=page;
}

#pragma mark - setter getter
-(void)setProductGoodsDetailModel:(CLSHHomeProductGoodsDetailModel *)productGoodsDetailModel
{
    _productGoodsDetailModel = productGoodsDetailModel;
    _cLSHHomeShopParametersTableView.productGoodsDetailModel = productGoodsDetailModel;
    _cLSHHomeShopDetailCollectionView.shopIntroduce = productGoodsDetailModel.introduction;
}

-(void)setGoodId:(NSString *)goodId{
    _goodId=goodId;
    _cLSHHomeShopRemarkTableView.goodsId=goodId;
}

@end
