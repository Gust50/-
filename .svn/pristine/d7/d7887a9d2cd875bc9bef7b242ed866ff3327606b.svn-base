//
//  CLSHHomeShoppingDetailScrollView.m
//  ClshUser
//
//  Created by kobe on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHomeShoppingDetailScrollView.h"
#import "KBJqueryScrollView.h"
#import "KBSegmentView.h"
#import "CLSHHomeShoppingDetailDescribeView.h"
#import "CLSHHomeShoppingDetailSizeView.h"
#import "CLSHHomeShoppingDetailCommentView.h"
#import "CLSHHomeShoppingDetailShopView.h"
//底部
#import "CLSHHomeShopDetailCollectionView.h"
#import "CLSHHomeShopParametersTableView.h"
#import "CLSHHomeShopRemarkTableView.h"

#import "MJRefresh.h"

#define kOriginalImageHeight       230
#define KdescribeSectionHeight     120
#define kshopSizeSectionHeight     40
#define kcommentSectionHeight      150
#define kshopSectionHeight         80
#define kMargin                    10

@interface CLSHHomeShoppingDetailScrollView ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,KBSegmentViewDelegate,CLSHHomeShopDetailCollectionViewDelegate,CLSHHomeShopParametersTableViewDelegate,CLSHHomeShopRemarkTableViewDelegate>

@property(nonatomic,strong)KBJqueryScrollView *topView;
@property(nonatomic,strong)CLSHHomeShoppingDetailDescribeView *describeSection;
@property(nonatomic,strong)CLSHHomeShoppingDetailSizeView *shopSizeSection;
@property(nonatomic,strong)CLSHHomeShoppingDetailCommentView *commentSection;
@property(nonatomic,strong)CLSHHomeShoppingDetailShopView *shopSection;
@property(nonatomic,strong)KBSegmentView *kBSegmentView;

@property(nonatomic,strong)UITableView *describeShoptableView;
@property(nonatomic,strong)CLSHHomeShopDetailCollectionView *cLSHHomeShopDetailCollectionView;
@property(nonatomic,strong)CLSHHomeShopParametersTableView *cLSHHomeShopParametersTableView;
@property(nonatomic,strong)CLSHHomeShopRemarkTableView *cLSHHomeShopRemarkTableView;


@end


@implementation CLSHHomeShoppingDetailScrollView

-(KBJqueryScrollView *)topView{
    if (!_topView) {
        _topView=[[KBJqueryScrollView alloc]init];
        _topView.imageArr=@[@"LayersPicture",@"LayersPicture",@"LayersPicture"];
        
    }
    return _topView;
}

-(CLSHHomeShoppingDetailDescribeView *)describeSection{
    if (!_describeSection) {
        _describeSection=[[CLSHHomeShoppingDetailDescribeView alloc]init];
    }
    return _describeSection;
}

-(CLSHHomeShoppingDetailSizeView *)shopSizeSection{
    if (!_shopSizeSection) {
        _shopSizeSection=[[CLSHHomeShoppingDetailSizeView alloc]init];
    }
    return _shopSizeSection;
}

-(CLSHHomeShoppingDetailCommentView *)commentSection{
    if (!_commentSection) {
        _commentSection=[[CLSHHomeShoppingDetailCommentView alloc]init];
    }
    return _commentSection;
}

-(CLSHHomeShoppingDetailShopView *)shopSection{
    if (!_shopSection) {
        _shopSection=[[CLSHHomeShoppingDetailShopView alloc]init];
    }
    return _shopSection;
}

-(KBSegmentView *)kBSegmentView{
    if (!_kBSegmentView) {
        _kBSegmentView=[KBSegmentView createSegmentFrame:CGRectMake(0, 0, SCREENWIDTH, 40*pro)
                                         segmentTitleArr:@[@"商品详情", @"商品参数", @"我的评价"]
                                         backgroundColor:[UIColor whiteColor]
                                              titleColor:[UIColor blackColor]
                                        selectTitleColor:systemColor
                                               titleFont:[UIFont systemFontOfSize:15]
                                         bottomLineColor:systemColor
                                           isVerticleBar:NO
                                                delegate:self];
    }
    return _kBSegmentView;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView=[[UIView alloc]init];
        //        _bottomScrollView.delegate=self;
    }
    return _bottomView;
}

-(UITableView *)describeShoptableView{
    if (!_describeShoptableView) {
        _describeShoptableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40*pro, SCREENWIDTH, SCREENHEIGHT-64-40*pro-49) style:UITableViewStylePlain];
        _describeShoptableView.delegate=self;
        _describeShoptableView.dataSource=self;
    }
    return _describeShoptableView;
}

-(CLSHHomeShopDetailCollectionView *)cLSHHomeShopDetailCollectionView{
    if (!_cLSHHomeShopDetailCollectionView) {
        _cLSHHomeShopDetailCollectionView=[[CLSHHomeShopDetailCollectionView alloc]initWithFrame:CGRectMake(0, 40*pro, SCREENWIDTH, SCREENHEIGHT-40*pro-64-50)];
        _cLSHHomeShopDetailCollectionView.delegate=self;
        
        
    }
    return _cLSHHomeShopDetailCollectionView;
}

-(CLSHHomeShopParametersTableView *)cLSHHomeShopParametersTableView{
    if (!_cLSHHomeShopParametersTableView) {
        _cLSHHomeShopParametersTableView=[[CLSHHomeShopParametersTableView alloc]initWithFrame:CGRectMake(0, 40*pro, SCREENWIDTH, SCREENHEIGHT-40*pro-64-50)];
        _cLSHHomeShopParametersTableView.delegate=self;
    }
    return _cLSHHomeShopParametersTableView;
}

-(CLSHHomeShopRemarkTableView *)cLSHHomeShopRemarkTableView{
    if (!_cLSHHomeShopRemarkTableView) {
        _cLSHHomeShopRemarkTableView=[[CLSHHomeShopRemarkTableView alloc]initWithFrame:CGRectMake(0, 40*pro, SCREENWIDTH, SCREENHEIGHT-40*pro-64-50-49)];
        _cLSHHomeShopRemarkTableView.delegate=self;
    }
    return _cLSHHomeShopRemarkTableView;
}



-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=backGroundColor;
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.topView];
    [self addSubview:self.describeSection];
    [self addSubview:self.shopSizeSection];
    [self addSubview:self.commentSection];
    [self addSubview:self.shopSection];
    
    [self addSubview:self.bottomView];
    [_bottomView addSubview:self.kBSegmentView];
    [_bottomView addSubview:self.describeShoptableView];
    
    //添加商品详情
    [_bottomView addSubview:self.cLSHHomeShopDetailCollectionView];
    //添加商品参数
    [_bottomView addSubview:self.cLSHHomeShopParametersTableView];
    //添加商品评论
    [_bottomView addSubview:self.cLSHHomeShopRemarkTableView];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //页面一
    _topView.frame=CGRectMake(0, 0, SCREENWIDTH, kOriginalImageHeight);
    _describeSection.frame=CGRectMake(0, CGRectGetMaxY(_topView.frame), SCREENWIDTH, KdescribeSectionHeight*pro);
    _shopSizeSection.frame=CGRectMake(0, kMargin+CGRectGetMaxY(_describeSection.frame), SCREENWIDTH, kshopSizeSectionHeight*pro);
    _commentSection.frame=CGRectMake(0, kMargin+CGRectGetMaxY(_shopSizeSection.frame), SCREENWIDTH, kcommentSectionHeight*pro);
    _shopSection.frame=CGRectMake(0, kMargin+CGRectGetMaxY(_commentSection.frame), SCREENWIDTH, kshopSectionHeight*pro);
    
    //页面二
    _bottomView.frame=CGRectMake(0,kMargin+CGRectGetMaxY(_shopSection.frame), SCREENWIDTH, SCREENHEIGHT-64);
    _bottomView.backgroundColor = backGroundColor;
    _cLSHHomeShopDetailCollectionView.hidden=NO;
    
    _cLSHHomeShopParametersTableView.hidden=YES;
    _cLSHHomeShopRemarkTableView.hidden=YES;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const ID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.detailTextLabel.text=@"黑妹牙膏";
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //    self.contentSize=CGSizeMake(SCREENWIDTH,_shopSection.frame.origin.y+kshopSectionHeight+100);
    //    self.contentOffset=CGPointMake(0, scrollView.contentOffset.y-_bottomScrollView.frame.size.height);
    //    if (scrollView==_cLSHHomeShopDetailCollectionView && scrollView==_cLSHHomeShopParametersTableView && scrollView==_cLSHHomeShopRemarkTableView) {
    
    //        if (_cLSHHomeShopDetailCollectionView.collectionView.contentOffset.y<-90) {
    //            self.scrollEnabled=YES;
    ////            self.contentSize=CGSizeMake(SCREENWIDTH,2000);
    //            self.contentOffset=CGPointMake(0, _bottomView.frame.origin.y-SCREENHEIGHT+64);
    //
    //
    //        }
    //    }
}



#pragma mark <KBSegmentViewDelegate>
-(void)selectSegment:(NSInteger)index{
    
    switch (index) {
        case 0:
            
            _cLSHHomeShopDetailCollectionView.hidden=NO;
            
            _cLSHHomeShopParametersTableView.hidden=YES;
            _cLSHHomeShopRemarkTableView.hidden=YES;
            break;
        case 1:
            _cLSHHomeShopParametersTableView.hidden=NO;
            
            _cLSHHomeShopDetailCollectionView.hidden=YES;
            _cLSHHomeShopRemarkTableView.hidden=YES;
            
            break;
        case 2:
            
            _cLSHHomeShopRemarkTableView.hidden=NO;
            _cLSHHomeShopDetailCollectionView.hidden=YES;
            _cLSHHomeShopParametersTableView.hidden=YES;
            
            break;
        default:
            break;
    }
}


-(void)changeOffsetY:(CGFloat)offsetY{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.scrollEnabled=YES;
        self.contentOffset=CGPointMake(0, _bottomView.frame.origin.y-SCREENHEIGHT+64);
    }];
}


-(void)changeParametersTableViewOffsetY:(CGFloat)offsetY{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.scrollEnabled=YES;
        self.contentOffset=CGPointMake(0, _bottomView.frame.origin.y-SCREENHEIGHT+64);
    }];
}

-(void)changeRemarkTableViewOffsetY:(CGFloat)offsetY{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.scrollEnabled=YES;
        self.contentOffset=CGPointMake(0, _bottomView.frame.origin.y-SCREENHEIGHT+64);
        
    }];
}
@end
