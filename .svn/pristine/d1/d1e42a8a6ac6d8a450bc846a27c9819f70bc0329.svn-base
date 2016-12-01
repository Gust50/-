//
//  CLSHAddressManagmentViewController.m
//  ClshUser
//
//  Created by arom on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHAddressManagmentViewController.h"
#import "CLSHNonAddressView.h"
#import "CLSHAddressTableViewCell.h"
#import "CLSHEditViewController.h"
#import "CLSHdeletView.h"
#import "CLSHAddressManagerModel.h"
#import "UINavigationBar+Awesome.h"


@interface CLSHAddressManagmentViewController()<UITableViewDelegate,UITableViewDataSource,addNewAddressDelegate>{

    CLSHAddressManagerModel * AddressListModel;    //<地址列表model
    CLSHAddressInfoModel * addressInfoModel;       //<地址信息model
    CLSHDeleteAddressModel * deleteAdderssModel;   //<删除地址model
    NSString * addressId;
}

@property (nonatomic,strong)NSArray * AddressArray; //地址数组
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)CLSHNonAddressView * nonAddressView;
@property (nonatomic,strong)UIButton * addAddress;

@end

@implementation CLSHAddressManagmentViewController

#pragma mark <lazyload>
- (NSArray *)AddressArray{
    
    if (!_AddressArray) {
        _AddressArray = [NSArray array];
    }
    return _AddressArray;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64-40*pro) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = backGroundColor;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [_tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
        
    }
    return _tableView;
}

- (CLSHNonAddressView *)nonAddressView{
    
    if (!_nonAddressView) {
        _nonAddressView = [[[NSBundle mainBundle] loadNibNamed:@"CLSHNonAddressView" owner:self options:nil]lastObject];

        _nonAddressView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        _nonAddressView.delegate = self;
    }
    return _nonAddressView;
}

- (UIButton *)addAddress{
    
    if (!_addAddress) {
        _addAddress = [[UIButton alloc] initWithFrame:CGRectMake(20*pro, SCREENHEIGHT-60*pro, SCREENWIDTH-40*pro, 40*pro)];
        _addAddress.backgroundColor = RGBColor(0, 149, 68);
        [_addAddress setTintColor:[UIColor whiteColor]];
        _addAddress.titleLabel.font = [UIFont systemFontOfSize:14*pro];
        [_addAddress setTitle:@"╋新增地址" forState:(UIControlStateNormal)];
        _addAddress.layer.masksToBounds = YES;
        _addAddress.layer.cornerRadius = 5;
        [_addAddress addTarget:self action:@selector(addNewAddr) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addAddress;
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    //加载数据源
    [self loadData];
     [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据源
    [self loadData];
    //初始化UI
    [self initUI];
    
}

- (void)loadData{

    AddressListModel = [[CLSHAddressManagerModel alloc] init];
    addressInfoModel = [[CLSHAddressInfoModel alloc] init];

        [MBProgressHUD showMessage:@"loading..." toView:self.view];
        [AddressListModel fetchAddressManager:nil callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                AddressListModel = result;
                self.AddressArray = AddressListModel.receivers;
        
                NSLog(@"%@",_AddressArray);
                if (self.AddressArray.count == 0) {
                   
                    [self.view addSubview:self.nonAddressView];
                    
                }else{
                    
                    [self.view addSubview:self.tableView];
                    [self.view addSubview:self.addAddress];
                    [self.tableView reloadData];
                }
                
            }else{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                sleep(1);
                [MBProgressHUD showError:result];
            }

        }];
}

- (void)initUI{
    
//    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = backGroundColor;
    self.navigationItem.title = @"管理收货地址";

    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"isEnable"];
}

#pragma mark AddNewAddressDelegate
- (void)ToAddNewAddressVC{
    
    [self addNewAddr];
}

#pragma mark 点击新增地址

- (void)addNewAddr{

    CLSHEditViewController * editVc = [[CLSHEditViewController alloc]initWithNibName:@"CLSHEditViewController" bundle:[NSBundle mainBundle]];
//    CLSHEditViewController * editVc =[[CLSHEditViewController alloc] init];
    editVc.titleStr = @"新增收货地址";
    editVc.isNewAdd = YES;
    [self.navigationController pushViewController:editVc animated:YES];
    
}

#pragma mark datasoource delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
   return self.AddressArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * str = [NSString stringWithFormat:@"%@%@",[_AddressArray[indexPath.section] address],[_AddressArray[indexPath.section] areaName]];
    
    CGRect messageRect = [str boundingRectWithSize:CGSizeMake(SCREENWIDTH-57*pro, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13*pro], NSFontAttributeName, nil] context:nil];
    return 77*pro+messageRect.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10*pro;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLSHAddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"isEnable"];
    if (!cell) {
        cell = [[CLSHAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"isEnable"];
    }
    addressInfoModel = _AddressArray[indexPath.section];
    cell.model = addressInfoModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    //点击编辑
    cell.editAddr = ^(){
        
        NSLog(@"======");
        
        CLSHEditViewController * editVc = [[CLSHEditViewController alloc]initWithNibName:@"CLSHEditViewController" bundle:nil];
        editVc.titleStr = @"编辑收货地址";
        editVc.isNewAdd = NO;
        
        addressInfoModel = [[CLSHAddressInfoModel alloc] init];
        addressInfoModel = _AddressArray[indexPath.section];
        NSDictionary * dict = addressInfoModel.mj_keyValues;
        editVc.dict = dict;
        [self.navigationController pushViewController:editVc animated:YES];
        
    };
    
    //点击删除
    cell.deleteAddr = ^{
        NSLog(@"-----");
       __weak CLSHdeletView * deleteView = [[NSBundle mainBundle] loadNibNamed:@"CLSHdeletView" owner:self options:nil][0];
        deleteView.frame = CGRectMake(0, -64, SCREENWIDTH, SCREENHEIGHT+64);
        deleteView.center = self.view.center;
        
        [[[UIApplication sharedApplication] keyWindow]addSubview:deleteView];
        deleteView.ClickYes = ^{
            
            addressInfoModel = [[CLSHAddressInfoModel alloc] init];
            addressInfoModel = _AddressArray[indexPath.section];
            addressId = addressInfoModel.addressID;
            //这里写删除地址的代码
            [self deleteAddress];
        };
        deleteView.ClickNo = ^{
            
            [deleteView removeFromSuperview];
        };
    };
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
      if (_isBackPurchase) {
          
        CLSHAddressInfoModel *model=_AddressArray[indexPath.section];
        if (self.delegate && [self.delegate respondsToSelector:@selector(isUseCoupon:)]) {
            [self.delegate isUseCoupon:model];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.3*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
      }else{
      
          CLSHEditViewController * editVC = [[CLSHEditViewController alloc] init];
          editVC.isSearch = YES;
          editVC.titleStr = @"地址详情";
          addressInfoModel = [[CLSHAddressInfoModel alloc] init];
          addressInfoModel = _AddressArray[indexPath.section];
          NSDictionary * dict = addressInfoModel.mj_keyValues;
          editVC.dict = dict;
          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.2*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
          [self.navigationController pushViewController:editVC animated:YES];
              });
      }
    
    
}

#pragma mark 删除数据
- (void)deleteAddress{

    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"receiverId"] = addressId;
    deleteAdderssModel = [[CLSHDeleteAddressModel alloc] init];
    [MBProgressHUD showMessage:@"Loading..." toView:self.view];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [deleteAdderssModel fetchDeleteAddress:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [self loadData];
                    [self.tableView reloadData];
                });
            }else{
            
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    sleep(1);
                    [MBProgressHUD showError:result];
                });
            }
        }];
        
    });
}


#pragma mark <getter setter>
-(void)setIsBackPurchase:(BOOL)isBackPurchase{
    _isBackPurchase=isBackPurchase;
}
@end
