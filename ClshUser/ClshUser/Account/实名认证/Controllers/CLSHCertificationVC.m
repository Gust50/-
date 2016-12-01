//
//  CLSHCertificationVC.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/16.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHCertificationVC.h"
#import "KBSegmentView.h"
#import "CLSHinputMerchantJoinCell.h"
#import "CLSHIndetityImageCell.h"
#import "KBCustomPhotoCollectionViewController.h"
#import "CLSHMerchantJoinModel.h"
#import "CLSHUploadImageModel.h"
#import "UIImage+KBExtension.h"
#import "CLSHSelectGenderCell.h"
#import "CLSHAccountBalanceModel.h"
#import "CLSHAddBankCartVC.h"
#import "CLSHSelectGenderCell.h"
#import "CLSHApplicationWithDrawalsVC.h"

@interface CLSHCertificationVC ()<UITableViewDelegate, UITableViewDataSource, CLSHinputMerchantJoinCellDelegate,CLSHIndetityImageCellDelegate,KBCustomPhotoCollectionViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, KBSegmentViewDelegate>
{
    BOOL isPerson;              ///<判断是否选择个人
    
    NSString *nameReal;         ///<法人姓名
    NSString *companyName;      ///<企业名称
    NSString *personName;       ///<个人名称
    NSString *identityNum;      ///<身份证号
    NSString *licenseNum;       ///<执照编号
    NSString *idPositive;       ///<身份证正面
    NSString *idReverse;        ///<身份证反面
    NSString *businessCard;     ///<执照编号
    
    NSString *shopDetailAddress;
    
    CLSHUserCertificationModel * userCerModel;
    CLSHUploadImageModel * cLSHUploadImageModel;
    NSMutableDictionary *imgDict;
    NSString *tempImgStr;
    NSString *tempTypeName;
    NSInteger tempAppendNumber;
    NSMutableDictionary *infoParams;
}

@property (nonatomic, strong)KBSegmentView *segmentView;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *uploadArray;
@property (nonatomic, strong)NSArray *personUploadArray;
@property (nonatomic, strong)NSIndexPath *tempIndexPath;
@property (nonatomic, strong)NSMutableDictionary * saveIdDict;

@end

@implementation CLSHCertificationVC
static NSString *const indetityImageID = @"CLSHIndetityImageCell";
static NSString *const selectGenderID = @"selectGenderID";

#pragma mark - lazyLoad

-(KBSegmentView *)segmentView
{
    if (!_segmentView) {
        _segmentView = [KBSegmentView createSegmentFrame:CGRectMake(0, 64, SCREENWIDTH, 40*pro) segmentTitleArr:@[@"企业", @"个人"] backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] selectTitleColor:systemColor titleFont:[UIFont systemFontOfSize:14*pro] bottomLineColor:systemColor isVerticleBar:NO delegate:self];
    }
    return _segmentView;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+40*pro, SCREENWIDTH, SCREENHEIGHT-64-40*pro) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = backGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
    }
    return _tableView;
}

-(NSArray *)uploadArray
{
    if (!_uploadArray) {
        _uploadArray = [NSArray arrayWithObjects:@"请上传身份证正面", @"请上传身份证反面", @"请上传营业执照", nil];
    }
    return _uploadArray;
}

-(NSArray *)personUploadArray
{
    if (!_personUploadArray) {
        _personUploadArray = [NSArray arrayWithObjects:@"请上传身份证正面", @"请上传身份证反面", nil];
    }
    return _personUploadArray;
}

-(NSMutableDictionary *)saveIdDict{
    if (!_saveIdDict) {
        _saveIdDict=[NSMutableDictionary dictionary];
    }
    return _saveIdDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"实名认证"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.tableView];
    [self loadFooter];
    imgDict=[NSMutableDictionary dictionary];
    tempAppendNumber=200;
    cLSHUploadImageModel=[CLSHUploadImageModel new];
    userCerModel = [CLSHUserCertificationModel new];
    infoParams = [NSMutableDictionary dictionary];
    isPerson = NO;
    infoParams[@"gender"] = @(0);
    
    //注册cell
    [self.tableView registerClass:[CLSHIndetityImageCell class] forCellReuseIdentifier:indetityImageID];
    [self.tableView registerClass:[CLSHSelectGenderCell class] forCellReuseIdentifier:selectGenderID];
    
}

#pragma mark - footer
- (void)loadFooter
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60*pro)];
    view.backgroundColor = backGroundColor;
    UIButton *next = [[UIButton alloc] initWithFrame:CGRectMake(10*pro, 10*pro, SCREENWIDTH-20*pro, 40*pro)];
    next.layer.cornerRadius = 5.0*pro;
    next.layer.masksToBounds = YES;
    next.backgroundColor = systemColor;
//    next.timeInterval = 5;
//    next.isEnableClickBtn = YES;
    
    [next setTitle:@"提交" forState:UIControlStateNormal];
    [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [next addTarget:self action:@selector(merchantJoinInfo) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:next];
    self.tableView.tableFooterView = view;
}

//下一步
- (void)merchantJoinInfo
{
    [self loadData];
}

#pragma mark - loadData
- (void)loadData
{
    if ([self ValidateIsSuccess]) {
        
        if (!isPerson) {
            infoParams[@"type"] = @(1);                     ///<0=个人/1=企业
            infoParams[@"realname"] = companyName;          ///<企业名称
            infoParams[@"legalPersonName"] = nameReal;      ///<法人姓名
            infoParams[@"businessCardNumber"] = licenseNum; ///<执照编码
        }else
        {
            infoParams[@"type"] = @(0);
            infoParams[@"legalPersonName"] = personName;            ///<个人名称
            [infoParams removeObjectsForKeys:[NSArray arrayWithObjects:@"realname", @"businessCardNumber", @"businessCard",  nil]];
        }
        infoParams[@"idNumber"] = identityNum;               ///<身份证号码
        
        [userCerModel fetchMerchantJoinWriteInfoData:infoParams callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [MBProgressHUD showSuccess:@"认证成功"];
                if (self.tag == 2) {
                    CLSHAddBankCartVC *addBankCartVC = [CLSHAddBankCartVC new];
                    [self.navigationController pushViewController:addBankCartVC animated:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"isAuthenticationSubmitted" object:nil];
                }else
                {
                    CLSHApplicationWithDrawalsVC *withDrawalsVC = [CLSHApplicationWithDrawalsVC new];
                    withDrawalsVC.balance = self.balance;
                    [self.navigationController pushViewController:withDrawalsVC animated:YES];
                }
                
            }else
            {
                [MBProgressHUD showError:@"认证失败"];
            }
        }];
    }
    
}

//表单验证
- (BOOL)ValidateIsSuccess
{
    if (isPerson) {
        if (personName.length == 0) {
            [MBProgressHUD showError:@"请输入个人名称"];
            return NO;
        }else if (![KBRegexp validateUserIdCard:identityNum]) {
            [MBProgressHUD showError:@"请输入正确的身份证号码"];
            return NO;
        }
        else if (idPositive.length == 0) {
            [MBProgressHUD showError:@"请上传身份证正面"];
            return NO;
        }else if (idReverse.length == 0) {
            [MBProgressHUD showError:@"请上传身份证反面"];
            return NO;
        }else
        {
            return YES;
        }
    }else
    {
        if (nameReal.length == 0) {
            [MBProgressHUD showError:@"请输入法人姓名"];
            return NO;
        }else if (companyName.length == 0) {
            [MBProgressHUD showError:@"请输入企业名称"];
            return NO;
        }
        else if (![KBRegexp validateUserIdCard:identityNum]) {
            [MBProgressHUD showError:@"请输入正确的身份证号码"];
            return NO;
        }
        else if (licenseNum.length == 0) {
            [MBProgressHUD showError:@"请输入执照编码"];
            return NO;
        }
        else if (idPositive.length == 0) {
            [MBProgressHUD showError:@"请上传身份证正面"];
            return NO;
        }else if (idReverse.length == 0) {
            [MBProgressHUD showError:@"请上传身份证反面"];
            return NO;
        }else if (businessCard.length == 0) {
            [MBProgressHUD showError:@"请上传营业执照"];
            return NO;
        }else
        {
            return YES;
        }
    }
    
    return nil;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isPerson) {
        if (section == 0) {
            return 3;
        }else
        {
            return 2;
        }
    }else
    {
        if (section == 0) {
            
            return 5;
        }
        else
        {
            return 3;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CLSHIndetityImageCell *indetityImageCell = [tableView dequeueReusableCellWithIdentifier:indetityImageID];
    CLSHSelectGenderCell * selectGenderCell = [tableView dequeueReusableCellWithIdentifier:selectGenderID];
    
    // 每次先从字典中根据IndexPath取出唯一标识符
    NSString *identifier = [_saveIdDict objectForKey:[NSString stringWithFormat:@"%ld%ld", indexPath.section,indexPath.row]];
    // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"%@%@%@", @"CLSHinputMerchantJoinCell",[NSString stringWithFormat:@"%ld", indexPath.section],[NSString stringWithFormat:@"%ld", indexPath.row]];
        [_saveIdDict setValue:identifier forKey:[NSString stringWithFormat:@"%ld%ld", indexPath.section,indexPath.row]];
        // 注册Cell
       [self.tableView registerClass:[CLSHinputMerchantJoinCell class] forCellReuseIdentifier:identifier];
    }
    
    CLSHinputMerchantJoinCell * inputMerchantJoinCell = [[CLSHinputMerchantJoinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    if (!indetityImageCell) {
        indetityImageCell = [[CLSHIndetityImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetityImageID];
    }
    if (!selectGenderCell) {
        selectGenderCell = [[CLSHSelectGenderCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:selectGenderID];
    }
    indetityImageCell.delegate=self;
    indetityImageCell.isPerson=isPerson;
    indetityImageCell.indexPath=indexPath;
    inputMerchantJoinCell.delegate = self;
    indetityImageCell.selectionStyle = UITableViewCellSelectionStyleNone;
    selectGenderCell.selectionStyle = UITableViewCellSelectionStyleNone;
    inputMerchantJoinCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    selectGenderCell.selectManblock = ^(){
    
        infoParams[@"gender"] = @(0);
    };
    selectGenderCell.selectWomanblock = ^(){
    
        infoParams[@"gender"] = @(1);
    };

    if (isPerson) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                inputMerchantJoinCell.leftName.text = @"个人名称：";
                inputMerchantJoinCell.inputInfo.text = personName;
                inputMerchantJoinCell.inputInfo.placeholder = @"请输入个人名称";
                return inputMerchantJoinCell;
            }else if (indexPath.row == 1)
            {
                inputMerchantJoinCell.leftName.text = @"身份证号：";
                inputMerchantJoinCell.inputInfo.text = identityNum;
                inputMerchantJoinCell.inputInfo.placeholder = @"请输入您的身份证号码";
                return inputMerchantJoinCell;
            }else{
                
                return selectGenderCell;
            }
        }else {
            NSString *key=[NSString stringWithFormat:@"%ld%ld",tempAppendNumber,indexPath.row];
            
            NSLog(@"%@",key);
            
            [indetityImageCell.upload setTitle:self.personUploadArray[indexPath.row] forState:UIControlStateNormal];
            if (imgDict[key]!=nil) {
                indetityImageCell.icon.image=imgDict[key];
            }else{
                if (indexPath.row == 0) {
                    indetityImageCell.icon.image=[UIImage imageNamed:@"IdentityCardFront"];
                }else{
                    
                    indetityImageCell.icon.image=[UIImage imageNamed:@"IdentityCardBack"];
                }
                
            }
            return indetityImageCell;
        }
    }else
    {
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                inputMerchantJoinCell.leftName.text = @"法人姓名：";
                inputMerchantJoinCell.inputInfo.text = nameReal;
                inputMerchantJoinCell.inputInfo.placeholder = @"请输入法人姓名";
                
                return inputMerchantJoinCell;
            }else if (indexPath.row == 1)
            {
                inputMerchantJoinCell.leftName.text = @"企业名称：";
                inputMerchantJoinCell.inputInfo.text = companyName;
                inputMerchantJoinCell.inputInfo.placeholder = @"请输入企业名称";
                return inputMerchantJoinCell;
            }else if (indexPath.row == 2){
                
                return selectGenderCell;
            }else if (indexPath.row == 3)
            {
                inputMerchantJoinCell.leftName.text = @"身份证号：";
                inputMerchantJoinCell.inputInfo.text = identityNum;
                inputMerchantJoinCell.inputInfo.placeholder = @"请输入您的身份证号码";
                return inputMerchantJoinCell;
            }else if (indexPath.row == 4)
            {
                inputMerchantJoinCell.leftName.text = @"执照编码：";
                inputMerchantJoinCell.inputInfo.text = licenseNum;
                inputMerchantJoinCell.inputInfo.placeholder = @"请输入您的营业执照编码";
                return inputMerchantJoinCell;
                
            }
        }else
        {
            [indetityImageCell.upload setTitle:self.uploadArray[indexPath.row] forState:UIControlStateNormal];
            NSString *key=[NSString stringWithFormat:@"%ld%ld",tempAppendNumber,indexPath.row];
            
            if (imgDict[key]!=nil) {
                indetityImageCell.icon.image=imgDict[key];
            }else{
                if (indexPath.row == 0) {
                    indetityImageCell.icon.image=[UIImage imageNamed:@"IdentityCardFront"];
                }else if (indexPath.row == 1){
                    
                    indetityImageCell.icon.image=[UIImage imageNamed:@"IdentityCardBack"];
                }else{
                    
                    indetityImageCell.icon.image=[UIImage imageNamed:@"CompanyCard"];
                }
                
            }
            return indetityImageCell;
        }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 190*pro;
    }else
    {
        return 40*pro;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40*pro)];
    view.backgroundColor = backGroundColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10*pro, 10*pro, SCREENWIDTH-2*pro, 20*pro)];
    label.backgroundColor = backGroundColor;
    label.font = [UIFont systemFontOfSize:13*pro];
    [view addSubview:label];
    if (section == 0) {
        label.text = @"基本信息";
    }else
    {
        label.text = @"请上传下列证件，上传照片必须为真实!";
    }
    return view;
}

#pragma mark - KBSegmentViewDelegate
-(void)selectSegment:(NSInteger)index
{
    if (index == 0) {
        isPerson = NO;
        tempAppendNumber=200;
    }else
    {
        isPerson = YES;
        tempAppendNumber=100;
    }
    [self.tableView reloadData];
}

#pragma mark <CLSHIndetityImageCellDelegate>

-(void)upLoadImgTypeName:(NSString *)typeName isPerson:(BOOL)isPersion indexPath:(NSIndexPath *)indexPath{
    
    self.tempIndexPath=indexPath;
    tempTypeName=typeName;
    if (isPerson) {
        tempAppendNumber=100;
    }else{
        tempAppendNumber=200;
    }
    //@2新增的提示
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"请选择上传图片的方式" message: @"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *camera = [[UIImagePickerController alloc] init];
            camera.allowsEditing=YES;
            camera.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
                camera.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            }
            camera.delegate = self;
            [self presentViewController:camera animated:YES completion:nil];
        }
        
    }];
    
    UIAlertAction *photo =  [UIAlertAction actionWithTitle:@"相册" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
        KBCustomPhotoCollectionViewController *kBCustomPhotoCollectionViewController=[KBCustomPhotoCollectionViewController new];
        kBCustomPhotoCollectionViewController.delegate=self;
        kBCustomPhotoCollectionViewController.maxNumber=1;
        kBCustomPhotoCollectionViewController.allowsMultipleSelection=YES;
//        kBCustomPhotoCollectionViewController.isCamera = NO;
        [self.navigationController pushViewController:kBCustomPhotoCollectionViewController animated:YES];
    }];
    
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [camera setValue:systemColor forKey:@"_titleTextColor"];
    [photo setValue:systemColor forKey:@"_titleTextColor"];
    [cancel setValue:systemColor forKey:@"_titleTextColor"];
    
    [alterVC addAction:camera];
    [alterVC addAction:photo];
    [alterVC addAction:cancel];
    [self presentViewController:alterVC animated:YES completion:nil];
//    KBCustomPhotoCollectionViewController *kBCustomPhotoCollectionViewController=[KBCustomPhotoCollectionViewController new];
//    kBCustomPhotoCollectionViewController.maxNumber=1;
//    kBCustomPhotoCollectionViewController.delegate=self;
//    kBCustomPhotoCollectionViewController.allowsMultipleSelection=YES;
//    [self.navigationController pushViewController:kBCustomPhotoCollectionViewController animated:YES];
}

//相机
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^(){
        
        UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        image= [UIImage imageByScalingToMaxSize:image];
        
        NSData *originImgData=UIImageJPEGRepresentation(image, 1.0f);
        NSString *imgStr=[originImgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        NSString *key=[NSString stringWithFormat:@"%ld%ld",tempAppendNumber,_tempIndexPath.row];
        imgDict[key]= image;
        [self upLoadImg:key imgStr:imgStr typeName:tempTypeName];
    }];
}

#pragma mark <KBCustomPhotoCollectionViewControllerDelegate>
-(void)KBPhotoUpLoadImages:(NSArray *)images imageBaseStringArr:(NSArray *)imgStringArr{
    
    NSString *key=[NSString stringWithFormat:@"%ld%ld",tempAppendNumber,_tempIndexPath.row];
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>%@",key);
    imgDict[key]=images[0];
    [self upLoadImg:key imgStr:imgStringArr[0] typeName:tempTypeName];
}

-(void)upLoadImg:(NSString *)upLoadName imgStr:(NSString *)imgStr typeName:(NSString *)upLoadImgName{
    NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
//    needParams[@"fileName"]=[NSString stringWithFormat:@"%@.jpg",upLoadName];
    needParams[@"fileName"]=@"aa.jpg";
    needParams[@"fileType"]=@"image";
    needParams[@"base64Data"]=imgStr;
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"图片上传中...";
    hud.dimBackground=YES;
    hud.backgroundColor=backGroundColor;
    
    dispatch_async(dispatch_get_global_queue(2, 0), ^{
        
        [cLSHUploadImageModel upLoadImageData:needParams callBack:^(BOOL isSuccess, id result) {
            
            if (isSuccess) {
                
                cLSHUploadImageModel=result;
                hud.labelText=@"图片上传成功";
                
                if ([upLoadImgName isEqualToString:@"请上传身份证正面"]) {
                    
                    infoParams[@"idPositive"]=cLSHUploadImageModel.url;
                    idPositive = cLSHUploadImageModel.url;
                }else if ([upLoadImgName isEqualToString:@"请上传身份证反面"]){
                    infoParams[@"idReverse"]=cLSHUploadImageModel.url;
                    idReverse = cLSHUploadImageModel.url;
                }else if ([upLoadImgName isEqualToString:@"请上传营业执照"]){
                    infoParams[@"businessCard"]=cLSHUploadImageModel.url;
                    businessCard = cLSHUploadImageModel.url;
                }
                
                [hud hide:YES afterDelay:0.8];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSIndexPath *index=[NSIndexPath indexPathForRow:_tempIndexPath.row inSection:_tempIndexPath.section];
                    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationAutomatic];
                });
                
            }else{
                hud.labelText=@"图片上传失败";
                [hud hide:YES afterDelay:0.8];
            }
        }];
    });
}

#pragma mark - CLSHinputMerchantJoinCellDelegate
- (void)nameLabel:(NSString *)nameLabel inputName:(NSString *)name
{
    if (isPerson) {
        if ([nameLabel isEqualToString:@"个人名称："]) {
            personName = name;
        }else if ([nameLabel isEqualToString:@"身份证号："])
        {
            identityNum = name;
        }
    }else
    {
        if ([nameLabel isEqualToString:@"法人姓名："]) {
            nameReal = name;
        }else if ([nameLabel isEqualToString:@"企业名称："]) {
            companyName = name;
        }else if ([nameLabel isEqualToString:@"身份证号："]) {
            identityNum = name;
        }else if ([nameLabel isEqualToString:@"执照编码："]) {
            licenseNum = name;
        }
    }
    
}


#pragma mark - setter getter
-(void)setTag:(NSInteger)tag
{
    _tag = tag;
}

-(void)setBalance:(NSString *)balance
{
    _balance = balance;
}

@end
