//
//  CLGSSearchAreaCollectionVC.m
//  粗粮
//
//  Created by kobe on 16/5/16.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLGSSearchAreaCollectionVC.h"
#import "CLGSSearchAreaCell.h"
#import "CLGSSearchAreaReusableView.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHHomeLocalProductModel.h"

@interface CLGSSearchAreaCollectionVC ()<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>
{
    //地区查找Model
    CLSHHomeLocalProductModel *searchModel;
}

@end

@implementation CLGSSearchAreaCollectionVC

static NSString * const ID = @"Cell";
static NSString * const titleID = @"titleID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"地区查找"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //注册cell
    [self.collectionView registerClass:[CLGSSearchAreaCell class] forCellWithReuseIdentifier:ID];
    [self.collectionView registerClass:[CLGSSearchAreaReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:titleID];
    [self loadData];
}

//加载数据
- (void)loadData
{
    searchModel = [[CLSHHomeLocalProductModel alloc] init];
    [searchModel fetchHomeSearchProductData:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        NSLog(@"%@", result);
        if (isSuccess) {
            searchModel = result;
            [self.collectionView reloadData];
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:RGBColor(0, 149, 68)];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];

}
//重写初始化方法，使用流水布局
-(instancetype)init{
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc]init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    return [self initWithCollectionViewLayout:flowlayout];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CLGSSearchAreaCell *areaCell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath ];
    return areaCell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    CLGSSearchAreaReusableView *titleView;

    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        titleView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:titleID forIndexPath:indexPath];
    }
    return titleView;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREENWIDTH-20-20-15)/4, 30*pro);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 20, 10, 20);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREENWIDTH, 45*pro);
}

@end
