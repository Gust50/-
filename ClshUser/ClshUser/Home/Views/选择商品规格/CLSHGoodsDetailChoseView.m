//
//  CLSHGoodsDetailChoseView.m
//  ClshUser
//
//  Created by kobe on 16/6/15.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHGoodsDetailChoseView.h"
#import "CLSHGoodsDetailChoseCell.h"
#import "KBFlowLayoutButton.h"
#import "CLSHCartModel.h"
#import "CLSHGoodBuyCountChoseView.h"
#import "CLSHHomeProductDetailModel.h"

@interface CLSHGoodsDetailChoseView ()<UITableViewDelegate,UITableViewDataSource,CLSHGoodsDetailChoseCellDelegate,CLSHGoodBuyCountChoseViewDelegate>

{
    CLSHCartSelectPropertyModel *cLSHCartSelectPropertyModel;   ///<选择规格数据模型
    NSMutableDictionary *propertyParams;        ///<传入参数
    
    NSMutableArray *propertyIdArr;      ///<选中所有规格数组
    NSString *propertyStr;  ///<选中所有规格数组拼接成字符串
    
    CLSHGoodBuyCountChoseView *goodBuyCountChoseView;   ///<商品购买数量视图
     NSMutableDictionary *returnPropertyParams;        ///<返回商品规格参数
    NSString *shoppingCountNumber;  ///<设置全局商品数量
    NSMutableDictionary *params;    ///<传入商品ID和选择规格ID
    
    NSMutableArray *propertySize;
    NSString *propertyString;
}

@property (nonatomic, strong) UIView *alphaView;     ///<半透明背景图
@property (nonatomic, strong) UIView *backGroundView;    ///<装载视图的背景
@property (nonatomic, strong) UIImageView *shopIcon;     ///<商品图片
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *confirmButton;   ///<确定按钮
@property (nonatomic, strong) UIButton *cancelButton;   ///<取消按钮
@property (nonatomic, strong) UILabel *shopPrice;   ///<商品价格
@property (nonatomic, strong) UILabel *inventoryCount;   ///<库存

@property (nonatomic, strong) NSArray *dataSoure;    ///<规则数组
@property (nonatomic, strong) NSMutableArray *saveModel;         ///<保存的模型

@end

@implementation CLSHGoodsDetailChoseView

static NSString *const goodsDetailChoseCellID = @"CLSHGoodsDetailChoseCell";


#pragma mark <lazyLoad>
-(NSMutableArray *)saveModel{
    if (!_saveModel) {
        _saveModel=[NSMutableArray array];
    }
    return _saveModel;
}
-(NSArray *)dataSoure{
    
    if (!_dataSoure) {
        _dataSoure=[NSArray array];
    }
    return _dataSoure;
}

-(UIView *)alphaView{
    if (!_alphaView) {
        _alphaView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _alphaView.backgroundColor=[UIColor blackColor];
        _alphaView.alpha=0.2;
    }
    return _alphaView;
}

-(UIView *)backGroundView{
    if (!_backGroundView) {
        _backGroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 200*pro, self.frame.size.width, self.frame.size.height-200*pro)];
        _backGroundView.backgroundColor=[UIColor whiteColor];
    }
    return _backGroundView;
}

-(UIImageView *)shopIcon{
    if (!_shopIcon) {
        _shopIcon=[[UIImageView alloc]initWithFrame:CGRectMake(10, -20, 100, 100)];
        _shopIcon.layer.cornerRadius = 4;
        _shopIcon.layer.borderColor = [UIColor whiteColor].CGColor;
        _shopIcon.layer.borderWidth = 5;
        [_shopIcon.layer setMasksToBounds:YES];
        _shopIcon.image = [UIImage imageNamed:@"ShopIcon"];
    }
    return _shopIcon;
}

-(UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton=[[UIButton alloc]init];
        _confirmButton.frame=CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 40);
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:16*pro];
        _confirmButton.backgroundColor=systemColor;
    }
    return _confirmButton;
}

-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton=[[UIButton alloc]init];
        _cancelButton.frame = CGRectMake(SCREENWIDTH-40, 0, 30, 30);
        [_cancelButton setImage:[UIImage imageNamed:@"Close"] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cancelButton;
}

-(UILabel *)shopPrice
{
    if (!_shopPrice) {
        _shopPrice = [[UILabel alloc] init];
        _shopPrice.textColor = [UIColor redColor];
        _shopPrice.frame = CGRectMake(120, 25, SCREENWIDTH-130, 20);
        _shopPrice.font = [UIFont systemFontOfSize:14*pro];
        _shopPrice.text = @"45";
        NSString *shopPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:[_shopPrice.text floatValue]]];
        _shopPrice.text = shopPriceStr;
    }
    return _shopPrice;
}

-(UILabel *)inventoryCount
{
    if (!_inventoryCount) {
        _inventoryCount = [[UILabel alloc] init];
        _inventoryCount.frame = CGRectMake(120, 50, SCREENWIDTH-130, 20);
        _inventoryCount.text = @"库存168件";
        _inventoryCount.font = [UIFont systemFontOfSize:12*pro];
    }
    return _inventoryCount;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 100, self.frame.size.width, self.frame.size.height-100-40) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator=NO;
    }
    return _tableView;
}


#pragma mark <init>
-(instancetype)initWithFrame:(CGRect)frame
                  shoppingID:(NSString *)shoppingID
{
    if (self==[super initWithFrame:frame])
    {
        self.backgroundColor = RGBColor(47, 177, 95);
        [self initUI];
        
        cLSHCartSelectPropertyModel=[[CLSHCartSelectPropertyModel alloc]init];
        
        //注册cell
        [self.tableView registerClass:[CLSHGoodsDetailChoseCell class] forCellReuseIdentifier:goodsDetailChoseCellID];
         params[@"goodsId"] = shoppingID;
        [self loadData];
    }
    return self;
}

#pragma mark - loadData
-(void)loadData{
    
    //判断是否登录
    if (![FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin)
    {
        [cLSHCartSelectPropertyModel fetchCartSelectPropertyData:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                
                cLSHCartSelectPropertyModel=result;
                _dataSoure=cLSHCartSelectPropertyModel.specifications;
                
                [self.tableView reloadData];
            }else
            {
//                [MBProgressHUD showError:result];
            }
        }];
    }else
    {
        
        [cLSHCartSelectPropertyModel fetchCartSelectPropertyLoginData:params callBack:^(BOOL isSuccess, id result) {
            
            if (isSuccess) {
                cLSHCartSelectPropertyModel=result;
                _dataSoure=cLSHCartSelectPropertyModel.specifications;
                [self.tableView reloadData];
            }else
            {
//                [MBProgressHUD showError:result];
            }

        }];
    }
}

#pragma marK <UI>
-(void)initUI{
    
//    [self addSubview:self.alphaView];
    
    propertyParams=[NSMutableDictionary dictionary];
    returnPropertyParams=[NSMutableDictionary dictionary];
    propertyIdArr=[NSMutableArray array];
    propertySize=[NSMutableArray array];
    params=[NSMutableDictionary dictionary];
    
    [self addSubview:self.backGroundView];
    [self addSubview:self.shopIcon];
    [self addSubview:self.confirmButton];
    [self addSubview:self.tableView];
    [self addSubview:self.cancelButton];
    [self addSubview:self.shopPrice];
    [self addSubview:self.inventoryCount];
   
}


#pragma mark <TableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_isShowProperty) {
        return _dataSoure.count;
        
    }else{
        return 0;
    }
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isShowProperty) {
        return 1;
        
    }else{
        return 0;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isShowProperty)
    {
    
        CLSHGoodsDetailChoseCell *goodsDetailChoseCell;
        goodsDetailChoseCell=[[CLSHGoodsDetailChoseCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsDetailChoseCellID propertyTypeModel:_dataSoure[indexPath.section]];
        goodsDetailChoseCell.selectionStyle=UITableViewCellSelectionStyleNone;
        goodsDetailChoseCell.indexPath=indexPath;
        goodsDetailChoseCell.delegate=self;
        return goodsDetailChoseCell;
    }
    
    return nil;
}

#pragma mark <TalbleViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_isShowProperty)
    {
        return 2;
    }else
    {
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isShowProperty)
    {
        
        KBFlowLayoutButton *flowLayout=[[KBFlowLayoutButton alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50) typeModel:_dataSoure[indexPath.section]];
        
        return  flowLayout.flowLayoutButtonHeight+20;
       
    }else
    {
         return 0;
    }
}

#pragma mark <CLSHGoodsDetailChoseCellDelegate>
-(void)selectProperty:(CLSHCartSelectPropertyListModel *)typeModel indexPath:(NSIndexPath *)indexPath
{
    
    NSString *key=[NSString stringWithFormat:@"%ld",indexPath.section];
    propertyParams[key]=typeModel;
    
    [self caculatorKey:propertyParams];
    [self loadData];
}

#pragma makr <OtherResponse>

//取消
-(void)cancelSelectButton:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelSelect)]) {
        
        [self.delegate cancelSelect];
    }
}
//确认
-(void)confirmSelectButton:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmSelect:isAddCart:)])
    {
        if (_isShowProperty) {
            
            if (cLSHCartSelectPropertyModel.selectedProductId.length == 0 && cLSHCartSelectPropertyModel.selectedProductId == nil )
            {
                [MBProgressHUD showError:@"请选择商品规格"];
            }else
            {
                NSMutableDictionary *tempDict=[NSMutableDictionary dictionary];
                
                tempDict[@"selectedProductId"]=cLSHCartSelectPropertyModel.selectedProductId;
                tempDict[@"property"]=propertyString;
                
                if (shoppingCountNumber.length == 0 && shoppingCountNumber == nil)
                {
                    //如果没有选商品数量，默认为1
                    tempDict[@"Count"]=@"1";
                    [self.delegate confirmSelect:tempDict isAddCart:_isAddCart];
                }else
                {
                    tempDict[@"Count"]=shoppingCountNumber;
                    [self.delegate confirmSelect:tempDict isAddCart:_isAddCart];
                }
            }
        }else
        {
            NSMutableDictionary *tempDict=[NSMutableDictionary dictionary];
            
            if (shoppingCountNumber.length==0 && shoppingCountNumber==nil)
            {
                tempDict[@"Count"] = @"1";
                tempDict[@"property"]=propertyString;
                [self.delegate confirmSelect:tempDict isAddCart:_isAddCart];
            }else
            {
                tempDict[@"property"]=propertyString;
                tempDict[@"Count"] = shoppingCountNumber;
                [self.delegate confirmSelect:tempDict isAddCart:_isAddCart];

            }
        }
    }
}
//计算商品规格ID和所选的规格
-(void)caculatorKey:(NSDictionary *)dict{
    
    NSArray *keyArr=[dict allValues];
    [propertyIdArr removeAllObjects];
    [propertySize removeAllObjects];
    
    for (CLSHCartSelectPropertyListModel *model in keyArr) {
        
        [propertyIdArr addObject:model.typeID];
        [propertySize addObject:model.value];
    }
    //数组拼接字符串
    propertyStr = [propertyIdArr componentsJoinedByString:@","];
    //商品规格属性
    propertyString=[propertySize componentsJoinedByString:@"/"];
    params[@"selectedIds"] = propertyStr;
    
}

#pragma mark <getter setter>
//是否显示商品属性规格
-(void)setIsShowProperty:(BOOL)isShowProperty{
    
    _isShowProperty=isShowProperty;
    
    if (isShowProperty) {
        _tableView.scrollEnabled=YES;
        goodBuyCountChoseView = [[CLSHGoodBuyCountChoseView alloc] initWithFrame:CGRectMake(0, 20*pro, SCREENWIDTH, 60*pro)];
        goodBuyCountChoseView.delegate=self;
    }else{
        _tableView.scrollEnabled=NO;
        goodBuyCountChoseView = [[CLSHGoodBuyCountChoseView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60*pro)];
        goodBuyCountChoseView.delegate=self;
    }
    self.tableView.tableFooterView = goodBuyCountChoseView;
    goodBuyCountChoseView.maxNumber = [_productGoodsDetailModel.stock integerValue];
     [self.tableView reloadData];
    
}

//传入价格和库存
-(void)setProductGoodsDetailModel:(CLSHHomeProductGoodsDetailModel *)productGoodsDetailModel
{
    _productGoodsDetailModel = productGoodsDetailModel;
    NSString *shopPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:productGoodsDetailModel.price]];
    _shopPrice.text = shopPriceStr;
    [_shopIcon sd_setImageWithURL:[NSURL URLWithString:productGoodsDetailModel.productImages[0]] placeholderImage:nil];
    
    _inventoryCount.text = [NSString stringWithFormat:@"库存%ld件", [productGoodsDetailModel.stock integerValue]];
}

//商品数量
-(void)changeShoppingNumbers:(NSString *)number{
    
    shoppingCountNumber=number;
}

//商品ID
-(void)setShopID:(NSString *)shopID
{
    _shopID = shopID;
    
}
-(void)setIsAddCart:(BOOL)isAddCart{
    _isAddCart=isAddCart;
}

@end
