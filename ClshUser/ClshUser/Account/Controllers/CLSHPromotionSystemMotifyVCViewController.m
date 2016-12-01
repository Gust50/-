//
//  CLSHPromotionSystemMotifyVCViewController.m
//  ClshUser
//
//  Created by arom on 16/9/29.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHPromotionSystemMotifyVCViewController.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHInviteCodeRecord.h"

@interface CLSHPromotionSystemMotifyVCViewController (){

    UIBarButtonItem *twoItem;
}
//@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

@end

@implementation CLSHPromotionSystemMotifyVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"晋升制度";
    twoItem=[UIBarButtonItem normalTitle:@"推广记录" selectTitle:@"推广记录" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:nil selectImage:nil target:self action:@selector(toRecordOfad) size:CGSizeMake(80, 30) titleFont:[UIFont systemFontOfSize:14*pro]];
    self.navigationItem.rightBarButtonItem=twoItem;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:RGBColor(52, 52, 52)
                                 };
//    self.detailTextView.attributedText = [[NSAttributedString alloc] initWithString:@"a)达到1积分晋升为1级，可获得推广的商家或用户交易额千1的奖励；\nb)达到30积分晋升为2级，可获得推广的商家或用户交易额千1.2的奖励；\nc)达到100积分晋升为3级，可获得推广的商家或用户交易额千1.5的奖励；\nd)达到300积分晋升为4级，可获得推广的商家或用户交易额千1.8的奖励；\ne)达到500积分晋升为5级，可获得推广的商家或用户交易额千2的奖励；\n注：推广的消费者除了获得交易额奖励外，更可获得消费者当次消费10%的奖励现金。" attributes:attributes];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}

- (void)toRecordOfad{

    CLSHInviteCodeRecord * inviteCodeRecordVC = [CLSHInviteCodeRecord new];
    [self.navigationController pushViewController:inviteCodeRecordVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
