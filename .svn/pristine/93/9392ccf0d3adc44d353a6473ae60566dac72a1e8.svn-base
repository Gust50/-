//
//  CLSHGoodsDetailChoseCell.m
//  ClshUser
//
//  Created by kobe on 16/6/15.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHGoodsDetailChoseCell.h"
#import "KBFlowLayoutButton.h"
#import "CLSHCartModel.h"


@interface CLSHGoodsDetailChoseCell ()<KBFlowLayoutButtonDelegate>

{
    KBFlowLayoutButton *button;
}

@end
@implementation CLSHGoodsDetailChoseCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier buttonArr:(NSArray *)array{
    
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
       KBFlowLayoutButton *flowLayoutButton = [[KBFlowLayoutButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50) buttonTitleArray:array];
        
       button=[[KBFlowLayoutButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-10, (flowLayoutButton.flowLayoutButtonHeight+20)) buttonTitleArray:array];
        button.indexpath=self.indexPath;
        [self addSubview:button];
        button.delegate = self;
        
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
           propertyTypeModel:(CLSHCartSelectPropertyTypeModel *)model
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        KBFlowLayoutButton *flowLayoutButton=[[KBFlowLayoutButton alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,50 ) typeModel:model];
        
        button=[[KBFlowLayoutButton alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, (flowLayoutButton.flowLayoutButtonHeight+20)) typeModel:model];
        [self addSubview:button];
        button.delegate=self;
    }
    return self;
}

-(void)ClickFlowLayoutButton:(NSInteger)index index:(NSIndexPath *)indexPath
{
    NSLog(@"111");
}

-(void)ClickFlowLayoutButtonModel:(CLSHCartSelectPropertyListModel *)model index:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectProperty:indexPath:)]) {
        
        [self.delegate selectProperty:model indexPath:indexPath];
    }
}

//setter getter
-(void)setCategoryName:(NSString *)categoryName
{
    _categoryName = categoryName;
    button.categoryName = categoryName;
}


-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath=indexPath;
    button.indexpath=self.indexPath;
}
@end
