//
//  CLGSDiscoverVC.m
//  粗粮
//
//  Created by kobe on 16/5/19.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLGSDiscoverVC.h"
#import "CLGSHomeProductCell.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHHomeHeaderView.h"
#import "CLSHHomeModel.h"
#import "CLGSProductDetailVC.h"

#define kTopViewHeight 250*pro

@interface CLGSDiscoverVC ()<UICollectionViewDelegateFlowLayout, CLSHHomeHeaderViewDelegate>
{
    //model
    CLSHDiscoverRecommentModel *productModel; ///<商品列表数据模型
    //轮播model
    CLSHDiscoverJqueryModel *homeJqueryModel;
    //轮播图数组
    NSMutableArray *imageArray;
    NSMutableDictionary *params;
}


@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation CLGSDiscoverVC

static NSString * const ID = @"Cell";
static NSString * const headerID = @"headCell";

#pragma mark <lazyLoad>
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark <lazyLoad>
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    self.collectionView.frame=CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64);
    self.collectionView.backgroundColor=backGroundColor;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[CLGSHomeProductCell class] forCellWithReuseIdentifier:ID];
    [self.collectionView registerClass:[CLSHHomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    self.navigationItem.title=@"农产推荐";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = backGroundColor;
    //热销农产
    productModel = [[CLSHDiscoverRecommentModel alloc] init];
    homeJqueryModel = [[CLSHDiscoverJqueryModel alloc] init];
    
    self.collectionView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.collectionView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectionView.mj_footer.hidden=YES;
//    [self.collectionView.mj_header beginRefreshing];
     [self loadData];
  
}

//加载轮播数据
-(void)loadOtherData{
    
    //轮播
    [homeJqueryModel fetchDiscoverJqueryData:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        
        if (isSuccess) {
            homeJqueryModel = result;
//            [self.collectionView reloadData];
            
            imageArray = [NSMutableArray array];
            for (CLSHHomeJqueryListModel *model in homeJqueryModel.sliderAd) {
                [imageArray addObject:model.imgPath];
            }
            
        }else
        {
//
        }
        
    } ];
    
}


-(void)loadData{
    
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
        
        [self loadOtherData];
        
    });
    dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
        
        [self loadNewData];
        
    });
   
    dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
        
    });
    
    
}

//加载数据
-(void)loadNewData{
    self.pageNum=1;
    params=[NSMutableDictionary dictionary];
    params[@"pageNumber"]=@(_pageNum);
    params[@"pageSize"]=@(10);
    [productModel fetchDiscoverRecommentData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            productModel = result;
            [_dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:productModel.items];
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
//            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
            if (productModel.items.count<10)
            {
                self.collectionView.mj_footer.hidden=YES;
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                self.collectionView.mj_footer.hidden=NO;
                [self.collectionView.mj_footer resetNoMoreData];
            }

        }else
        {
//            [MBProgressHUD showError:result];
            [self.collectionView.mj_header endRefreshing];
        }
        
    }];
}

-(void)loadMoreData{
    if (self.pageNum < productModel.totalPages) {
        _pageNum++;
        params[@"pageNumber"]=@(_pageNum);
        [productModel fetchDiscoverRecommentData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
            if (isSuccess) {
                productModel = result;
                [_dataSource addObjectsFromArray:productModel.items];
                [self.collectionView reloadData];
//                [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
                if (productModel.items.count<10)
                {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.collectionView.mj_footer endRefreshing];
                }
            }else
            {
                [MBProgressHUD showError:result];
            }
        }];
    }else
    {
        [self.collectionView.mj_footer endRefreshing];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.collectionView.delegate=self;
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1]];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.collectionView.delegate=nil;
}


//重写初始化方法，使用流水布局
-(instancetype)init{
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc]init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    return [self initWithCollectionViewLayout:flowlayout];
}

#pragma mark <UICollectionViewDataSource>

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CLGSHomeProductCell *productCell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    productCell.discoverRecommentListModel = _dataSource[indexPath.item];
    return productCell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREENWIDTH-5)/2, 230*pro);
    
}


-(UICollectionReusableView *)
collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    CLSHHomeHeaderView *header=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
    header.delegate = self;
//    NSArray *imageArr=@[@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1464240358&di=b1d64f350e6c1bd211145e95cf6bc522&src=http://www.qugouhui.com/uploads/allimg/150317/1-15031G14155924.jpg",@"http://img1.sc115.com/uploads/sc/jpg/HD/1/834.jpg"];
   
    if (indexPath.section==0) {
        //轮播
        header.imageArray=imageArray;
        return header;
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(SCREENWIDTH, SCREENWIDTH*2.6/7.5);
    }
    return CGSizeZero;
}
// collection 水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}
// collection 垂直间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLGSProductDetailVC * productDetailVC = [[CLGSProductDetailVC alloc] init];
    CLSHDiscoverRecommentListModel *goodsListDetailModel = _dataSource[indexPath.item];
    productDetailVC.goodsID = goodsListDetailModel.goodsId;
    [self.navigationController pushViewController:productDetailVC animated:YES];

}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat offsetY = scrollView.contentOffset.y;
//    
//    if (offsetY >74) {
//        self.navigationItem.title=@"农产推荐";
//    }
//    else if (offsetY<-64) {
//        self.navigationItem.title=nil;
//    }
//    else{
//         self.navigationItem.title=nil;
//     }
//    
//    CGFloat alpha = (64+offsetY) / (200-64);
//    if (alpha >= 1) {
//        alpha = 0.99;
//    }
//    
//    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:alpha]];
//}

#pragma mark - CLSHHomeHeaderViewDelegate
-(void)clickPage:(NSInteger)index
{
    CLSHDiscoverJqueryListModel *model = homeJqueryModel.sliderAd[index];
    if ([model.urlType isEqualToString:@"goods"]) {
        if (model.urlId != nil) {
            CLGSProductDetailVC * productDetailVC = [[CLGSProductDetailVC alloc] init];
            productDetailVC.goodsID = model.urlId;
            [self.navigationController pushViewController:productDetailVC animated:YES];
        }
    }
}

@end
