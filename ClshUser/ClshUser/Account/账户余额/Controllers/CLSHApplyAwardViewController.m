//
//  CLSHApplyAwardViewController.m
//  ClshUser
//
//  Created by arom on 16/11/11.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHApplyAwardViewController.h"
#import "KBAlertView.h"
#import "ZCSlotMachine.h"
#import "CLSHAccountBalanceModel.h"
#import "CLSHAwardDayView.h"
#import "AppDelegate.h"

@interface CLSHApplyAwardViewController ()<KBAlertViewDelegate,ZCSlotMachineDelegate,ZCSlotMachineDataSource>{

     ZCSlotMachine *_slotMachine;
    UIView *_slotContainerView;
    UIImageView *_slotOneImageView;
    UIImageView *_slotTwoImageView;
    UIImageView *_slotThreeImageView;
    NSArray *_slotIcons;
    
    CLSHAwardDayDataModel * awardDaysModel;
}

@property (nonatomic, strong)CLSHAwardDayView *awardDayView;

@end

@implementation CLSHApplyAwardViewController

#pragma mrak <lazyLoad>;
- (UIImageView *)handBarImgeView{

    if (!_handBarImgeView) {
        _handBarImgeView = [[UIImageView alloc] init];
        _handBarImgeView.image = [UIImage imageNamed:@"handbar"];
        _handBarImgeView.userInteractionEnabled = YES;
    }
    return _handBarImgeView;
}
- (UIImageView *)bodyImageView{

    if (!_bodyImageView) {
        _bodyImageView = [[UIImageView alloc] init];
        _bodyImageView.image = [UIImage imageNamed:@"award"];
        _bodyImageView.userInteractionEnabled = YES;
    }
    return _bodyImageView;
}

- (UILabel *)describeLabel{

    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.textColor = [UIColor whiteColor];
        _describeLabel.font = [UIFont boldSystemFontOfSize:12*pro];
        _describeLabel.text = @"*可提取金额为￥0.00";
    }
    return _describeLabel;
}

- (UIButton *)startBtn{

    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_startBtn setImage:[UIImage imageNamed:@"startBtn"] forState:(UIControlStateNormal)];
        [_startBtn addTarget:self action:@selector(startAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _startBtn;
}
- (UIView *)backView{

    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor orangeColor];//RGBColor(255, 128, 20);
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 20;
    }
    return _backView;
}

- (UIImageView *)ruleImageView{

    if (!_ruleImageView) {
        _ruleImageView = [[UIImageView alloc] init];
        _ruleImageView.image = [UIImage imageNamed:@"applyRule"];
    }
    return _ruleImageView;
}

- (UILabel *)oneLabel{

    if (!_oneLabel) {
        _oneLabel = [[UILabel alloc] init];
        _oneLabel.textColor = [UIColor whiteColor];
        _oneLabel.font = [UIFont boldSystemFontOfSize:13*pro];
        _oneLabel.numberOfLines = 0;
        _oneLabel.lineBreakMode = NSStringEnumerationByWords;
        _oneLabel.text = @"1、余额需满5元才可进行抽取返还,每抽取一次，余额自动清零。";
    }
    return _oneLabel;
}

- (UILabel *)twoLabel{

    if (!_twoLabel) {
        _twoLabel = [[UILabel alloc] init];
        _twoLabel.textColor = [UIColor whiteColor];
        _twoLabel.font = [UIFont boldSystemFontOfSize:13*pro];
        _twoLabel.numberOfLines = 0;
        _twoLabel.lineBreakMode = NSStringEnumerationByWords;
        _twoLabel.text = @"2、已抽取的奖励金额未返还完毕，可取消返还，取消将扣除3%的费用，待返还金额将全数退还到奖励金额中。";
    }
    return _twoLabel;
}

- (CLSHAwardDayView *)awardDayView{

    if (!_awardDayView) {
        _awardDayView = [[CLSHAwardDayView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _awardDayView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.6];
    }
    return _awardDayView;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _slotIcons = [NSArray arrayWithObjects:
                      [UIImage imageNamed:@"zero"],[UIImage imageNamed:@"zero"], [UIImage imageNamed:@"one"], [UIImage imageNamed:@"two"], [UIImage imageNamed:@"three"],[UIImage imageNamed:@"four"],[UIImage imageNamed:@"five"],[UIImage imageNamed:@"six"],[UIImage imageNamed:@"seven"],[UIImage imageNamed:@"eight"],[UIImage imageNamed:@"nine"], nil];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)loadData{

    awardDaysModel = [[CLSHAwardDayDataModel alloc] init];
    [awardDaysModel fetchAwardDaydata:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
       
        if (isSuccess) {
            awardDaysModel = result;
            NSMutableArray * array = [NSMutableArray array];
            for (NSInteger i = 0; i<awardDaysModel.ramainEffectiveDay.length; i++) {
                unichar a = [awardDaysModel.ramainEffectiveDay characterAtIndex:i];
                NSInteger b;
                b = (int)(a)-'0';
                NSNumber *aNum = [NSNumber numberWithInteger:b];
                [array addObject:aNum];
            }
            if (awardDaysModel.ramainEffectiveDay.length == 1) {
                [array insertObject:[NSNumber numberWithInteger:0] atIndex:0];
                [array insertObject:[NSNumber numberWithInteger:0] atIndex:0];
                _slotMachine.slotResults = [NSArray arrayWithArray:array];
            }else if (awardDaysModel.ramainEffectiveDay.length == 2){
                
                [array insertObject:[NSNumber numberWithInteger:0] atIndex:0];
                _slotMachine.slotResults = [NSArray arrayWithArray:array];
            }else{
                
                _slotMachine.slotResults = [NSArray arrayWithArray:array];
            }
            [_slotMachine startSliding];

        }else{
            [MBProgressHUD showError:result];
        }
    }];
    
}

- (void)initUI{
    
    self.navigationItem.title = @"提取奖励金额";
    self.view.backgroundColor = backGroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.handBarImgeView];
    [self.view addSubview:self.bodyImageView];
    [_bodyImageView addSubview:self.describeLabel];
    [_bodyImageView addSubview:self.startBtn];
    [self.view addSubview:self.backView];
    [self.view addSubview:self.ruleImageView];
    [_backView addSubview:self.oneLabel];
    [_backView addSubview:self.twoLabel];
    
    [self updateViewConstraints];
    
    _slotMachine = [[ZCSlotMachine alloc] initWithFrame:CGRectMake(0, 0, 215*pro, 83*pro)];
    _slotMachine.backgroundImage = [UIImage imageNamed:@""];
    _slotMachine.coverImage = [UIImage imageNamed:@""];
    _slotMachine.delegate = self;
    _slotMachine.dataSource = self;
    _slotMachine.userInteractionEnabled = YES;
    _slotMachine.center = CGPointMake(160*pro, 174*pro);
//    _slotMachine.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_slotMachine];
    WS(weakSelf);
    self.awardDayView.sureBtnblock = ^(){
        
        [weakSelf.awardDayView removeFromSuperview];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
}


#pragma mark <starBtn action>
- (void)startAction:(UIButton *)btn{

    CGSize size = [NSString sizeWithStr:@"每提取一次，余额自动清零 是否继续？" font:[UIFont systemFontOfSize:16] width:SCREENWIDTH-30];
    KBAlertView *kBAlertView=[[[NSBundle mainBundle]loadNibNamed:@"KBAlertView" owner:self options:nil]lastObject];
    kBAlertView.frame=self.view.bounds;
    kBAlertView.center=self.view.center;
    kBAlertView.contentLabel.text=@"每提取一次，余额自动清零 是否继续？";
    kBAlertView.contentHeight.constant=size.height+130;
    kBAlertView.delegate=self;
    [[[UIApplication sharedApplication]keyWindow]addSubview:kBAlertView];
   
}

#pragma mark <KBAlertViewDelegate>
-(void)confirmOrder{
    
    [UIView animateWithDuration:1.0 animations:^{
        
        self.handBarImgeView.layer.transform=CATransform3DMakeRotation(M_PI,1,0,0);
    }];
    [self loadData];

}

#pragma mark - ZCSlotMachineDelegate

- (void)slotMachineWillStartSliding:(ZCSlotMachine *)slotMachine {
    _startBtn.enabled = NO;
}

- (void)slotMachineDidEndSliding:(ZCSlotMachine *)slotMachine {
    _startBtn.enabled = YES;
    self.handBarImgeView.transform = CGAffineTransformIdentity;
    self.awardDayView.awardDayLabel.text = [NSString stringWithFormat:@"抽中%@天",awardDaysModel.ramainEffectiveDay];
    self.awardDayView.describeLabel.text = [NSString stringWithFormat:@"奖励金额将分%@天返还到您的余额中",awardDaysModel.ramainEffectiveDay];
    [ShareApp.window addSubview:self.awardDayView];
}

#pragma mark - ZCSlotMachineDataSource

- (NSArray *)iconsForSlotsInSlotMachine:(ZCSlotMachine *)slotMachine {
    
    return _slotIcons;

}

- (NSUInteger)numberOfSlotsInSlotMachine:(ZCSlotMachine *)slotMachine {
    return 3;
}

- (CGFloat)slotWidthInSlotMachine:(ZCSlotMachine *)slotMachine {
    return 65.0f*pro;
}

- (CGFloat)slotSpacingInSlotMachine:(ZCSlotMachine *)slotMachine {
    return 10.0f*pro;
}


- (void)updateViewConstraints{

    [super updateViewConstraints];
    WS(weakSelf);
    
    [_handBarImgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(7.5*pro);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-7.5*pro);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(110*pro);
        make.height.equalTo(@(130*pro));
    }];
    
    [_bodyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(15*pro);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-15*pro);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(84*pro);
        make.height.equalTo(@(250*pro));
    }];
    [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bodyImageView.mas_centerX);
        make.height.equalTo(@(40*pro));
        make.width.equalTo(@(200*pro));
        make.bottom.equalTo(_bodyImageView.mas_bottom).with.offset(-30*pro);
    }];
    
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bodyImageView.mas_centerX);
        make.bottom.equalTo(_startBtn.mas_top).with.offset(-10*pro);
    }];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(20*pro);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-15*pro);
        make.top.equalTo(_bodyImageView.mas_bottom).with.offset(20*pro);
        make.height.equalTo(@(150*pro));
    }];
    
    [_ruleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView.mas_centerX);
        make.height.equalTo(@(30*pro));
        make.top.equalTo(_backView.mas_top).with.offset(-15*pro);
        make.width.equalTo(@(100*pro));
    }];
    
    [_oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.top.equalTo(_ruleImageView.mas_bottom).with.offset(15*pro);
        
    }];
    
    [_twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.top.equalTo(_oneLabel.mas_bottom).with.offset(15*pro);
    }];
}

- (void)setAwardMoney:(CGFloat)awardMoney{

    _awardMoney = awardMoney;
    self.describeLabel.text = [NSString stringWithFormat:@"*可提取金额为%.2lf",awardMoney];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
