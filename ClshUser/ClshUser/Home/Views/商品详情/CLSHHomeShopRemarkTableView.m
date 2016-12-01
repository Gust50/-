//
//  CLSHHomeShopRemarkTableView.m
//  ClshUser
//
//  Created by kobe on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHHomeShopRemarkTableView.h"
#import "KBCircleSegmentView.h"
#import "CLGSDetailCommentCell.h"
#import "CLSHHomeRemarkModel.h"
#import "CLGSHomeVC.h"
#import "CLSHNullRemarkView.h"

@interface CLSHHomeShopRemarkTableView ()<UITableViewDelegate,UITableViewDataSource, KBCircleSegmentViewDelegate>{
    
    KBCircleSegmentView * CircleSegment;
    NSMutableArray * commonArray;
    NSArray * CommentArray;//评论数组
    CLSHHomeRemarkModel *cLSHHomeRemarkModel;
    CLSHHomeRemarkListModel * remarkListModel;
    CLSHHomeProductPraisekModel *cLSHHomeProductPraisekModel;
    
    NSMutableDictionary *params;     //传参
    NSInteger pageNum;              ///<页数
    NSInteger  _index;              //用来记住点几的评论按钮
    
    NSString * commentId;
    
    BOOL supportCount;  ///<判断是否点赞
}

@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;    ///<数据源
@property (nonatomic, strong)CLSHNullRemarkView *nullRemarkView;
@end

@implementation CLSHHomeShopRemarkTableView

static NSString * const recommentID = @"recommentID";


-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40*pro, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[[UIView alloc]init];
        [_tableView registerClass:[CLGSDetailCommentCell class] forCellReuseIdentifier:recommentID];
    }
    return _tableView;
}

-(CLSHNullRemarkView *)nullRemarkView
{
    if (!_nullRemarkView) {
        _nullRemarkView = [[CLSHNullRemarkView alloc] initWithFrame:CGRectMake(0, 40*pro, self.frame.size.width, self.frame.size.height)];
    }
    return _nullRemarkView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.tableView];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTableView:) name:@"changeTableView" object:nil];
        KBRefreshGifHeader *header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headAction)];
        header.lastUpdatedTimeLabel.hidden=YES;
        [header setTitle:@"向下拖拽试试" forState:MJRefreshStateIdle];
        [header setTitle:@"客官别急....." forState:MJRefreshStateRefreshing];
        [header setTitle:@"向下拖拽试试" forState:MJRefreshStatePulling];
        self.tableView.mj_header =header;
        commonArray = [NSMutableArray array];
        params=[NSMutableDictionary dictionary];
        _index = 0;
        
         cLSHHomeRemarkModel=[[CLSHHomeRemarkModel alloc]init];
         CommentArray = [[NSArray alloc] init];
        remarkListModel = [[CLSHHomeRemarkListModel alloc] init];
        cLSHHomeProductPraisekModel=[[CLSHHomeProductPraisekModel alloc]init];
        
        self.tableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        self.tableView.mj_footer.hidden=YES;

    }
    return self;
}


-(void)headAction{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changScroll" object:nil userInfo:nil];
    _tableView.scrollEnabled=NO;
    [self.tableView.mj_header endRefreshing];
}

-(void)loadData{

   
    pageNum=1;
    params[@"pageSize"]=@(10);
    params[@"pageNumber"]=@(pageNum);
    params[@"goodsId"]=_goodsId;
    [cLSHHomeRemarkModel fetchHomeDetailRemarkData:params callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            cLSHHomeRemarkModel = result;
            CommentArray = cLSHHomeRemarkModel.assessments;
            commonArray[0] = [NSString stringWithFormat:@"全部(%li)",[cLSHHomeRemarkModel.allCount integerValue]];
            commonArray[1] = [NSString stringWithFormat:@"好评(%li)",[cLSHHomeRemarkModel.goodCount integerValue]];
            commonArray[2] = [NSString stringWithFormat:@"中评(%li)",[cLSHHomeRemarkModel.middleCount integerValue]];
            commonArray[3] = [NSString stringWithFormat:@"差评(%li)",[cLSHHomeRemarkModel.badCount integerValue]];
//            [self initUI];
            
            [self.tableView reloadData];
            
        }else{
        
            [MBProgressHUD showError:result];
        }
    }];
}

- (void)loadNewData:(BOOL)isRefresh{
    pageNum=1;
    params[@"pageSize"]=@(10);
    params[@"pageNumber"]=@(pageNum);
    params[@"goodsId"]=_goodsId;
    
    [cLSHHomeRemarkModel fetchHomeDetailRemarkData:params callBack:^(BOOL isSuccess, id result) {
       
        
            if (isSuccess) {
                [_dataSource removeAllObjects];
                cLSHHomeRemarkModel = result;
                [self.dataSource addObjectsFromArray:cLSHHomeRemarkModel.assessments];
                if (cLSHHomeRemarkModel.assessments.count) {
                    [self.nullRemarkView removeFromSuperview];
                    [self addSubview:self.tableView];
                    
                }else
                {
                    [self addSubview:self.nullRemarkView];
                    self.nullRemarkView.scrollTop = ^(){
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"changScroll" object:nil userInfo:nil];
                    };
                    [self.tableView removeFromSuperview];
                }
                if (isRefresh) {
                    commonArray[0] = [NSString stringWithFormat:@"全部(%li)",[cLSHHomeRemarkModel.allCount integerValue]];
                    commonArray[1] = [NSString stringWithFormat:@"好评(%li)",[cLSHHomeRemarkModel.goodCount integerValue]];
                    commonArray[2] = [NSString stringWithFormat:@"中评(%li)",[cLSHHomeRemarkModel.middleCount integerValue]];
                    commonArray[3] = [NSString stringWithFormat:@"差评(%li)",[cLSHHomeRemarkModel.badCount integerValue]];
                    [self initUI];
                }

                [self.tableView reloadData];
                
                if (cLSHHomeRemarkModel.assessments.count<10)
                {
                    self.tableView.mj_footer.hidden=YES;
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    self.tableView.mj_footer.hidden=NO;
                    [self.tableView.mj_footer resetNoMoreData];
                }

                
            }else{
                
                [MBProgressHUD showError:result];
            }


    }];
}

-(void)loadMoreData{
    
    if (pageNum < cLSHHomeRemarkModel.totalPages) {
        pageNum++;
        params[@"pageNumber"]=@(pageNum);
        
        
        [cLSHHomeRemarkModel fetchHomeDetailRemarkData:params callBack:^(BOOL isSuccess, id result) {
            
            if (isSuccess) {
                cLSHHomeRemarkModel = result;
                [self.dataSource addObjectsFromArray:cLSHHomeRemarkModel.assessments];
                [self.tableView reloadData];
                
                if (cLSHHomeRemarkModel.assessments.count<10)
                {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.tableView.mj_footer endRefreshing];
                }
                
            }else{
                
//                [MBProgressHUD showError:result];
            }
        }];
    }else
    {
        [self.tableView.mj_footer endRefreshing];
    }
   
}


/*
//点赞
-(void)praise{
    cLSHHomeProductPraisekModel=[[CLSHHomeProductPraisekModel alloc]init];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"userid"]=@(1);
    params[@"assessmentId"]=commentId;
    [cLSHHomeProductPraisekModel fetchHomeDetailPraiseData:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            cLSHHomeRemarkModel = result;
        }else{
        
            [MBProgressHUD showError:result];
        }
    }];
}
*/

-(void)changeTableView:(NSNotification *)notification{
    
    NSDictionary *dict=notification.userInfo;
    if ([dict[@"success"] boolValue]) {
        self.tableView.scrollEnabled=YES;
    }else{
        self.tableView.scrollEnabled=NO;
    }
}

- (void)initUI{
    
    //commonArray  = @[@"全部(0)",@"好评(0)",@"中评(0)",@"差评(0)"];
    
    CircleSegment = [KBCircleSegmentView createCircleSegmentFrame:CGRectMake(0, 0, self.frame.size.width, 40*pro) titleArr:commonArray titleColor:[UIColor blackColor] selectTitleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:12*pro] unselectIcon:nil selectIcon:nil backgroundColor:[UIColor whiteColor] delegate:self];
    CircleSegment.delegate = self;
    [self addSubview:CircleSegment];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    remarkListModel = _dataSource[indexPath.row];
    CGSize size = [NSString sizeWithStr:remarkListModel.content font:[UIFont systemFontOfSize:12*pro] width:SCREENWIDTH-20*pro];
    if (remarkListModel.image.count == 0) {
        return 80*pro + size.height*pro;
    }else
    {
        return 80*pro + size.height*pro + (SCREENWIDTH-50*pro)/4 + 10*pro;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     CLGSDetailCommentCell *Recommentcell = [tableView dequeueReusableCellWithIdentifier:recommentID];
    
    if (!recommentID) {
        Recommentcell = [[CLGSDetailCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recommentID];
    }
    
    __weak __typeof(&*Recommentcell)weakSelf = Recommentcell;
    Recommentcell.remarKListModel = _dataSource[indexPath.row];
    Recommentcell.selectionStyle = UITableViewCellSelectionStyleNone;
    //点赞
    Recommentcell.praiseblock = ^(){
    
        remarkListModel = _dataSource[indexPath.row];
        if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
            
            if ([remarkListModel.supportCount integerValue] == 1) {
                [MBProgressHUD showError:@"已经点过赞了！"];
            }else
            {
                commentId = remarkListModel.commentID;
                
                NSMutableDictionary *needsparams=[NSMutableDictionary dictionary];
                
                needsparams[@"assessmentId"]=commentId;
                
                [cLSHHomeProductPraisekModel fetchHomeDetailPraiseData:needsparams callBack:^(BOOL isSuccess, id result) {
                    if (isSuccess) {
                        cLSHHomeProductPraisekModel = result;
                        
                        [self loadNewData:NO];
                        [weakSelf.praiseButton setImage:[UIImage imageNamed:@"Praise_select"] forState:UIControlStateNormal];
                        
                        [MBProgressHUD showSuccess:@"点赞成功！"];
                    }else{
                        
                        [MBProgressHUD showError:@"点赞失败！"];
                    }
                }];
            }

        }else{
            
            
            [MBProgressHUD showError:@"用户未登录!"];
        }
    
    };
    
    return Recommentcell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"-----------------%@",_goodsId);
}


-(void)selectCircleSegment:(NSInteger)index{
    
    switch (index) {
        case 0:
            
            if ((long)index == (long)_index) {
                break;
            }
            
            [params removeObjectForKey:@"type"];
            [self loadNewData:NO];
            _index=index;
            break;
        case 1:
            NSLog(@"1111111111111111");
            if ((long)index == (long)_index) {
                break;
            }
            params[@"type"] = @"positive";
             [self loadNewData:NO];
             _index=index;
            break;
        case 2:
            if ((long)index == (long)_index) {
                break;
            }
            params[@"type"] = @"moderate";
             [self loadNewData:NO];
             _index=index;
            break;
        case 3:
            if ((long)index == (long)_index) {
                break;
            }
            params[@"type"] = @"negative";
             [self loadNewData:NO];
             _index=index;
            break;
            
        default:
            break;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<-90) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changScroll" object:nil userInfo:nil];
        self.tableView.scrollEnabled=NO;
    }
}

- (void)setGoodsId:(NSString *)goodsId{
    
    _goodsId = goodsId;
     [self loadNewData:YES];
}

@end
