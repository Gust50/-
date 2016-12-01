//
//  KBSearchBar.h
//  ClshUser
//
//  Created by kobe on 16/5/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  KBSearchBarDelegate<NSObject>

@optional

-(void)fetchSearchTextContent:(NSString *)textContent;
-(void)cancelSearch;


@end

@interface KBSearchBar : UIView

@property(nonatomic,weak)id<KBSearchBarDelegate>delegate;

@property(nonatomic,strong)UISearchBar *searchBar;
@end
