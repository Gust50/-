//
//  CLGSCategoryVC.m
//  粗粮
//
//  Created by kobe on 16/5/19.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLGSCategoryVC.h"
#import "CLGSCategoryCell.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHCollectionHeaderView.h"
#import "CLSHHeaderCell.h"
#import "CLSHTableViewCell.h"
#import "CLSHGoodsListViewController.h"
#import "CLSHNeighborhoodSelectAddress.h"
#import "CLSHClassifyModel.h"
#import "KBDatabaseManagerTool.h"
#import "CLSHSearchGoodsViewController.h"

@interface CLGSCategoryVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView * _leftTableView;//左侧导航条
    UICollectionView * _rightCollectionView;//右侧商品分类
    
    int SelectRow;//选中的行
    CLSHClassifyModel *classifyModel;
//    CLSHClassifyRootModel * rootModel;
//    CLSHClassifyProductSecCategoryModel * secCategoryModel;//二级分类
//    CLSHClassifyProductSecCategoryItemModel * secCategoryItemModel;
}

@property (nonatomic,strong) NSArray *rootCategory;          ///<根分类
@property (nonatomic,strong) NSMutableArray *secondCategory;   ///<右边分类
@property (nonatomic,strong) NSArray * secondItemCategory;    ///<子类
@property (nonatomic,strong) UIImageView * headImageView;

@property (nonatomic, copy) NSString *timeStamp;   ///<时间戳
@end

@implementation CLGSCategoryVC

static NSString * const ID = @"Cell111";
static NSString * const HeaderID = @"haha";
static NSString * const topID = @"hehe";
static NSString * const leftID = @"heihei";


-(NSArray *)rootCategory{
    if (!_rootCategory) {
        _rootCategory=[NSArray array];
    }
    return _rootCategory;
}

- (NSMutableArray *)secondCategory{

    if (!_secondCategory) {
        _secondCategory = [NSMutableArray array];
    }
    return _secondCategory;
}

- (NSArray *)secondItemCategory{

    if (!_secondItemCategory) {
        _secondItemCategory = [NSArray array];
    }
    return _secondItemCategory;
}

- (UIImageView *)headImageView{

    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH*3/4-10*pro, (SCREENWIDTH*3/4-10*pro)/2)];
        
        _headImageView.image = [UIImage imageNamed:@"产品"];
        
    }
    return _headImageView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.title = @"分类";
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    classifyModel=[[CLSHClassifyModel alloc]init];
//    rootModel = [[CLSHClassifyRootModel alloc] init];
//    secCategoryModel = [[CLSHClassifyProductSecCategoryModel alloc] init];
//    secCategoryItemModel = [[CLSHClassifyProductSecCategoryItemModel alloc] init];
//    [[MBProgressHUD showMessage:@"Loading..."] hide:YES afterDelay:1];
    UIButton * searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH-60, 30)];
    [searchBtn setImage:[UIImage imageNamed:@"放大镜"] forState:(UIControlStateNormal)];
    searchBtn.backgroundColor = [UIColor whiteColor];
    [searchBtn setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
    [searchBtn setTitle:@"查找商品" forState:(UIControlStateNormal)];
    [searchBtn setImage:[UIImage imageNamed:@"放大镜"] forState:(UIControlStateHighlighted)];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    searchBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    searchBtn.layer.borderWidth = 1;
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.cornerRadius = 10;
    self.navigationItem.titleView = searchBtn;
    self.view.backgroundColor = RGBColor(236, 237, 242);
    [searchBtn addTarget:self action:@selector(TosearchVC) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //创建UI视图
    [self creatUI];
    SelectRow = 0;
    
    CLSHClassifyModel *model=[KBDatabaseManagerTool fetchClassifyModelData];
    
    if (model.timestamp.length==0) {
        self.timeStamp=@"";
        [self loadData];
        NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        
    }else{
        [self loadLocalData:model];
        self.timeStamp=model.timestamp;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [self loadData];
        });
    }
}

-(void)loadLocalData:(CLSHClassifyModel *)model
{
//    CLSHClassifyModel *model=[KBDatabaseManagerTool fetchClassifyModelData];
    //获取一级目录
    self.rootCategory=model.rootProductCategories;
    
    [_leftTableView reloadData];
    
    CLSHClassifyRootModel *rootCategory=_rootCategory[SelectRow];
    
//    NSInteger selectedIndex = 0;
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:SelectRow inSection:0];
    [_leftTableView selectRowAtIndexPath:selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    [_secondCategory removeAllObjects];
    //右边菜单的分类数组
    [self.secondCategory addObject:rootCategory.productCategory];
    [_rightCollectionView reloadData];
}

-(void)loadData{

    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"timestamp"]=self.timeStamp;
    [classifyModel fetchClassifyModel:params callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            
            CLSHClassifyModel *model=result;
            if (self.timeStamp.length==0) {
                  [KBDatabaseManagerTool saveClassifyModelData:model];
            }else{
                [KBDatabaseManagerTool updateSaveClassifyModelData:model];
            }
          
            //获取一级目录
            self.rootCategory=model.rootProductCategories;
            [_leftTableView reloadData];
            
//            NSInteger selectedIndex = 0;
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:SelectRow inSection:0];
            [_leftTableView selectRowAtIndexPath:selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            
            
            [_secondCategory removeAllObjects];
            CLSHClassifyRootModel *rootCategory=_rootCategory[SelectRow];
            //右边菜单的分类数组
//            [self.secondCategory addObjectsFromArray:rootCategory.productCategory.children];
            [self.secondCategory addObject:rootCategory.productCategory];
            
            [_rightCollectionView reloadData];
            
        }else{
        
            [MBProgressHUD showError:result];
        }
        
    }];
}

//创建UI视图
- (void)creatUI{
    
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH/4, SCREENHEIGHT-49) style:(UITableViewStylePlain)];
    _leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.showsVerticalScrollIndicator=NO;
    
    [_leftTableView registerClass:[CLSHTableViewCell class] forCellReuseIdentifier:leftID];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];

    _rightCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREENWIDTH/4+5*pro, 74, SCREENWIDTH*3/4-10*pro, SCREENHEIGHT-74-49) collectionViewLayout:layout];
    _rightCollectionView.backgroundColor = RGBColor(236, 237, 242);
    _rightCollectionView.delegate = self;
    _rightCollectionView.dataSource = self;
    _rightCollectionView.showsVerticalScrollIndicator = NO;
    
    [_rightCollectionView registerClass:[CLSHHeaderCell class] forCellWithReuseIdentifier:topID];
    [_rightCollectionView registerClass:[CLGSCategoryCell class] forCellWithReuseIdentifier:ID];
    [_rightCollectionView registerClass:[CLSHCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
    [self.view addSubview:_leftTableView];
    [self.view addSubview:_rightCollectionView];

}

#pragma mark 导航条点击事件
- (void)TosearchVC{

    CLSHSearchGoodsViewController * SearchVC = [[CLSHSearchGoodsViewController alloc] init];
    [self.navigationController pushViewController:SearchVC animated:YES];
}

#pragma mark tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _rootCategory.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44*pro;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLSHTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:leftID];
    if (!cell) {
        cell = [[CLSHTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:leftID];
    }
    
    //一级分类
    CLSHClassifyRootModel *rootCategory=_rootCategory[indexPath.row];
    cell.listLabel.text =rootCategory.productCategory.name;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_secondCategory removeAllObjects];
    CLSHClassifyRootModel *rootCategory=_rootCategory[indexPath.row];
    
    //右边菜单的分类数组
    [self.secondCategory addObject:rootCategory.productCategory];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)1.0*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        [_rightCollectionView reloadData];

//    });
    
    if (SelectRow == indexPath.row) {
        return;
    }
    
    //改变颜色
    CLSHTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.listLabel.textColor = RGBColor(0, 149, 68);
    cell.lineView.backgroundColor = RGBColor(0, 149, 68);
    
    
    [_rightCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    SelectRow = (int)indexPath.row;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //改回颜色
    CLSHTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.listLabel.textColor = [UIColor blackColor];
    cell.lineView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - nav and back
-(UIView*)TitleView:(NSString *)TitleString{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
    label.font = [UIFont systemFontOfSize:17*pro];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = TitleString;
    [view addSubview:label];
    return view;
}


#pragma mark collectionView delegate datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    CLSHClassifyProductCategoryModel *model=_secondCategory[0];
    return model.children.count+1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0)
    {
        return 1;
    }
    else
    {
        CLSHClassifyProductCategoryModel *model=_secondCategory[0];
        CLSHClassifyProductSecCategoryModel *_secCategoryModel=model.children[section-1];
        return _secCategoryModel.children.count;
    }
   
}

//collectionHeaderView
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    CLSHCollectionHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID forIndexPath:indexPath];
    
    if ([kind isKindOfClass:[UICollectionElementKindSectionHeader class]]) {
        if (indexPath.section == 0) {
            headerView.HeaderLabel.text = @"";
            return headerView;
        }else{
            
            //右边分类的菜单
            CLSHClassifyProductCategoryModel *model=_secondCategory[0];
              CLSHClassifyProductSecCategoryModel *_secCategoryModel=model.children[indexPath.section-1];
            
//            CLSHClassifyProductSecCategoryModel *_secCategoryModel=_secondCategory[indexPath.section-1];
            
            if (_secCategoryModel.children.count==0)
            {
                
                headerView.HeaderLabel.text = @"";

            }
            else
            {
                 headerView.HeaderLabel.text = _secCategoryModel.name ;
            }
            return headerView;
        }
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0)
    {
        
        return CGSizeZero;
    }
    else
    {
        
            CLSHClassifyProductCategoryModel *model=_secondCategory[0];
            CLSHClassifyProductSecCategoryModel *_secCategoryModel=model.children[section-1];
        if (_secCategoryModel.children.count==0)
        {
            return CGSizeZero;
        }
        else
        {
             return CGSizeMake(SCREENWIDTH*3/4-5*pro,40*pro);
        }
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CLSHHeaderCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:topID forIndexPath:indexPath];
    CLGSCategoryCell *coCell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    CLSHClassifyProductCategoryModel *model=_secondCategory[0];
    
    if (indexPath.section == 0)
    {
        [cell.headerImgView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
        return cell;
    }
    else
    {
        
//        CLSHClassifyProductCategoryModel *model=_secondCategory[0];
        CLSHClassifyProductSecCategoryModel *_secCategoryModel=model.children[indexPath.section-1];
        
//        CLSHClassifyProductSecCategoryModel *_secCategoryModel=_secondCategory[indexPath.section-1];
        CLSHClassifyProductSecCategoryItemModel *SecItemModel=_secCategoryModel.children[indexPath.item];
        coCell.model = SecItemModel;
//        coCell.backgroundColor = [UIColor whiteColor];
//        coCell.layer.borderColor = [UIColor whiteColor].CGColor;
//        coCell.layer.borderWidth = 0;
        return coCell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    CLSHClassifyProductCategoryModel *model=_secondCategory[0];
    if (indexPath.section!=0) {
        CLSHClassifyProductSecCategoryModel *_secCategoryModel=model.children[indexPath.section-1];
        //    CLSHClassifyProductSecCategoryModel *_secCategoryModel=_secondCategory[indexPath.section-1];
        CLSHClassifyProductSecCategoryItemModel *SecItemModel=_secCategoryModel.children[indexPath.item];
        
        //    secCategoryModel = rootModel.productCategory.children[indexPath.item];
        CLSHGoodsListViewController * GoodListsVC = [[CLSHGoodsListViewController alloc] init];
        GoodListsVC.navigationController.title = @"商品列表";
        GoodListsVC.menuId = SecItemModel.menuID;
        [self.navigationController pushViewController:GoodListsVC animated:YES];
    }else
    {
        CLSHGoodsListViewController * GoodListsVC = [[CLSHGoodsListViewController alloc] init];
        GoodListsVC.navigationController.title = @"商品列表";
        GoodListsVC.menuId = model.menuID;
        [self.navigationController pushViewController:GoodListsVC animated:YES];
    }
   
}

#pragma mark <UICollectionViewDelegateFlowLayout>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CLSHClassifyProductCategoryModel *model=_secondCategory[0];
   
    
    if (indexPath.section == 0)
    {
        if (model.image.length==0)
        {
//            return CGSizeZero;
            return CGSizeMake(SCREENWIDTH*3/4-10*pro, 1);
        }
        else
        {
            return CGSizeMake(SCREENWIDTH*3/4-10*pro, (SCREENWIDTH*3/4-10*pro)/2-10);
        }
//        return CGSizeZero;
    }
    else
    {
         CLSHClassifyProductSecCategoryModel *_secCategoryModel=model.children[indexPath.section-1];
//        CLSHClassifyProductCategoryModel *model=_secondCategory[0];
      
        
        if (_secCategoryModel.children.count==0)
        {
             return CGSizeZero;
        }else
        {
             return CGSizeMake((SCREENWIDTH*3/4-10*pro)/3, (SCREENWIDTH*3/4-10*pro)/3);
        }
//            return CGSizeZero;
    }
  
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


//设置tableView分割线从顶端开始 适配ios7和ios8
- (void)viewDidLayoutSubviews{
    
    if ([_leftTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_leftTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([_leftTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_leftTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
