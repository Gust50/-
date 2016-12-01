//
//  CLSHHomeHeaderView.m
//  ClshUser
//
//  Created by kobe on 16/5/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHomeHeaderView.h"
#import "KBJquery.h"

@interface CLSHHomeHeaderView ()<KBJqueryDelegate>

@property(nonatomic,strong)KBJquery *kBJquery;

@end

@implementation CLSHHomeHeaderView

#pragma mark <lazyLoad>

-(KBJquery *)kBJquery{
    if (!_kBJquery) {
        _kBJquery=[[KBJquery alloc]initWithFrame:self.frame];
        _kBJquery.isWebImage=YES;
        _kBJquery.duration=5;
        _kBJquery.delegate=self;
    }
    return _kBJquery;
}

#pragma mark <init>
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self initUI];
    }
    return self;
}


#pragma mark <add UI>
-(void)initUI{
    
    [self addSubview:self.kBJquery];
}


#pragma mark <KBJqueryDelegate>
-(void)clickScrollViewPage:(KBJquery *)kBJquery index:(NSInteger)index{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickPage:)]) {
        
        [self.delegate clickPage:index];
    }
}

#pragma mark <getter setter>
-(void)setImageArray:(NSArray *)imageArray{
    
    _kBJquery.imageArray=imageArray;
}

@end
