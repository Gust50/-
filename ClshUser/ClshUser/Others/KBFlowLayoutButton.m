//
//  KBFlowLayoutButton.m
//  ClshUser
//
//  Created by Jose on 16/6/3.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBFlowLayoutButton.h"
#import "CLSHCartModel.h"
#import "CLSHNeighborhoodModel.h"

@interface KBFlowLayoutButton ()

@property (nonatomic, strong) UILabel *categoryNameLabel;        ///<分类名称
@property (nonatomic, strong) NSMutableArray *tempButton;        ///<按钮布局数组

@property (nonatomic, strong) CLSHCartSelectPropertyTypeModel *propertyModel;   ///<商品规则

@end

@implementation KBFlowLayoutButton




-(UILabel *)categoryNameLabel{
    if (!_categoryNameLabel) {
        _categoryNameLabel=[[UILabel alloc]init];
        _categoryNameLabel.frame=CGRectMake(10, 10, self.frame.size.width, 15);
        _categoryNameLabel.textColor=[UIColor blackColor];
        _categoryNameLabel.font = [UIFont systemFontOfSize:14*pro];
    }
    return _categoryNameLabel;
}


#pragma mark <init>
-(instancetype)initWithFrame:(CGRect)frame
            buttonTitleArray:(NSArray *)buttonTitleArray
{
    if (self==[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor lightGrayColor];
        self.tempButton=[NSMutableArray array];
        [self layoutButtonArr:buttonTitleArray];
        [self addSubview:self.categoryNameLabel];
    }
    return self;
}



-(instancetype)initWithFrame:(CGRect)frame
                   typeModel:(CLSHCartSelectPropertyTypeModel *)model
{
    if (self==[super initWithFrame:frame]) {
        self.tempButton=[NSMutableArray array];
        [self layoutButton:model.entries];
         [self addSubview:self.categoryNameLabel];
        self.propertyModel=model;
        _categoryNameLabel.text=model.name;
    }
    return self;
}

-(void)layoutButton:(NSArray *)propertyListModel
{
    CGFloat originX=10;
    CGFloat originY=40;
    
    for (int i=0; i<propertyListModel.count; i++)
    {
        CLSHCartSelectPropertyListModel *model=propertyListModel[i];
        NSString *str=model.value;
        model.indexPath=self.indexpath;
        
        NSDictionary *dict=[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:30] forKey:NSFontAttributeName];
        CGSize size=[str sizeWithAttributes:dict];
        
        if (originX>self.frame.size.width-20-size.width-10)
        {
            originX=10;
            originY+=30+5;
        }
        
        UIButton *btn=[[UIButton alloc]init];
        btn.frame=CGRectMake(originX, originY, size.width, 30);
        [btn setTitle:str forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14*pro];
        btn.layer.cornerRadius=8.0;
        btn.layer.masksToBounds=YES;
        btn.layer.borderColor=[UIColor clearColor].CGColor;
        btn.layer.borderWidth=0;
//        btn.backgroundColor=backGroundColor;
        btn.tag=100+i;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected]; [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        originX+=size.width+10;
        
        
        if ([model.isSelected boolValue])
        {
//            btn.selected=YES;
//            btn.backgroundColor=[UIColor redColor];
            btn.backgroundColor=RGBColor(47, 177, 95);
            [btn setTitleColor:RGBColor(255, 255, 255) forState:UIControlStateNormal];

            
        }else{
//            btn.selected=NO;
//            btn.backgroundColor=backGroundColor;
//            btn.backgroundColor=RGBColor(245, 245, 245);

            
            if ([model.canSelected boolValue])
            {
                btn.userInteractionEnabled=YES;
                
//                btn.backgroundColor=[UIColor lightGrayColor];
                btn.backgroundColor=RGBColor(245, 245, 245);
                [btn setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];

            }else
            {
                btn.userInteractionEnabled=NO;
//                btn.backgroundColor=backGroundColor;
                btn.backgroundColor=RGBColor(245, 245, 245);
                [btn setTitleColor:RGBColor(204, 205, 205) forState:UIControlStateNormal];
            }
        }
        
        
        
        [self addSubview:btn];
        [self.tempButton addObject:btn];
        
    }
    self.flowLayoutButtonHeight=originY+10+5;

}


//商家属性选择
-(instancetype)initWithFrame:(CGRect)frame merchantPropertyModel:(CLSHNeighborhoodMerchantRightGoodsListModel *)model{
    if (self==[super initWithFrame:frame]) {
        [self layoutMerchantPropertyButton:model.products];
        _merchantProperty=model;
    }
    return self;
}


-(void)layoutMerchantPropertyButton:(NSArray *)modelArr{
   
    CGFloat originX=10;
    CGFloat originY=10;
    
    for (int i=0; i<modelArr.count; i++)
    {
         CLSHNeighborhoodMerchantRightGoodsListProductsModel *model=modelArr[i];
        NSString *str=model.specification;
//        model.indexPath=self.indexpath;
        
        NSDictionary *dict=[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:18] forKey:NSFontAttributeName];
        CGSize size=[str sizeWithAttributes:dict];
        
        if (originX>self.frame.size.width-20-size.width-10)
        {
            originX=10;
            originY+=30+5;
        }
        
        UIButton *btn=[[UIButton alloc]init];
        btn.frame=CGRectMake(originX, originY, size.width, 25);
        [btn setTitle:str forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:12*pro];
        btn.layer.cornerRadius=12.5;
        btn.layer.masksToBounds=YES;
        btn.layer.borderColor=[UIColor clearColor].CGColor;
        btn.layer.borderWidth=0;
        
//        if (i==0) {
//            model.isSelect=YES;
//        }
        
        if (model.isSelect) {
             btn.backgroundColor=RGBColor(47, 177, 95);
             [btn setTitleColor:RGBColor(255, 255, 255) forState:UIControlStateNormal];
        }else{
            btn.backgroundColor=RGBColor(245, 245, 245);
            [btn setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
        }
       
        btn.tag=100+i;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickMerchantButton:) forControlEvents:UIControlEventTouchUpInside];
        originX+=size.width+10;
        
        
        [self addSubview:btn];
        [self.tempButton addObject:btn];
        
    }
    self.flowLayoutButtonHeight=originY+10+5;

}

-(void)clickMerchantButton:(UIButton *)btn{
    
    for (CLSHNeighborhoodMerchantRightGoodsListProductsModel *model in _merchantProperty.products) {
        model.isSelect=NO;
    }
    
     CLSHNeighborhoodMerchantRightGoodsListProductsModel *model=_merchantProperty.products[btn.tag-100];
    model.isSelect=YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickFlowLayoutMerchantPropertyButton:)]) {
        
        [self.delegate clickFlowLayoutMerchantPropertyButton:model];
        
    }
}




//布局按钮
-(void)layoutButtonArr:(NSArray *)buttonArr{
    
    CGFloat originX=10;
    CGFloat originY=30;
    
    [self.tempButton removeAllObjects];
    for(int i=0;i<buttonArr.count;i++){
        
//        CLSHCartSelectPropertyListModel *model
        
        NSString *str=[buttonArr objectAtIndex:i];
    
        NSDictionary *dict=[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:20] forKey:NSFontAttributeName];
        CGSize size=[str sizeWithAttributes:dict];
        
        if (originX>self.frame.size.width-20-size.width-10) {
            originX=10;
            originY+=30+5;
        }
        
        UIButton *btn=[[UIButton alloc]init];
        btn.frame=CGRectMake(originX, originY, size.width, 30);
        [btn setTitle:buttonArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        btn.titleLabel.font=[UIFont systemFontOfSize:14*pro];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        btn.layer.cornerRadius=8.0;
        btn.layer.masksToBounds=YES;
        btn.layer.borderColor=[UIColor clearColor].CGColor;
        btn.layer.borderWidth=0;
        btn.tag=100+i;
        originX+=size.width+10;
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.tempButton addObject:btn];
    }
    self.flowLayoutButtonHeight=originY+10+5;
    
}


#pragma mark <otherResponse>
-(void)clickButton:(UIButton *)button{
   
    [self cancelSelect];
    button.selected=YES;
//    button.backgroundColor=[UIColor redColor];
       button.backgroundColor=RGBColor(47, 177, 95);
    
//    for (CLSHCartSelectPropertyListModel *model in self.propertyModel.entries) {
//        
//        model.isSelected=@(NO);
//    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ClickFlowLayoutButtonModel:index:)])
    {
        
        CLSHCartSelectPropertyListModel *model=self.propertyModel.entries[button.tag-100];
        model.isSelected=@(YES);
        model.indexPath=self.indexpath;
        
        [self.delegate ClickFlowLayoutButtonModel:model index:self.indexpath];
    }

    
}

-(void)setCategoryName:(NSString *)categoryName{
    _categoryName = categoryName;
//    self.categoryNameLabel.text = categoryName;
}


-(void)cancelSelect{
    
    for (UIButton *btn in self.tempButton) {
        
        btn.selected=NO;
        btn.backgroundColor=backGroundColor;
    }
}

-(void)setIndexpath:(NSIndexPath *)indexpath{
    
    _indexpath=indexpath;
}
@end
