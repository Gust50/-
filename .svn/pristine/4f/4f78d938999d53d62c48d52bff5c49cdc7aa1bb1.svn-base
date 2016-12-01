//
//  CLSHSetupCenter.m
//  ClshUser
//
//  Created by wutaobo on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHSetupCenter.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHSetupMyIconCell.h"
#import "CLSHSetupCenterCell.h"
#import "CLSHSetupSexCell.h"
#import "CLSHSetupMessagePushCell.h"
#import "CLSHSetupMyNickNameVC.h"
#import "CLSHModifyPhoneNumberVC.h"
#import "CLSHMyBankCartVC.h"
#import "CLSHComplaintsSuggestionVC.h"
#import "CLSHClearCache.h"
#import "CLSHAbountUsViewController.h"
#import "CLSHAccountCorrectModel.h"
#import "CLSHLoginViewController.h"
#import "KBCacheTool.h"
#import "CLSHModifyPasswordVC.h"
#import "KBCustomPhotoCollectionViewController.h"

@interface CLSHSetupCenter ()<KBCustomPhotoCollectionViewControllerDelegate>

{
    CLSHAccountLogoutModel *accountLogoutModel;
    CLSHSetUpCenterModel *setUpCenterModel;
    CLSHIconUploadModel * FileUploadModel;
    CLSHIconChangeModel * iconChangeModel;
}
/** 名称数组 */
@property (nonatomic, strong) NSArray *iconNameArr;
/** 图标数组 */
@property (nonatomic, strong) NSArray *iconImageArr;
@end

@implementation CLSHSetupCenter

static NSString *const myIconID = @"CLSHSetupMyIconCell";
static NSString *const setupCenterID = @"CLSHSetupCenterCell";
static NSString *const sexID = @"CLSHSetupSexCell";
static NSString *const messageID = @"CLSHSetupMessagePushCell";

#pragma mark <lazyLoad>
-(NSArray *)iconImageArr
{
    if (!_iconImageArr) {
        _iconImageArr = @[@"NickNameIcon", @"EmailIcon", @"PhoneNumberIcon", @"PasswordIconBlack", @"BankIcon", @"ClearCacheIcon", @"Suggestions", @"AboutIcon"];
    }
    return _iconImageArr;
}
-(NSArray *)iconNameArr
{
    if (!_iconNameArr) {
        _iconNameArr = @[@"我的昵称", @"我的邮箱", @"修改手机号",@"修改密码", @"我的银行卡", @"清除缓存", @"投诉建议",  @"关于粗粮生活"];
    }
    return _iconNameArr;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"设置"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];

    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHSetupMyIconCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:myIconID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHSetupCenterCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:setupCenterID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHSetupSexCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:sexID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHSetupMessagePushCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:messageID];
    
    //尾视图
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100*pro)];
    UIButton *signOut=[[UIButton alloc]initWithFrame:CGRectMake(10, 30*pro, SCREENWIDTH-20, 40*pro)];
    signOut.layer.cornerRadius=5.0;
    signOut.layer.masksToBounds=YES;
    signOut.backgroundColor=systemColor;
    [signOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signOut setTitle:@"退出登录" forState:UIControlStateNormal];
    [signOut addTarget:self action:@selector(setupSignOut) forControlEvents:UIControlEventTouchUpInside];
    signOut.titleLabel.font=[UIFont systemFontOfSize:16*pro];
    [footer addSubview:signOut];
    
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100*pro)];
    self.tableView.tableFooterView=footer;
    self.tableView.tableFooterView.backgroundColor = backGroundColor;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [self loadData];
}

//-(void)viewWillDisappear:(BOOL)animated{
//
//    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
//}
#pragma mark <loadData>
-(void)loadData{
    setUpCenterModel=[[CLSHSetUpCenterModel alloc]init];
    [setUpCenterModel fetchSetUpCenterModel:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            setUpCenterModel = result;
            
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 7;
    }else
    {
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLSHSetupMyIconCell *myIconCell = [tableView dequeueReusableCellWithIdentifier:myIconID];
    CLSHSetupCenterCell *setupCenterCell = [tableView dequeueReusableCellWithIdentifier:setupCenterID];
    CLSHSetupSexCell *sexCell = [tableView dequeueReusableCellWithIdentifier:sexID];
    CLSHSetupMessagePushCell *messageCell = [tableView dequeueReusableCellWithIdentifier:messageID];
    setupCenterCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!myIconCell) {
        myIconCell = [[CLSHSetupMyIconCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIconID];
    }
    if (!setupCenterCell) {
        setupCenterCell = [[CLSHSetupCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:setupCenterID];
    }
    if (!sexCell) {
        sexCell = [[CLSHSetupSexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sexID];
    }
    if (!messageCell) {
        messageCell = [[CLSHSetupMessagePushCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messageID];
    }
    setupCenterCell.selectionStyle = UITableViewCellSelectionStyleNone;
    myIconCell.selectionStyle = UITableViewCellSelectionStyleNone;
    sexCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            myIconCell.setUpCenterModel = setUpCenterModel;
            return myIconCell;
        }else if (indexPath.row == 1)
        {
            setupCenterCell.imageIcon.image = [UIImage imageNamed:self.iconImageArr[0]];
            setupCenterCell.imageLabel.text = self.iconNameArr[0];
            if (setUpCenterModel.nickname == nil) {
                setupCenterCell.displayRightLabel.text = @"还没有昵称";
            }else
            {
                setupCenterCell.displayRightLabel.text = setUpCenterModel.nickname;
            }
            return setupCenterCell;
        }else if (indexPath.row == 2)
        {
            sexCell.gender = setUpCenterModel.gender;
            return sexCell;
        }else if(indexPath.row == 3)
        {
            setupCenterCell.imageIcon.image = [UIImage imageNamed:self.iconImageArr[1]];
            setupCenterCell.imageLabel.text = self.iconNameArr[1];
            if (setUpCenterModel.email == nil) {
                setupCenterCell.displayRightLabel.text = @"还没有绑定邮箱";
            }else
            {
                setupCenterCell.displayRightLabel.text = setUpCenterModel.email;
            }
            return setupCenterCell; 
        }else if(indexPath.row == 4)
        {
            setupCenterCell.imageIcon.image = [UIImage imageNamed:self.iconImageArr[2]];
            setupCenterCell.imageLabel.text = self.iconNameArr[2];
            setupCenterCell.displayRightLabel.text = [setUpCenterModel.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];

            return setupCenterCell;
        }else if(indexPath.row == 5)
        {
            setupCenterCell.imageIcon.image = [UIImage imageNamed:self.iconImageArr[3]];
            setupCenterCell.imageLabel.text = self.iconNameArr[3];
            setupCenterCell.displayRightLabel.text = @"可修改";
            
            return setupCenterCell;
        }else if (indexPath.row == 6) {
            setupCenterCell.imageIcon.image = [UIImage imageNamed:self.iconImageArr[4]];
            setupCenterCell.imageLabel.text = self.iconNameArr[4];
            if ([setUpCenterModel.bankAccountCount intValue] == 0) {
                setupCenterCell.displayRightLabel.text = @"还没有添加银行卡";
            }else
            {
                setupCenterCell.displayRightLabel.text = [NSString stringWithFormat:@"%zi张银行卡", [setUpCenterModel.bankAccountCount intValue]];
            }
            
            return setupCenterCell;
        }
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            messageCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return messageCell;
        }else if(indexPath.row == 1)
        {
            setupCenterCell.imageIcon.image = [UIImage imageNamed:self.iconImageArr[5]];
            setupCenterCell.imageLabel.text = self.iconNameArr[5];
            setupCenterCell.displayRightLabel.text = [KBCacheTool caculatorCacheSize];
            
            return setupCenterCell;
        }else if(indexPath.row == 2)
        {
            setupCenterCell.imageIcon.image = [UIImage imageNamed:self.iconImageArr[6]];
            setupCenterCell.imageLabel.text = self.iconNameArr[6];
            setupCenterCell.displayRightLabel.text = nil;
            return setupCenterCell;
        }else if(indexPath.row == 3)
        {
            setupCenterCell.imageIcon.image = [UIImage imageNamed:self.iconImageArr[7]];
            setupCenterCell.imageLabel.text = self.iconNameArr[7];
            setupCenterCell.displayRightLabel.text = nil;
            return setupCenterCell;
        }
    }
    return nil;
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 70*pro;
        }
    }
    return 50*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10*pro;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if(indexPath.row==0){
            
            //相册图片
            KBCustomPhotoCollectionViewController *kBCustomPhotoCollectionViewController=[[KBCustomPhotoCollectionViewController alloc]init];
            kBCustomPhotoCollectionViewController.delegate=self;
            kBCustomPhotoCollectionViewController.allowsMultipleSelection=YES;
            kBCustomPhotoCollectionViewController.maxNumber=1;
            [self.navigationController pushViewController:kBCustomPhotoCollectionViewController animated:YES];
            
        }
        else if (indexPath.row == 1) {
            CLSHSetupMyNickNameVC *myNickname = [[CLSHSetupMyNickNameVC alloc] init];
            myNickname.titleString = @"我的昵称";
            myNickname.nickName = setUpCenterModel.nickname;
            myNickname.isMyEmail = NO;
            
            [self.navigationController pushViewController:myNickname animated:YES];
        }else if (indexPath.row == 3)
        {
            CLSHSetupMyNickNameVC *myNickname = [[CLSHSetupMyNickNameVC alloc] init];
            myNickname.titleString = @"我的邮箱";
            myNickname.email = setUpCenterModel.email;
            myNickname.isMyEmail = YES;
            
            [self.navigationController pushViewController:myNickname animated:YES];
        }else if (indexPath.row == 4)
        {
            CLSHModifyPhoneNumberVC *phoneNumber = [[CLSHModifyPhoneNumberVC alloc] init];
            [self.navigationController pushViewController:phoneNumber animated:YES];
        }else if (indexPath.row == 5)
        {
            CLSHModifyPasswordVC *modifyPasswordVC = [[CLSHModifyPasswordVC alloc] init];
            modifyPasswordVC.phoneNumber = setUpCenterModel.mobile;
            [self.navigationController pushViewController:modifyPasswordVC animated:YES];
        }else if (indexPath.row == 6)
        {
            CLSHMyBankCartVC *myBankCart = [[CLSHMyBankCartVC alloc] init];
            myBankCart.bankCartCount = [setUpCenterModel.bankAccountCount integerValue];
            myBankCart.isAuthenticationSubmitted = self.isAuthenticationSubmitted;
            [self.navigationController pushViewController:myBankCart animated:YES];
        }
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 1) {
            WS(weakSelf);
            CLSHClearCache *clearCacheView=[[[NSBundle mainBundle]loadNibNamed:@"CLSHClearCache" owner:self options:nil]lastObject];
            clearCacheView.frame=self.view.bounds;
            clearCacheView.center=self.view.center;
            clearCacheView.describe.text = @"清除缓存会导致部分数据丢失，确定清除？";
            [clearCacheView.confirm setTitle:@"确定" forState:UIControlStateNormal];
            [clearCacheView.cancel setTitle:@"取消" forState:UIControlStateNormal];
            clearCacheView.clearCacheBlock = ^(){
                [KBCacheTool clearCache];
                [weakSelf.tableView reloadData];
            };
            [[[UIApplication sharedApplication] keyWindow]addSubview:clearCacheView];
            
        }else if (indexPath.row == 2) {
            CLSHComplaintsSuggestionVC *suggestion = [[CLSHComplaintsSuggestionVC alloc] init];
            [self.navigationController pushViewController:suggestion animated:YES];
        }else if(indexPath.row == 3){
        
            CLSHAbountUsViewController * AbountUsVC = [[CLSHAbountUsViewController alloc] init];
            AbountUsVC.titleString = @"关于我们";
            [self.navigationController pushViewController:AbountUsVC animated:YES];
        }
    }
    
}

#pragma mark <otherResponse>
//退出登录
- (void)setupSignOut
{
    accountLogoutModel=[[CLSHAccountLogoutModel alloc]init];
    [accountLogoutModel postAppLogoutData:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin=NO;
            [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token = nil;
            NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];
            dict[@"password"]=nil;
            [[NSUserDefaults standardUserDefaults]setObject:dict forKey:@"username"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                
                CLSHLoginViewController *loginViewController=[[CLSHLoginViewController alloc]init];
                loginViewController.isBackRootTabbar=YES;
                [self.parentViewController presentViewController:loginViewController animated:YES completion:nil];
            });
           
            
        }else{
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark <KBCustomPhotoCollectionViewControllerDelegate>
//上传个人头像 //拍照
-(void)KBPhotoUpLoadUserIcon:(UIImage *)image imageBaseString:(NSString *)baseString{
    
    if (![baseString isEqualToString:@""]) {
        FileUploadModel = [[CLSHIconUploadModel alloc] init];
        NSMutableDictionary * needsParams = [NSMutableDictionary dictionary];
        needsParams[@"fileName"] = @"aa.jpg";
        needsParams[@"fileType"] = @"image";
        needsParams[@"base64Data"] = baseString;
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [FileUploadModel fetchAccountIconUploadModel:needsParams callBack:^(BOOL isSuccess, id result) {
                
                if (isSuccess) {
                    
                    FileUploadModel = result;
                    if (![FileUploadModel.url isEqualToString:@""]) {
                        
                        iconChangeModel = [[CLSHIconChangeModel alloc] init];
                        NSMutableDictionary * params = [NSMutableDictionary dictionary];
                        params[@"avatar"] = FileUploadModel.url;
                        [iconChangeModel fetchAccountChangeIconModel:params callBack:^(BOOL isSuccess, id result) {
                            
                            if (isSuccess) {
                                [MBProgressHUD showSuccess:@"更换成功"];
                                
                                [self loadData];
                            }else{
                                
                                [MBProgressHUD showError:@"上传失败"];
                            }
                        }];
                    }
                }else{
                    
                    [MBProgressHUD showError:@"上传失败"];
                }
                
            }];
        });
        
        
    }
}

//上传图片数组 //相机
-(void)KBPhotoUpLoadImages:(NSArray *)images imageBaseStringArr:(NSArray *)imgStringArr{
     NSLog(@">>>>>>>>>>>>%@%@",images,imgStringArr);
    
    if (imgStringArr.count) {
        FileUploadModel = [[CLSHIconUploadModel alloc] init];
        NSMutableDictionary * needsParams = [NSMutableDictionary dictionary];
        needsParams[@"fileName"] = @"aa.jpg";
        needsParams[@"fileType"] = @"image";
        needsParams[@"base64Data"] = imgStringArr[0];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
            [FileUploadModel fetchAccountIconUploadModel:needsParams callBack:^(BOOL isSuccess, id result) {
                
                if (isSuccess) {
                    
                    FileUploadModel = result;
                    if (![FileUploadModel.url isEqualToString:@""]) {
                        
                        iconChangeModel = [[CLSHIconChangeModel alloc] init];
                        NSMutableDictionary * params = [NSMutableDictionary dictionary];
                        params[@"avatar"] = FileUploadModel.url;
                        [iconChangeModel fetchAccountChangeIconModel:params callBack:^(BOOL isSuccess, id result) {
                            
                            if (isSuccess) {
                                [MBProgressHUD showSuccess:@"更换成功"];
                                
                                [self loadData];
                            }else{
                                
                                [MBProgressHUD showError:@"上传失败"];
                            }
                        }];
                    }
                }else{
                    
                    [MBProgressHUD showError:@"上传失败"];
                }
                
            }];
        });
        
    }
    
}

-(void)setIsAuthenticationSubmitted:(BOOL)isAuthenticationSubmitted
{
    _isAuthenticationSubmitted = isAuthenticationSubmitted;
}

@end
