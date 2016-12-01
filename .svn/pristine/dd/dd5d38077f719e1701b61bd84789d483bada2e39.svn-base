//
//  CLSHCitySubdivisionController.m
//  ClshUser
//
//  Created by wutaobo on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHCitySubdivisionController.h"
#import "CLSHCitySubDivitionCell.h"
#import "CLSHCitySearchController.h"

@interface CLSHCitySubdivisionController ()
{
    //城市细分
    CLSHHomeSearchCityModel *cityModel;
     NSMutableDictionary *params;
}

@end

@implementation CLSHCitySubdivisionController

static NSString * const ID = @"CLSHCitySubDivitionCell";
static NSString * const reuseIdentifier = @"UICollectionReusableView";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[CLSHCitySubDivitionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class]forSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:reuseIdentifier];
    [self loadData];
}

//加载数据
- (void)loadData
{
    params = [NSMutableDictionary dictionary];
    cityModel = [[CLSHHomeSearchCityModel alloc] init];
    params[@"areaId"]=self.cityListModel.itemID;
    [cityModel fetchHomeSearchCityData:params callBack:^(BOOL isSuccess, id  _Nonnull city) {
        if (isSuccess) {
            cityModel = city;
            [self.collectionView reloadData];
        }else
        {
            [MBProgressHUD showError:city];
        }
    }];
}

//重写初始化方法，使用流水布局
-(instancetype)init{
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc]init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    return [self initWithCollectionViewLayout:flowlayout];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return cityModel.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CLSHCitySubDivitionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.cityListModel = cityModel.items[indexPath.item];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREENWIDTH-20-20-30)/4, 30*pro);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 20, 10, 20);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *titleView;
    
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        titleView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    }
    titleView.backgroundColor = backGroundColor;
    return titleView;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREENWIDTH, 10*pro);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHCitySearchController *searchVC = [[CLSHCitySearchController alloc] init];
    _cityListModel = cityModel.items[indexPath.item];
    searchVC.locationStr = _cityListModel.name;
    [self.navigationController pushViewController:searchVC animated:YES];
}

//setter getter
-(void)setCityListModel:(CLSHHomeCityListModel *)cityListModel
{
    _cityListModel = cityListModel;
    [self.navigationItem setTitle:cityListModel.name];
    
}

@end
