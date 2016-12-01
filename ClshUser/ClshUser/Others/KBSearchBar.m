//
//  KBSearchBar.m
//  ClshUser
//
//  Created by kobe on 16/5/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBSearchBar.h"
#import "Masonry.h"

@interface KBSearchBar()<UISearchBarDelegate>

@property(nonatomic,strong)UIButton *cancelButton;

@end

@implementation KBSearchBar


-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar=[[UISearchBar alloc]init];
        _searchBar.delegate=self;
        
//        _searchBar.showsCancelButton=YES;
    }
    return _searchBar;
}

-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton=[[UIButton alloc]init];
        _cancelButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_cancelButton setTitle:@"搜索" forState:UIControlStateNormal];
        _cancelButton.backgroundColor=[UIColor whiteColor];
        _cancelButton.layer.cornerRadius = 5.0;
        _cancelButton.layer.masksToBounds = YES;
        [_cancelButton setTitleColor:systemColor forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelSearch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = RGBColor(201, 201, 206);
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.searchBar];
    [self addSubview:self.cancelButton];
    [self updateConstraints];
}

#pragma mark <UISearchBarDelegate>
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(fetchSearchTextContent:)]) {
        
        [self.delegate fetchSearchTextContent:searchText];
    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //
}

#pragma mark <otherResponse>
-(void)cancelSearch:(UIButton *)button{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelSearch:)]) {
        
        [self.delegate cancelSearch];
    }
}

-(void)updateConstraints{
    
    [super updateConstraints];
    WS(weakSelf);
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(5);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-5);
        make.width.mas_equalTo(@(50));
    }];
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.right.equalTo(_cancelButton.mas_left);
    }];
    
}

@end
