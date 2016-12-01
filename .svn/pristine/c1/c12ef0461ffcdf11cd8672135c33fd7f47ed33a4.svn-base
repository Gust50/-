//
//  CLSHHomeShopDetailCollectionView.m
//  ClshUser
//
//  Created by kobe on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHomeShopDetailCollectionView.h"
#import "CLSHShopDetailShopRecommendCell.h"
#import "CLSHProductHeadCollectionReusableView.h"
#import "CLSHShopDetailPictureCell.h"
#import "CLSHCartModel.h"
#import "CLGSProductDetailVC.h"
#import "CLSHDetailFooterView.h"

@interface CLSHHomeShopDetailCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    CLSHCartCommendModel *commendModel; ///<推荐商品列表
}

@property(nonatomic,strong)UICollectionView *collectionView;

@end

static NSString *const shopRecommendID = @"CLSHShopDetailShopRecommendCell";
static NSString *const headID = @"CLSHProductHeadCollectionReusableView";
static NSString *const footerID = @"CLSHDetailFooterView";
static NSString *const pictureID = @"CLSHShopDetailPictureCell";
@implementation CLSHHomeShopDetailCollectionView

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(self.frame.origin.x, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
    }
    
    return _collectionView;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = backGroundColor;
        self.collectionView.backgroundColor=backGroundColor;
        
        [self addSubview:self.collectionView];
        
         commendModel = [[CLSHCartCommendModel alloc] init];
        
        [self.collectionView registerClass:[CLSHShopDetailPictureCell class] forCellWithReuseIdentifier:pictureID];
        [self.collectionView registerClass:[CLSHShopDetailShopRecommendCell class] forCellWithReuseIdentifier:shopRecommendID];
        //head
        [self.collectionView registerClass:[CLSHProductHeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID];
        //footer
        [self.collectionView registerClass:[CLSHDetailFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTableView:) name:@"changeTableView" object:nil];
        
        KBRefreshGifHeader *header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headAction)];
        header.lastUpdatedTimeLabel.hidden=YES;
        [header setTitle:@"向下拖拽试试" forState:MJRefreshStateIdle];
        [header setTitle:@"客官别急....." forState:MJRefreshStateRefreshing];
        [header setTitle:@"向下拖拽试试" forState:MJRefreshStatePulling];
        self.collectionView.mj_header =header;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
             [self loadData];
        });
        
       
    }
    return self;
}

#pragma mark - loadData
- (void)loadData
{
    
    [commendModel fetchCartCommendData:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            commendModel = result;
//            [self.collectionView reloadData];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

-(void)headAction{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changScroll" object:nil userInfo:nil];
    _collectionView.scrollEnabled=NO;
    [self.collectionView.mj_header endRefreshing];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)changeTableView:(NSNotification *)notification{
    
    NSDictionary *dict=notification.userInfo;
    if ([dict[@"success"] boolValue]) {
         self.collectionView.scrollEnabled=YES;
    }else{
         self.collectionView.scrollEnabled=NO;
    }
   
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return commendModel.items.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CLSHShopDetailShopRecommendCell *shopRecommendCell = [collectionView dequeueReusableCellWithReuseIdentifier:shopRecommendID forIndexPath:indexPath];
    CLSHShopDetailPictureCell *shopPictureCell = [collectionView dequeueReusableCellWithReuseIdentifier:pictureID forIndexPath:indexPath];
    if (indexPath.section == 0) {
        shopPictureCell.shopIntroduce = self.shopIntroduce;
        
        return shopPictureCell;
    }else
    {
        shopRecommendCell.commendListModel = commendModel.items[indexPath.item];
        
        return shopRecommendCell;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREENWIDTH, 700*pro);
    }else
    {
        return CGSizeMake(SCREENWIDTH/2-2, 250*pro);
    }
}

//水平
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 2;
}

//垂直
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 4;
}

// collection 上下左右的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(2, 0, 2, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        CLSHCartCommendListModel *listModel = commendModel.items[indexPath.item];
        
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        info[@"goodsId"] = listModel.goodsId;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shopDetail" object:nil userInfo:info];
    }
}

//headView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        CLSHProductHeadCollectionReusableView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID forIndexPath:indexPath];
        headView.HeaderLabel.text = @"别人都在买";
        headView.backgroundColor = [UIColor whiteColor];
        return headView;
    }else if (kind == UICollectionElementKindSectionFooter)
    {
        CLSHDetailFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID forIndexPath:indexPath];
        return footerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(SCREENWIDTH, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(SCREENWIDTH, 30);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y<-90) {
        
       
    }
}

#pragma mark - setter getter
-(void)setShopIntroduce:(NSString *)shopIntroduce
{
    _shopIntroduce = shopIntroduce;
    
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

@end
