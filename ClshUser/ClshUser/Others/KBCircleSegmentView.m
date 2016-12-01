//
//  KBCircleSegmentView.m
//  ClshUser
//
//  Created by kobe on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBCircleSegmentView.h"

#define kMargin 20
#define kLeftMargin 10
#define kRightMargin 10

@interface KBCircleSegmentView()

/** 创建好的按钮放入数组中 */
@property(nonatomic,strong)NSMutableArray *btnSource;
/** 按钮的tag */
@property(nonatomic,assign)NSInteger selectBtnTag;

@end


@implementation KBCircleSegmentView

#pragma mark <lazyLoad>
-(NSMutableArray *)btnSource{
    if (!_btnSource) {
        _btnSource=[NSMutableArray array];
    }
    return _btnSource;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self==[super initWithFrame:frame]) {
        
         self.selectBtnTag=0;
    }
    return self;
}


+(KBCircleSegmentView *)createCircleSegmentFrame:(CGRect)frame
                                        titleArr:(NSArray *)titleArr
                                      titleColor:(UIColor *)titleColor
                                selectTitleColor:(UIColor *)selectTitleColor
                                       titleFont:(UIFont *)titleFont
                                    unselectIcon:(NSArray *)unselectIcon
                                      selectIcon:(NSArray *)selectIcon
                                 backgroundColor:(UIColor *)backgroundColor
                                        delegate:(id)delegate
{
    
    KBCircleSegmentView *kBCircleSegmentView=[[KBCircleSegmentView alloc]initWithFrame:frame];
    kBCircleSegmentView.delegate=delegate;
    kBCircleSegmentView.titleColor=titleColor;
    kBCircleSegmentView.titleFont=titleFont;
    kBCircleSegmentView.selectTitleColor=selectTitleColor;
    kBCircleSegmentView.backgroundColor=backgroundColor;
    [kBCircleSegmentView createButtonTitleArr:titleArr unselectIcon:unselectIcon selectIcon:selectIcon];
    
    return kBCircleSegmentView;
}

-(void)createButtonTitleArr:(NSArray *)titleArr
               unselectIcon:(NSArray *)unselectIcon
                 selectIcon:(NSArray *)selectIcon
{
    
    CGFloat btnW=((SCREENWIDTH-kRightMargin-kLeftMargin)-(kMargin*(titleArr.count-1)))/titleArr.count;
    CGFloat btnH=self.bounds.size.height/2;
    
    for (int i=0; i<titleArr.count; i++) {
        UIButton *btn=[[UIButton alloc]init];
        btn.tag=i+1;
        btn.titleLabel.font=self.titleFont;
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectTitleColor forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:unselectIcon[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selectIcon[i]] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectSegmentButton:) forControlEvents:UIControlEventTouchUpInside];

        btn.layer.cornerRadius=self.frame.size.height/4.6;
        btn.layer.borderColor=systemColor.CGColor;
        btn.layer.borderWidth=1;
        btn.layer.masksToBounds=YES;
        btn.imageEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 0);
//        btn.titleEdgeInsets=UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
        
        if (i==0) {
             btn.frame=CGRectMake(kLeftMargin+btnW*i, self.bounds.size.height/4, btnW, btnH);
             btn.backgroundColor=systemColor;
        }else{
            btn.frame=CGRectMake(kLeftMargin+(kMargin+btnW)*i, self.bounds.size.height/4, btnW, btnH);
        }
        
        [self addSubview:btn];
        [self.btnSource addObject:btn];
    }
    
    //选中第一个
    [[self.btnSource firstObject]setSelected:YES];
}

#pragma mark <otherResponse>
-(void)selectSegmentButton:(UIButton *)button{
    if (self.selectBtnTag!=button.tag-1) {
        
        for (UIButton *btn in self.btnSource) {
            btn.selected=NO;
            btn.backgroundColor=[UIColor whiteColor];
        }
        
        [self.btnSource[button.tag-1] setSelected:YES];
        [self.btnSource[button.tag-1] setBackgroundColor:systemColor];
    
        self.selectBtnTag=button.tag-1;
        //代理
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectCircleSegment:)]) {
            [self.delegate selectCircleSegment:button.tag-1];
        }
    }
    
}

@end
