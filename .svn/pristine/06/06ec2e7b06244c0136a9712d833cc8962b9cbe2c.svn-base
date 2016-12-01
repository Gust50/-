//
//  CLSHApplyFeedBackView.m
//  ClshUser
//
//  Created by arom on 16/8/11.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHApplyFeedBackView.h"
#import "CLSHApplyFeedBackViewCell.h"

@interface CLSHApplyFeedBackView ()<UITableViewDelegate,UITableViewDataSource>{

    int SelectRow;//选中的行
    NSString * reason;
}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSArray * dataArray;

@end

@implementation CLSHApplyFeedBackView

static NSString * const headCellID = @"headCellID";

#pragma mark -- 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20*pro, SCREENHEIGHT-274*pro+64, SCREENWIDTH-40*pro, 264*pro)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.cornerRadius = 5;
    }
    return _tableView;
}

- (NSArray *)dataArray{

    if (!_dataArray) {
        _dataArray = @[@"信息填写错误",@"选错商品",@"商品暂缺、无法发货",@"时间不方便",@"其他"];
    }
    return _dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [self addSubview:self.tableView];
        [self.tableView registerClass:[CLSHApplyFeedBackViewCell class] forHeaderFooterViewReuseIdentifier:headCellID];
        SelectRow = -1;
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self removeFromSuperview];
}

#pragma --table datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44*pro;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 44*pro;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    CLSHApplyFeedBackViewCell * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headCellID];
    if (!headView) {
        headView = [[CLSHApplyFeedBackViewCell alloc] initWithReuseIdentifier:headCellID];
    }
    
    headView.cancelblock = ^(){
    
        [self removeFromSuperview];
    };
    
    headView.confirmblock = ^(){
    
        [self removeFromSuperview];
        if (reason.length) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(transformReason:)]) {
                [self.delegate transformReason:reason];
            }
           
        }else{
        
            [MBProgressHUD showError:@"请选择原因"];
        }
      };
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    static NSString * const cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = RGBColor(52, 52, 52);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

        
    if (SelectRow == indexPath.row) {
        return;
    }
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = systemColor;
    
    reason = cell.textLabel.text;
    SelectRow = (int)indexPath.row;
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = RGBColor(52, 52, 52);
    
}

@end
