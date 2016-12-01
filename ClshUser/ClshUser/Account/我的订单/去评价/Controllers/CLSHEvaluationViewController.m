//
//  CLSHEvaluationViewController.m
//  ClshUser
//
//  Created by arom on 16/6/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHEvaluationViewController.h"
#import "CLSHAccountOrderModel.h"
#import "CLSHEvaluationTableViewCell.h"
#import "PhotoViewController.h"
//#import "SelectedCell.h"
#import "UINavigationBar+Awesome.h"
#import "KBCustomPhotoCollectionViewController.h"
#import "CLSHFactoryEvaluationTableViewCell.h"
#import "CLSHAccountCorrectModel.h"


@interface CLSHEvaluationViewController ()<UITableViewDelegate,UITableViewDataSource,KBCustomPhotoCollectionViewControllerDelegate>{

    CLSHAccountOrderDetailModel * detailModel;
    CLSHAccountOrderDetailListModel * detailListModel;
    CLSHAccountOrderDetailOneModel * detailOneModel;
    CLSHIconUploadModel *cLSHIconUploadModel;
    CLSHFactoryRemarkModel *cLSHFactoryRemarkModel;
    CLSHMerchantRemarkModel *cLSHMerchantRemarkModel;
    
    NSMutableDictionary * reloadDict ;
    NSInteger section;   //点击的section
}

@property (nonatomic,strong)NSMutableArray * imgArr;

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSArray * dataArray;

@property (nonatomic,strong)UIView * bottomView;
@property (nonatomic,strong)UIButton * application;

@property (nonatomic, assign) NSIndexPath *indexPath; ///<section
@property (nonatomic, assign) BOOL isUpLoad;          ///<上传
@end

@implementation CLSHEvaluationViewController

static NSString  * const ID = @"cellId";
static NSString  * const FactoryID = @"FactoryID";

#pragma mark lazyload
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-40) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (UIView *)bottomView{

    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-40, SCREENWIDTH, 40)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

- (UIButton *)application{

    if (!_application) {
        _application = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-100, 0, 100, 40)];
        _application.backgroundColor = systemColor;
        [_application setTitle:@"发表评论" forState:(UIControlStateNormal)];
        [_application setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _application.titleLabel.font = [UIFont systemFontOfSize:16];
        [_application addTarget:self action:@selector(submitAssessment) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _application;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品评价";
    self.view.backgroundColor = backGroundColor;
    
    
    cLSHIconUploadModel=[[CLSHIconUploadModel alloc]init];
    cLSHFactoryRemarkModel=[[CLSHFactoryRemarkModel alloc]init];
    cLSHMerchantRemarkModel=[[CLSHMerchantRemarkModel alloc]init];
    
    self.imgArr = [NSMutableArray array];
   
    [self.tableView registerClass:[CLSHEvaluationTableViewCell class] forCellReuseIdentifier:ID];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [_bottomView addSubview:self.application];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    detailOneModel=[[CLSHAccountOrderDetailOneModel alloc]init];
    detailListModel = [[CLSHAccountOrderDetailListModel alloc] init];
    detailModel=[[CLSHAccountOrderDetailModel  alloc]init];
//    [detailOneModel.imgArr removeAllObjects];
    
     [self loadData];
}

- (void)loadData{

    
    NSMutableDictionary * needsParams = [NSMutableDictionary dictionary];
    needsParams[@"sn"] = _sn;
    [detailModel fetchAccountOrderDetailData:needsParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            
            detailModel = result;
            detailListModel = detailModel.order;
            self.dataArray = detailListModel.orderItems;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark table view delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 250* pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    CLSHEvaluationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    CLSHFactoryEvaluationTableViewCell * FactotyCell = [tableView dequeueReusableCellWithIdentifier:FactoryID];
    if(_isBussiness){
    
        if (!cell) {
            cell = [[CLSHEvaluationTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        detailOneModel = _dataArray[indexPath.section];
        cell.model = detailOneModel;
        cell.indexPath=indexPath;
        cell.commentTextBlock=^(NSString *content){
            detailOneModel.contentText=content;
        };
        //    cell.scrollview.contentSize = CGSizeMake(70*pro*(_imgArr.count), 70*pro);
        //
        //
        //
        //    for (int i = 0; i<detailOneModel.imgArr.count; i++) {
        //        UIImage * image = [[UIImage alloc] init];
        //        image = detailOneModel.imgArr[i];
        //        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(70*pro*i+8*i*pro, 5*pro, 70*pro, 70*pro)];
        //        imageView.image = image;
        //        imageView.userInteractionEnabled = YES;
        //        UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(imageView.width-15*pro, 0*pro, 15*pro, 15*pro)];
        //        deleteBtn.tag = i + 1;
        //        [deleteBtn setImage:[UIImage imageNamed:@"DeleteIconRed"] forState:UIControlStateNormal];
        //        [deleteBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        //        [imageView addSubview:deleteBtn];
        //
        //        [cell.scrollview addSubview:imageView];
        //    }
        
        cell.delectImageBlock=^(NSIndexPath *index,NSInteger tag){
            
            [self deleteImage:indexPath tag:tag];
        };
        
        cell.camerablock = ^(){
            //照相机上传
            //        [self goCamera];
            [self selectPhoto:indexPath];
            //        section = indexPath.section;
            
        };
        cell.goodCommentblock= ^(){
            
            NSLog(@"dsfsf");
            cell.goodComment.selected = YES;
            cell.middleComment.selected = NO;
            cell.badComment.selected = NO;
            
            //好评
            if (cell.goodComment.selected) {
                
                detailOneModel.rate=5;
            }
        };
        
        cell.middleCommentblock = ^(){
            
            cell.middleComment.selected = YES;
            cell.goodComment.selected = NO;
            cell.badComment.selected = NO;
            
            //中评
            if (cell.middleComment.selected) {
                 detailOneModel.rate=3;
            }
        };
        
        cell.badCommentblock = ^(){
            
            cell.badComment.selected = YES;
            cell.goodComment.selected = NO;
            cell.middleComment.selected = NO;
            //差评
            if (cell.badComment.selected) {
                 detailOneModel.rate=1;
            }
            
        };
        
        return cell;
    }else{
    
        if (!FactotyCell) {
            FactotyCell = [[CLSHFactoryEvaluationTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:FactoryID];
        }
        FactotyCell.backgroundColor = [UIColor whiteColor];
        FactotyCell.selectionStyle = UITableViewCellSelectionStyleNone;
        CLSHAccountOrderDetailOneModel  *orderModel=_dataArray[indexPath.section];
        
//        detailOneModel = _dataArray[indexPath.section];
        FactotyCell.model = orderModel;
        FactotyCell.indexPath=indexPath;
        
        FactotyCell.delectImageBlock=^(NSIndexPath *index,NSInteger tag){
            
            [self deleteImage:indexPath tag:tag];
        };
        
        FactotyCell.camerablock = ^(){
            //照相机上传
            //        [self goCamera];
            [self selectPhoto:indexPath];
            //        section = indexPath.section;
            
        };
        
        orderModel.rate=1;
        FactotyCell.startRateBlock=^(NSInteger score){
             orderModel.rate=score;
        };
        FactotyCell.commentTextBlock=^(NSString *content){
             orderModel.contentText=content;
        };
        
        return FactotyCell;
    }
    
}

-(void)selectPhoto:(NSIndexPath *)indexpath{
    
    KBCustomPhotoCollectionViewController *photo=[[KBCustomPhotoCollectionViewController alloc]init];
    photo.allowsMultipleSelection=YES;
    photo.maxNumber=4;
    photo.delegate=self;
    
    self.indexPath=indexpath;
    [self.navigationController pushViewController:photo animated:YES];
}

//添加图片
//- (void)goCamera{
//
//    
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择图片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    
//    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        PhotoViewController * photo = [[PhotoViewController alloc]init];
//        
//        photo.popSelectArr = ^(NSMutableDictionary*dict ){
//            if (detailOneModel.imgArr.count == 0) {
//                detailOneModel.imgArr = [dict objectForKey:@"arr"];
//                
//            }else
//            {
//                CLSHAccountOrderDetailOneModel *model = [[CLSHAccountOrderDetailOneModel alloc] init];
//                model.imgArr = [dict objectForKey:@"arr"];
//                for (int i = 0; i < model.imgArr.count; i++) {
//                    [detailOneModel.imgArr addObject:model.imgArr[i]];
//                }
//            }
//            
//            NSInteger sec;
//            sec = [dict[@"sec"] integerValue];
//           // reloadDict[dict[@"sec"]]= [dict objectForKey:@"arr"];
//            
//            CLSHEvaluationTableViewCell * cell =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:sec]];
//            cell.model = detailOneModel;
//            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:sec];
//            [self.tableView reloadSections:indexSet withRowAnimation:(UITableViewRowAnimationFade)];
//            
//        };
//        
//        photo.sec = section;
//        [self.navigationController pushViewController:photo animated:NO];
//        
//    }];
//    
//    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        NSLog(@"相机没写");
//        
//    }];
//    
//    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    
//    [alert addAction: action1];
//    [alert addAction: action2];
//    [alert addAction: action3];
//    
//    [self presentViewController:alert animated:NO completion:nil];
//}

//删除图片
- (void)deleteImage:(NSIndexPath *)indexPath tag:(NSInteger)tag
{
    CLSHAccountOrderDetailOneModel *model= detailOneModel=_dataArray[indexPath.section];
    NSMutableArray *tempArr=[NSMutableArray arrayWithArray:model.imgArr];
    CLSHAccountOrderDetailOneModel *temp=tempArr[tag-1];
    [tempArr removeObject:temp];
    
    model.imgArr=[NSMutableArray arrayWithArray:tempArr];
    
   
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];

}


#pragma mark <KBCustomPhotoCollectionViewControllerDelegate>
-(void)KBPhotoUpLoadImages:(NSArray *)images imageBaseStringArr:(NSArray *)imgStringArr{
    
    CLSHAccountOrderDetailOneModel *model = [[CLSHAccountOrderDetailOneModel alloc] init];
    model=_dataArray[self.indexPath.section];
    [model.imgArr removeAllObjects];
    if (images.count == 0) {
        model.imgArr = nil;
        model.upLoadImgStirng = nil;
    }else{
        model.imgArr=[NSMutableArray arrayWithArray:images];
        model.upLoadImgStirng=[NSMutableArray arrayWithArray:imgStringArr];
    }
   
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:_indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)KBPhotoUpLoadUserIcon:(UIImage *)image imageBaseString:(NSString *)baseString{
    
}

#pragma mark 提交评论
- (void)submitAssessment{
    
    //rubblish
    if ([self isValidateSuccess]) {
        
        
        
        if (_isBussiness) {
            
            if (self.isUpLoad) {
                [self upLoadMerchant];
            }else{
                [self concurrentThread];
            }
        }else{
            
            if (self.isUpLoad) {
                [self upLoad];
            }else{
                [self concurrentThread];
            }
        }
    }else{

        [MBProgressHUD showError:@"请输入完整信息"];
    }
}

//并发处理
-(void)concurrentThread{
    // 合并汇总结果
    dispatch_group_t group = dispatch_group_create();
    
    for (int i=0; i<_dataArray.count; i++) {
        CLSHAccountOrderDetailOneModel *tempModel=_dataArray[i];
        for (int j=0; j<tempModel.upLoadImgStirng.count;j++) {
            NSMutableDictionary *tempParams=[NSMutableDictionary dictionary];
            tempParams[@"fileType"]=@"image";
            tempParams[@"fileName"]=[NSString stringWithFormat:@"%d%d.jpg",i,j];
            tempParams[@"base64Data"]=tempModel.upLoadImgStirng[j];
            
            dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
                // 并行执行
                [self upLoadImage:tempParams indexPath:i];
                NSLog(@"并发执行中>>>>>>>>>>>>>>>>>>>>>>>>>>");
            });
        }
    }
    
    
    dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
        // 汇总结果
        self.isUpLoad=YES;

//
        dispatch_async(dispatch_get_main_queue(), ^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)10*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@">>>>>>>>>>>>>>>>");
                [self submitAssessment];
            });
            
            UIViewController *pop=self.navigationController.childViewControllers[1];
            
            [self.navigationController popToViewController:pop animated:YES];
           
        });
        
    });
    
    
    
}



-(void)upLoadMerchant{
    NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
    
    CLSHAccountOrderDetailOneModel *model=[[CLSHAccountOrderDetailOneModel alloc]init];
    model=_dataArray[0];
    
    needParams[@"images"]=model.returnImageUrl;
    needParams[@"sn"]=_sn;
    needParams[@"content"]=model.contentText;
    
    if (model.rate) {
         needParams[@"score"]=@(model.rate);
    }else{
         needParams[@"score"]=@(5);
    }
   
    
    [cLSHMerchantRemarkModel fetchMerchantRemarkModelData:needParams callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            [MBProgressHUD showSuccess:@"评论成功"];
        }else{
            
            [MBProgressHUD showError:@"评论失败"];
        }
    }];
}

-(void)upLoad{
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
    needParams[@"reviews"]=[self caculatorUpData];
    needParams[@"sn"]=_sn;
    
    [cLSHFactoryRemarkModel fetchFactoryRemarkModelData:needParams callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            [MBProgressHUD showSuccess:@"评论成功"];
        }else{
            
            [MBProgressHUD showError:@"评论失败"];
        }
    }];

}

//验证
-(BOOL)isValidateSuccess{
    
    
    BOOL isSuccess=YES;
    
    for (CLSHAccountOrderDetailOneModel *model in _dataArray) {
        
        if (model.contentText.length==0) {
            isSuccess=NO;
            break;
        }else{
            isSuccess=YES;
            continue;
        }
    }
    return isSuccess;
}


//计算上传的数据
-(NSArray *)caculatorUpData{
    
    NSMutableArray *temp=[NSMutableArray array];
    
    for (CLSHAccountOrderDetailOneModel *model in _dataArray) {
        
        NSMutableDictionary *tempDict=[NSMutableDictionary dictionary];
        tempDict[@"goodsId"]=model.goodsId;
        tempDict[@"content"]=model.contentText;
        tempDict[@"score"]=@(model.rate);
        tempDict[@"images"]=model.returnImageUrl;
        
        [temp addObject:tempDict];
    }
    
    return [temp copy];
}


//上传图片
-(void)upLoadImage:(NSDictionary *)params indexPath:(NSInteger)index{
    
    
    
    [cLSHIconUploadModel fetchAccountIconUploadModel:params callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            
            cLSHIconUploadModel=result;
            CLSHAccountOrderDetailOneModel *tempModel=_dataArray[index];
            NSMutableArray *tempArr=[NSMutableArray arrayWithArray:tempModel.returnImageUrl];
            [tempArr addObject:cLSHIconUploadModel.url];
            tempModel.returnImageUrl=[NSMutableArray arrayWithArray:tempArr];
            [MBProgressHUD showSuccess:@"上传成功!"];

            
        }else{
            
            [MBProgressHUD showError:@"上传失败!"];
        }
    }];
}


-(void)setIsBussiness:(BOOL)isBussiness{
    _isBussiness=isBussiness;
}
@end
