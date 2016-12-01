//
//  CLSHRemarkCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHRemarkCell.h"
#import "Masonry.h"

@interface CLSHRemarkCell ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *remark;


@end

@implementation CLSHRemarkCell

#pragma mark-getter setter
-(UITextView *)textView{
    if (!_textView) {
        _textView=[[UITextView alloc]init];
        _textView.layer.borderWidth = 1.0;
        _textView.layer.borderColor = RGBColor(212, 212, 212).CGColor;
        _textView.layer.cornerRadius = 5.0;
        _textView.layer.masksToBounds = YES;
        _textView.delegate = self;
    }
    return _textView;
}

-(UILabel *)remark{
    if (!_remark) {
        _remark=[[UILabel alloc]init];
        _remark.textColor = RGBColor(51, 51, 51);
        _remark.font = [UIFont systemFontOfSize:13*pro];
        _remark.text = @"备注:";
    }
    return _remark;
}

#pragma mark-init UI
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
        self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, SCREENWIDTH-20, 20)];
        self.placeholderLabel.textColor = RGBColor(204, 204, 204);
        self.placeholderLabel.text = @"想说什么就说什么！！！！！";
        self.placeholderLabel.font = [UIFont systemFontOfSize:13*pro];
        self.placeholderLabel.hidden = NO;
        [self.textView addSubview:self.placeholderLabel];
        
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.remark];
    [self addSubview:self.textView];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_remark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(60*pro, 20*pro));
    }];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_remark.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(80*pro));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
}



//设置textView的placeholder
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(![text isEqualToString:@""])
    {
        [self.placeholderLabel setHidden:YES];
    }
    if([text isEqualToString:@""]&&self.textView.text.length==1){
        [self.placeholderLabel setHidden:NO];
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"memo"] = self.textView.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"remark" object:nil userInfo:params];
    
    return YES;
}

//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([text isEqualToString:@"n"]) {//检测到“完成”
//        [textView resignFirstResponder];//释放键盘
//        return NO;
//    }
//    if (self.textView.text.length==0){//textview长度为0
//        if ([text isEqualToString:@""]) {//判断是否为删除键
//            self.placeholderLabel.hidden=NO;//隐藏文字
//        }else{
//            
//            self.placeholderLabel.hidden=YES;
//        }
//    }else{//textview长度不为0
//        if (self.textView.text.length==1){//textview长度为1时候
//            if ([text isEqualToString:@""]) {//判断是否为删除键
//                self.placeholderLabel.hidden=NO;
//            }else{//不是删除
//                self.placeholderLabel.hidden=YES;
//            }
//        }else{//长度不为1时候
//
//            self.placeholderLabel.hidden=YES;
//        }
//    }
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"memo"] = self.textView.text;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"remark" object:nil userInfo:params];
//    return YES;
//}

@end
