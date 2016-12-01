//
//  CLSHFactoryEvaluationTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/7/13.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHFactoryEvaluationTableViewCell.h"
#import "Masonry.h"
#import "CLSHAccountOrderModel.h"
#import "CLGSStarRate.h"

@interface CLSHFactoryEvaluationTableViewCell()<UITextViewDelegate,MStarRateViewDelegate>{

    CLGSStarRate *starRate;
}

@property(nonatomic,strong)UILabel *placeHolderLabel;

@end

@implementation CLSHFactoryEvaluationTableViewCell

#pragma mark lazyload
- (UIImageView *)image{
    
    if (!_image) {
        _image = [[UIImageView alloc] init];
    }
    return _image;
}

- (UITextView *)evaluationView{
    
    if (!_evaluationView) {
        _evaluationView = [[UITextView alloc] init];
        _evaluationView.font = [UIFont systemFontOfSize:12*pro];
        _evaluationView.delegate = self;
    }
    return _evaluationView;
}

- (UIButton *)cameraButton{
    
    if (!_cameraButton) {
        _cameraButton = [[UIButton alloc] init];
        _cameraButton.backgroundColor = backGroundColor;
        [_cameraButton setImage:[UIImage imageNamed:@"compose_pic_add"] forState:(UIControlStateNormal)];
        [_cameraButton addTarget:self action:@selector(goCamera) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _cameraButton;
}

- (UIScrollView *)scrollview{
    
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] init];
        //        _scrollview.backgroundColor = [UIColor redColor];
        _scrollview.showsHorizontalScrollIndicator=NO;
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.userInteractionEnabled = YES;
    }
    return _scrollview;
}

- (UILabel *)attentionLable{
    
    if (!_attentionLable) {
        _attentionLable = [[UILabel alloc] init];
        _attentionLable.text = @"*上传图片请限制在4张以内";
        _attentionLable.textColor = RGBColor(102, 102, 102);
        _attentionLable.textAlignment = NSTextAlignmentCenter;
        _attentionLable.font = [UIFont systemFontOfSize:13*pro];
    }
    return _attentionLable;
}

- (UIView *)lineView{
    
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = backGroundColor;
    }
    return _lineView;
}

- (UIView *)starRateView{

    if (!_starRateView) {
        _starRateView = [[UIView alloc] init];
    }
    return _starRateView;
}

- (UILabel *)placeHolderLabel{
    
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,-5,SCREENWIDTH-(8+10+80+10)*pro,60)];
        _placeHolderLabel.numberOfLines = 0;
        _placeHolderLabel.font = [UIFont systemFontOfSize:13*pro];
        _placeHolderLabel.text = @"请写下对宝贝的感受吧，对他人帮助很大哦！";
        _placeHolderLabel.textColor = [UIColor lightGrayColor];
        _placeHolderLabel.backgroundColor =[UIColor clearColor];
    }
    return _placeHolderLabel;
}

- (NSMutableArray *)picArr{
    
    if (!_picArr) {
        _picArr = [NSMutableArray array];
    }
    return _picArr;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    [self addSubview:self.image];
    [self addSubview:self.evaluationView];
    [self addSubview:self.scrollview];
    [_scrollview addSubview:self.cameraButton];
    [self addSubview:self.starRateView];
    [self addSubview:self.lineView];
    [self addSubview:self.attentionLable];
    
    [_evaluationView addSubview:self.placeHolderLabel];
    [self updateConstraints];
}

- (void)updateConstraints{
    
    [super updateConstraints];
    WS(weakSelf);
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top).with.offset(8*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(8*pro);
        make.width.equalTo(@(80*pro));
        make.height.equalTo(@(80*pro));
    }];
    
    [_evaluationView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top).with.offset(8*pro);
        make.left.equalTo(_image.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-8*pro);
        make.height.equalTo(@(80*pro));
    }];
    
    [_cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_image.mas_bottom).with.offset(15*pro);
        
        make.width.equalTo(@(70*pro));
        make.height.equalTo(@(70*pro));
    }];
    
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_image.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(8*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-8*pro);
        make.height.equalTo(@(80*pro));
        
    }];
    
    [_starRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        make.height.equalTo(@(40*pro));
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
    }];
   
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.bottom.equalTo(_starRateView.mas_top).with.offset(-1);
        make.height.equalTo(@1);
    }];
    
    [_attentionLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(8*pro);
        make.bottom.equalTo(_lineView.mas_top).with.offset(-5*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-8*pro);
        make.height.equalTo(@(20*pro));
        
    }];
}

- (void)setModel:(CLSHAccountOrderDetailOneModel *)model{
    
    WS(weakSelf);
    _model = model;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.picArr = model.imgArr;
    
    starRate=[[CLGSStarRate alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-100*pro, 5*pro, 200*pro, 30*pro) numberOfStars:5];
    starRate.iSAnimation = YES;
    if (model.rate>0) {
         starRate.scorePercent = (CGFloat)(1/model.rate);
    }else{
         starRate.scorePercent = 1.0;
    }
   
    starRate.getStarPercent=^(CGFloat start){
        NSLog(@">>>>>>>>>>>>>>>>>>>>>>%ld",(NSInteger)(start*5));
        if (weakSelf.startRateBlock) {
            weakSelf.startRateBlock((NSInteger)(start*5));
        }
    };
    
    [_starRateView addSubview:starRate];
    
    
    for (UIImageView *img in _scrollview.subviews) {
        if ([img isKindOfClass:[UIImageView class]]) {
            [img removeFromSuperview];
        }
    }
    
    //    self.scrollview.contentSize = CGSizeMake(70*pro*(_imgArr.count), 70*pro);

    for (int i = 0; i<model.imgArr.count; i++) {
        UIImage * image = [[UIImage alloc] init];
        image = model.imgArr[i];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(70*pro*i+8*i*pro, 5*pro, 70*pro, 70*pro)];
        imageView.image = image;
        imageView.userInteractionEnabled = YES;
        UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(imageView.width-15*pro, 0*pro, 15*pro, 15*pro)];
        deleteBtn.tag = i + 1;
        [deleteBtn setImage:[UIImage imageNamed:@"DeleteIconRed"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:deleteBtn];
        
        [self.scrollview addSubview:imageView];
    }
    

    if (model.imgArr.count < 4) {
        self.cameraButton.hidden = NO;
        [_cameraButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(70*pro*model.imgArr.count+8*(model.imgArr.count+1)*pro);
        }];
    }else
    {
        self.cameraButton.hidden = YES;
    }
}


-(void)deleteImage:(UIButton *)btn{
    if (self.delectImageBlock) {
        self.delectImageBlock(_indexPath,btn.tag);
    }
}


-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath=indexPath;
}


- (void)textViewDidChange:(UITextView*)textView{
    
    if([textView.text length] == 0){
        
        _placeHolderLabel.text = @"请写下对宝贝的感受吧，对他人帮助很大哦！";
        
    }else{
        
        _placeHolderLabel.text = @"";//这里给空
        
    }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (self.commentTextBlock) {
        self.commentTextBlock(textView.text);
    }
}

- (void)goCamera{
    
    self.camerablock();
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
