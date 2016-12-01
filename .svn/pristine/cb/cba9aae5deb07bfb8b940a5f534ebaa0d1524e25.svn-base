//
//  CLSHSetupSexCell.m
//  ClshUser
//
//  Created by wutaobo on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHSetupSexCell.h"
#import "CLSHAccountCorrectModel.h"
#import "CLSHAccountCorrectModel.h"
@interface CLSHSetupSexCell ()
{
    UIImage *select_img;
    UIImage *normal_img;
    CLSHAccountCorrectModel *sexModel;
    NSMutableDictionary *params;
}

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sirHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sirWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ladyWidth;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ladyHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;



/** 性别label */
@property (strong, nonatomic) IBOutlet UILabel *sexLabel;
/** 先生 */
@property (strong, nonatomic) IBOutlet UIButton *sirSex;
/** 女士 */
@property (strong, nonatomic) IBOutlet UIButton *ladySex;

@end

@implementation CLSHSetupSexCell

//修改字体
- (void)modify
{
    self.iconWidth.constant = 16*pro;
    self.iconHeight.constant = 16*pro;
    self.sirSex.imageEdgeInsets = UIEdgeInsetsMake(0, -10*pro, 0, 0);
    self.ladySex.imageEdgeInsets = UIEdgeInsetsMake(0, -10*pro, 0, 0);
    select_img=[UIImage imageNamed:@"Button_select"];
    //不对图形进行渲染，ios7会自动对图形进行渲染
    select_img=[select_img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    normal_img=[UIImage imageNamed:@"Button_normal"];
    //不对图形进行渲染，ios7会自动对图形进行渲染
    normal_img=[normal_img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.sirHeight.constant = 30*pro;
    self.ladyHeight.constant = 30*pro;
    self.sirWidth.constant = 60*pro;
    self.ladyWidth.constant = 60*pro;
    self.sexLabel.textColor = RGBColor(51, 51, 51);
    self.sexLabel.font = [UIFont systemFontOfSize:15*pro];
    self.sirSex.titleLabel.font = [UIFont systemFontOfSize:15*pro];
    [self.sirSex setTitle:@"先生" forState:UIControlStateNormal];
    [self.sirSex setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];

    self.ladySex.titleLabel.font = [UIFont systemFontOfSize:15*pro];
    [self.ladySex setTitle:@"女士" forState:UIControlStateNormal];
    [self.ladySex setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self modify];
}

/**  选择性别 */
- (IBAction)selectSex:(UIButton *)sender {
    
    sexModel = [[CLSHAccountCorrectModel alloc] init];
    params = [NSMutableDictionary dictionary];
    
    if (sender==self.sirSex) {
        [self.sirSex setImage:select_img forState:UIControlStateNormal];
        [self.ladySex setImage:normal_img forState:UIControlStateNormal];
        params[@"gender"]=@"male";
        
    }else{
        [self.sirSex setImage:normal_img forState:UIControlStateNormal];
        [self.ladySex setImage:select_img forState:UIControlStateNormal];
         params[@"gender"]=@"female";
    }
    [sexModel fetchAccountModifySexModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}
#pragma mark - setter getter
-(void)setGender:(NSString *)gender
{
    _gender = gender;
    if ([gender isEqualToString:@"male"]) {
        [self.sirSex setImage:select_img forState:UIControlStateNormal];
        [self.ladySex setImage:normal_img forState:UIControlStateNormal];
    }else
    {
        [self.ladySex setImage:select_img forState:UIControlStateNormal];
        [self.sirSex setImage:normal_img forState:UIControlStateNormal];
    }
}

@end
