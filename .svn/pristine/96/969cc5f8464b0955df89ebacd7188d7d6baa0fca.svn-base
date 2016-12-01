//
//  KBJqueryScrollView.m
//  ClshUser
//
//  Created by kobe on 16/5/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBJqueryScrollView.h"
#import "Masonry.h"

@interface KBJqueryScrollView()<UIScrollViewDelegate>{

    UIPageControl * _pageControll;
}


@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation KBJqueryScrollView


-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]init];
        _scrollView.pagingEnabled=YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator=NO;
    }
    return _scrollView;
}



-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.scrollView];
    [self updateConstraints];
}




-(void)setImageArr:(NSArray *)imageArr{
    _imageArr=imageArr;
    
    _scrollView.contentSize = CGSizeMake(SCREENWIDTH*imageArr.count, self.frame.size.height);
    for (int i=0; i<imageArr.count; i++) {
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH*i, 0, SCREENWIDTH, self.frame.size.height)];
//        imageView.image=[UIImage imageNamed:imageArr[i]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageArr[i]] placeholderImage:nil];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:imageView];
    }
    
    [self addPageController];
}


-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    int i=0;
    for (UIImageView *imageView in _scrollView.subviews) {
        
        if ([imageView isKindOfClass:[UIImageView class]]) {
            
            imageView.frame=CGRectMake(self.frame.size.width*i, 0, SCREENWIDTH, self.frame.size.height);
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            i++;
        }
    }
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        
    }];
}

//创建分页控制器
- (void)addPageController{
    
    _pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-30, SCREENWIDTH, 20)];
    _pageControll.numberOfPages = _imageArr.count;
    _pageControll.currentPage = 0;
    _pageControll.currentPageIndicatorTintColor = [UIColor colorWithWhite:0.4 alpha:0.6];
    _pageControll.pageIndicatorTintColor = [UIColor whiteColor];
    [_pageControll addTarget:self action:@selector(pageChanged) forControlEvents:(UIControlEventValueChanged)];
    if (_imageArr.count > 1) {
        [self addSubview:_pageControll];
    }
}

- (void)pageChanged{
    
    [_scrollView setContentOffset:CGPointMake(_pageControll.currentPage * SCREENWIDTH, 0) animated:YES];
}

#pragma mark delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float page = scrollView.contentOffset.x/SCREENWIDTH+0.5;
    _pageControll.currentPage = page;
}

@end
