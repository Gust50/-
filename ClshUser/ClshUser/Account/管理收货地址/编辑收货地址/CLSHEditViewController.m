//
//  CLSHEditViewController.m
//  ClshUser
//
//  Created by arom on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHEditViewController.h"
#import "KBPickerArea.h"
#import "CLSHAddressManagerModel.h"
#import "UINavigationBar+Awesome.h"


@interface CLSHEditViewController ()<UITextFieldDelegate,KBPickerAreaDelegate>{

    //NSString * areaID;
    NSString * recieveId;
    NSMutableArray * areaArray;
    MBProgressHUD * hud;
}

@end

@implementation CLSHEditViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

- (void)viewWillDisappear:(BOOL)animated{

    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleStr;
    [self initUI];
    [self loadData];
}

- (void)initUI{

    _DefaultDesc.font = [UIFont systemFontOfSize:14*pro];
    _preserveButton.titleLabel.font = [UIFont systemFontOfSize:14*pro];
    _preserveButton.layer.masksToBounds = YES;
    _preserveButton.layer.cornerRadius = 10;
    _preserveButton.timeInterval = 2;
    _preserveButton.isEnableClickBtn = YES;
    if (_isNewAdd) {
        _name.placeholder = @"请输入收货人姓名";
        _telephone.placeholder = @"请输入联系电话";
        _address.placeholder = @"请选择地址";
        _detailAddress.placeholder = @"请输入街道门牌号";
        _address.delegate = self;
    }else{
        if (_isSearch)
        {
        
        _name.text = [_dict objectForKey:@"consignee"];
        _telephone.text = [_dict objectForKey:@"phone"];
        _address.text = [_dict objectForKey:@"areaName"];
        _detailAddress.text = [_dict objectForKey:@"address"];
        _postal.text = [_dict objectForKey:@"zipCode"];
        //areaID = [_dict objectForKey:@"receiverId"];
        _isDefault.on = [[_dict objectForKey:@"isDefault"] boolValue];
        _DefaultDesc.text = @"是否为默认地址";
        self.view.userInteractionEnabled=NO;
        _preserveButton.hidden = YES;
        
        }else
        {
        
            _name.text = [_dict objectForKey:@"consignee"];
            _telephone.text = [_dict objectForKey:@"phone"];
            _address.text = [_dict objectForKey:@"areaName"];
            _detailAddress.text = [_dict objectForKey:@"address"];
            _postal.text = [_dict objectForKey:@"zipCode"];
            recieveId = [_dict objectForKey:@"id"];
            
            NSLog(@"————————%@",recieveId);
            
            _isDefault.on = [[_dict objectForKey:@"isDefault"] boolValue];
            _DefaultDesc.text = @"是否为默认地址";
            _address.delegate = self;
        }
    }
}


- (void)loadData{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        __block CLSHSearchAddressModel * model = [[CLSHSearchAddressModel alloc] init];
        __block CLSHReceiverModel * receieveModel = [[CLSHReceiverModel alloc] init];
        __block CLSHaddressIdModel * areaIdModel = [[CLSHaddressIdModel alloc] init];
        areaArray = [NSMutableArray array];
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"receiverId"] = [_dict objectForKey:@"id"];
        [model fetchSearchAddress:params callBack:^(BOOL isSuccess, id result) {
           
            if (isSuccess) {
                model = result;
                receieveModel = model.receiver;
                areaArray = receieveModel.areaTree;
                areaIdModel = [areaArray lastObject];
                _areaId = areaIdModel.areaId;
            }
        }];
        
    });
}

#pragma mark AddressTextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    KBPickerArea * pickArea = [[KBPickerArea alloc] initWithDelegate:self];
    pickArea.delegate = self;
    [pickArea showSelectAreaView];
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;{
    
    [textField resignFirstResponder];
    
}

- (void)pickerArea:(KBPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area areaId:(NSString *)areaId{
    _areaId = areaId;
    NSString *string=[NSString stringWithFormat:@"%@ %@ %@",province,city,area];
    self.address.text=string;
}

//保存地址
- (IBAction)preserve:(id)sender {
    
    
        if ([self ValidateIsSuccess]) {
            
            if (_isNewAdd) {
                NSMutableDictionary * params = [NSMutableDictionary dictionary];
                if (self.isDefault.on) {
                    params[@"isDefault"] = @"true";
                }else{
                    
                    params[@"isDefault"] = @"";
                }
                //params[@"timestamp"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.timestamp;
                params[@"consignee"]= self.name.text;
                params[@"phone"] = self.telephone.text;
                params[@"address"] = self.detailAddress.text;
                params[@"zipCode"] = self.postal.text;
                params[@"areaId"] = _areaId;
                params[@"gender"] = @"male";
                
                [MBProgressHUD showMessage:@"loading" toView:self.view];
                
                CLSHSaveAddressModel * model = [[CLSHSaveAddressModel alloc] init];
                [model fetchSaveAddress:params callBack:^(BOOL isSuccess, id result) {
                    
                    if (isSuccess) {
                        [self.navigationController popViewControllerAnimated:YES];
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                    }else{
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:result];
                    }
                }];
            }else{
                
                
//                
//                @property (nonatomic, copy) NSString *address;
//                @property (nonatomic, copy) NSString *areaName;
//                @property (nonatomic, copy) NSString *consignee;  ///<收获人姓名
//                @property (nonatomic, copy) NSString *addressID;
//                @property (nonatomic, copy) NSString *phone;
//                @property (nonatomic, copy) NSString *receiverGender;
//                @property (nonatomic, copy) NSString *zipCode;
//                @property (nonatomic, assign) BOOL isDefault;   ///<是否使用默认地址
                
                
        
            NSMutableDictionary * params = [NSMutableDictionary dictionary];
                if (self.isDefault.on) {
                    params[@"isDefault"] = @"true";
                }else{
                    
                    params[@"isDefault"] = @"";
                }
            params[@"timestamp"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.timestamp;
            params[@"consignee"]= self.name.text;
            params[@"phone"] = self.telephone.text;
            params[@"address"] = self.detailAddress.text;
            params[@"zipCode"] = self.postal.text;
            params[@"receiverId"] = recieveId;
                NSLog(@"_________________%@",recieveId);
            params[@"areaId"] = _areaId;
            params[@"gender"] = @"male";
            [MBProgressHUD showMessage:@"loading" toView:self.view];
//            if (![_areaId isEqualToString:@""]) {
                CLSHEditAddressModel * model = [[CLSHEditAddressModel alloc] init];
                [model fetchEditAddress:params callBack:^(BOOL isSuccess, id result) {
                    
                    if (isSuccess) {
                        [self.navigationController popViewControllerAnimated:YES];
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                    }else{
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:result];
                    }
                    
                    
                }];
                    
//            }

        }
    }
}

//表单验证
- (BOOL)ValidateIsSuccess{

    if(self.name.text == nil || [self.name.text isEqualToString:@""]){
        [MBProgressHUD showSuccess:@"收货人不能为空!"];
        return NO;
    }else if(![KBRegexp checkPhoneNumInput:self.telephone.text]){
        [MBProgressHUD showSuccess:@"请输入正确的手机号码!"];
        return NO;
    }else if([self.address.text isEqualToString:@""]){
        [MBProgressHUD showSuccess:@"请选择收货地址!"];
        return NO;
    }else if([self.detailAddress.text isEqualToString:@""]){
        
        [MBProgressHUD showSuccess:@"请输入街道门牌号!"];
        return NO;
    }else if([self.postal.text isEqualToString:@""]){
        
        [MBProgressHUD showSuccess:@"请输入邮政编码!"];
        return NO;
    }else{
        
        return YES;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
