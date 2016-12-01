//
//  CLGSDetailSwitchCell.m
//  粗粮
//
//  Created by kobe on 16/5/18.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSDetailSwitchCell.h"
#import "KBSegmentView.h"
//底部
#import "CLSHHomeShopDetailCollectionView.h"
#import "CLSHHomeShopParametersTableView.h"
#import "CLSHHomeShopRemarkTableView.h"

#import "CLSHHomeDetailSegmentView.h"

@interface CLGSDetailSwitchCell()<KBSegmentViewDelegate,CLSHHomeShopDetailCollectionViewDelegate,CLSHHomeShopParametersTableViewDelegate,CLSHHomeShopRemarkTableViewDelegate>

//@property (nonatomic,strong) UIScrollView *scrollView;
//@property(nonatomic,strong)CLSHHomeShopDetailCollectionView *cLSHHomeShopDetailCollectionView;
//@property(nonatomic,strong)CLSHHomeShopParametersTableView *cLSHHomeShopParametersTableView;
//@property(nonatomic,strong)CLSHHomeShopRemarkTableView *cLSHHomeShopRemarkTableView;
//
@property(nonatomic,strong)CLSHHomeDetailSegmentView *cLSHHomeDetailSegmentView;

@end
@implementation CLGSDetailSwitchCell


-(CLSHHomeDetailSegmentView *)cLSHHomeDetailSegmentView{
    if (!_cLSHHomeDetailSegmentView) {
        _cLSHHomeDetailSegmentView=[[CLSHHomeDetailSegmentView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-64-49)];
    }
    return _cLSHHomeDetailSegmentView;
}

//-(UIScrollView *)scrollView{
//    if (!_scrollView) {
//        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, SCREENWIDTH, SCREENHEIGHT-49-64-40)];
//        [_scrollView addSubview:self.cLSHHomeShopDetailCollectionView];
//        [_scrollView addSubview:self.cLSHHomeShopParametersTableView];
//        [_scrollView addSubview:self.cLSHHomeShopRemarkTableView];
//        _scrollView.pagingEnabled=YES;
//        _scrollView.contentSize=CGSizeMake(SCREENWIDTH*3, SCREENHEIGHT-49-64-40);
//    }
//    return _scrollView;
//}
//-(CLSHHomeShopDetailCollectionView *)cLSHHomeShopDetailCollectionView{
//    if (!_cLSHHomeShopDetailCollectionView) {
//        _cLSHHomeShopDetailCollectionView=[[CLSHHomeShopDetailCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-40-64-50)];
//        _cLSHHomeShopDetailCollectionView.delegate=self;
//    }
//    return _cLSHHomeShopDetailCollectionView;
//}
//
//-(CLSHHomeShopParametersTableView *)cLSHHomeShopParametersTableView{
//    if (!_cLSHHomeShopParametersTableView) {
//        _cLSHHomeShopParametersTableView=[[CLSHHomeShopParametersTableView alloc]initWithFrame:CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT-40-64-50)];
//        _cLSHHomeShopParametersTableView.delegate=self;
//    }
//    return _cLSHHomeShopParametersTableView;
//}
//
//-(CLSHHomeShopRemarkTableView *)cLSHHomeShopRemarkTableView{
//    if (!_cLSHHomeShopRemarkTableView) {
//        _cLSHHomeShopRemarkTableView=[[CLSHHomeShopRemarkTableView alloc]initWithFrame:CGRectMake(SCREENWIDTH*2, 0, SCREENWIDTH, SCREENHEIGHT-40-64-50-49)];
//        _cLSHHomeShopRemarkTableView.delegate=self;
//    }
//    return _cLSHHomeShopRemarkTableView;
//}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self createUI];
//        [self addSubview:self.scrollView];
        [self addSubview:self.cLSHHomeDetailSegmentView];
    }
    return self;
}


//-(void)createUI{
//    
//    KBSegmentView *kBSegmentView=[KBSegmentView createSegmentFrame:CGRectMake(0, 0, SCREENWIDTH, 40)
//                                                   segmentTitleArr:@[@"商品详情", @"商品参数", @"我的评价"]
//                                                   backgroundColor:[UIColor whiteColor]
//                                                        titleColor:[UIColor blackColor]
//                                                  selectTitleColor:RGBColor(0, 149, 68)
//                                                         titleFont:[UIFont systemFontOfSize:15*pro]
//                                                   bottomLineColor:RGBColor(0, 149, 68)
//                                                     isVerticleBar:NO
//                                                          delegate:self];
//    
//    [self addSubview:kBSegmentView];
//}
//
//#pragma mark <KBSegmentViewDelegate>
//-(void)selectSegment:(NSInteger)index{
//   
//    _scrollView.contentOffset=CGPointMake(index*SCREENWIDTH,0);
//}
//
#pragma mark - setter getter
-(void)setGoodsDetailModel:(CLSHHomeProductGoodsDetailModel *)GoodsDetailModel
{
    _GoodsDetailModel = GoodsDetailModel;
    _cLSHHomeDetailSegmentView.productGoodsDetailModel = GoodsDetailModel;
    
}

-(void)setGoodsId:(NSString *)goodsId{
    
    _cLSHHomeDetailSegmentView.goodId = goodsId;
    
}

@end
