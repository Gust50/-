//
//  KBCountView.m
//  ClshUser
//
//  Created by kobe on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBCountView.h"

@interface KBCountView ()<UITextFieldDelegate>

{
    NSTimer *timer;
}
@property(nonatomic,strong)UIButton *plusButton;
@property(nonatomic,strong)UIButton *minusButton;
@property(nonatomic,strong)UITextField *countTextField;

@end

@implementation KBCountView



#pragma mark <lazyLoad>
-(UIButton *)plusButton{
    if (!_plusButton) {
        _plusButton=[[UIButton alloc]init];
        _plusButton.backgroundColor=systemColor;
        [_plusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_plusButton setTitle:@"+" forState:UIControlStateNormal];
        [_plusButton addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [_plusButton addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
    }
    
    return _plusButton;
}

-(UIButton *)minusButton{
    if (!_minusButton) {
        _minusButton=[[UIButton alloc]init];
        _minusButton.backgroundColor=systemColor;
        _minusButton.backgroundColor=systemColor;
        [_minusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_minusButton setTitle:@"-" forState:UIControlStateNormal];
        [_minusButton addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [_minusButton addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
    }
    return _minusButton;
}

-(UITextField *)countTextField{
    
    if (!_countTextField) {
        _countTextField=[[UITextField alloc]init];
        _countTextField.textColor=systemColor;
        _countTextField.textAlignment=NSTextAlignmentCenter;
        _countTextField.borderStyle=UITextBorderStyleNone;
        _countTextField.font = [UIFont systemFontOfSize:12*pro];
        _countTextField.delegate=self;
    }
    return _countTextField;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
        self.layer.borderColor=systemColor.CGColor;
        self.layer.borderWidth=1;
        self.layer.cornerRadius=3.0;
        self.layer.masksToBounds=YES;
        
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.plusButton];
    [self addSubview:self.minusButton];
    [self addSubview:self.countTextField];
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w=self.frame.size.width;
    CGFloat h=self.frame.size.height;
    
    _plusButton.frame=CGRectMake(w*9/14, 0, w*5/14, h);
    _countTextField.frame=CGRectMake(w*5/14, 0, w*4/14, h);
    _minusButton.frame=CGRectMake(0, 0, w*5/14, h);
}

#pragma mark <otherResponse>
//加
-(void)plus:(UIButton *)button{
    
    NSInteger count=[self.countTextField.text integerValue];
    if (self.maxNumber>count) {
        
        count++;
        _countTextField.text=[NSString stringWithFormat:@"%ld",count];
        
        
    }else{
        
        [MBProgressHUD showError:@"库存不足!"];

    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(KBCountViewPlus:)]) {
        
        [self.delegate KBCountViewPlus:_countTextField.text];
    }
}

//减
-(void)minus:(UIButton *)button{
    
    NSInteger count=[self.countTextField.text integerValue];
    if (count>0) {
        
        if (count <= 1) {
            if (_isUseOtherFunction) {
                count--;
                _countTextField.text=[NSString stringWithFormat:@"%ld",count];
                if (self.delegate && [self.delegate respondsToSelector:@selector(KBCountViewOther:)]) {
                    [self.delegate KBCountViewOther:_countTextField.text];
                }
            }else{
                [MBProgressHUD showError:@"商品数量不能小于1"];
            }

            
        }else
        {
            count--;
            _countTextField.text=[NSString stringWithFormat:@"%ld",count];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(KBCountViewMinus:)]) {
                [self.delegate KBCountViewMinus:_countTextField.text];
                
            }
        }
        
    }else{
        
    }
   
}

-(void)touchDown:(UIButton *)button{
    [_countTextField resignFirstResponder];
    
    if (button==_plusButton) {
        timer=[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(plus:) userInfo:nil repeats:YES];
    }else{
        
        timer=[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(minus:) userInfo:nil repeats:YES];
    }
    [timer fire];
}

-(void)touchUp:(UIButton *)button{
    [self cleanTimer];
}

-(void)cleanTimer{
    
    if (timer.isValid) {
        [timer invalidate];
        timer=nil;
    }
}



-(void)textFieldDidEndEditing:(UITextField *)textField{
    
//    _countTextField.text=[NSString stringWithFormat:@"%ld",count];
    
     NSInteger count=[textField.text integerValue];
    
    if (count>_maxNumber) {
        
        [MBProgressHUD showError:@"库存数量不够"];
        textField.text=[NSString stringWithFormat:@"%ld",_maxNumber];
        
    }
#warning add new functions
    else if(count==0){
        [MBProgressHUD showError:@"数量不能为0"];
        textField.text=@"1";
    }else{
        
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(KBCountViewMinus:)]) {
        [self.delegate KBCountViewMinus:_countTextField.text];
        
    }
    
    
}

-(void)setCurrentNum:(NSString *)currentNum{
    _currentNum=currentNum;
    _countTextField.text=currentNum;
}


-(void)setIsUseOtherFunction:(BOOL)isUseOtherFunction{
    _isUseOtherFunction=isUseOtherFunction;
}
@end
