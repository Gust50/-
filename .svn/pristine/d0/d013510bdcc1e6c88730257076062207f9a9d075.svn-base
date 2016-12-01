//
//  CLSHCommentTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHCommentTableViewCell.h"
#import "Masonry.h"
#import "CLSHAccountCommentModel.h"

@interface CLSHCommentTableViewCell ()

@property (nonatomic,strong)UIImageView *GoodsImgeView;//!>商品图片
@property (nonatomic,strong)UILabel * nameLabel;//!>商品名字
@property (nonatomic,strong)UILabel * completeCommentLabel;//!>已好评
@property (nonatomic,strong)UILabel * contentLabel;//!>评论内容
@property (nonatomic,strong)UILabel * timeLabel;//!>时间
@property (nonatomic,strong)UIImageView *firstImage;   ///<评价图片
@property (nonatomic,strong)UIImageView *secondImage;   ///<评价图片
@property (nonatomic,strong)UIImageView *thirdImage;   ///<评价图片
@property (nonatomic,strong)UIImageView *fourImage;   ///<评价图片

@property (nonatomic,assign) CGFloat commentHeight; ///<计算评论高度

@end

@implementation CLSHCommentTableViewCell

#pragma  mark <lazyload>
- (UIImageView *)GoodsImgeView{

    if (!_GoodsImgeView) {
        _GoodsImgeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"酒水饮料"]];
        _GoodsImgeView.layer.cornerRadius = 20.0*pro;
        _GoodsImgeView.layer.masksToBounds = YES;
    }
    return _GoodsImgeView;
}

- (UILabel *)nameLabel{

    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"新疆纸皮核桃 皮薄肉吹";
        _nameLabel.textColor = RGBColor(102, 102, 102);
        _nameLabel.font = [UIFont systemFontOfSize:14*pro];
    }
    return _nameLabel;
}

- (UILabel *)completeCommentLabel{

    if (!_completeCommentLabel) {
        _completeCommentLabel = [[UILabel alloc] init];
        _completeCommentLabel.text = @"已好评";
        _completeCommentLabel.textColor = RGBColor(242, 51, 47);
        _completeCommentLabel.font = [UIFont systemFontOfSize:12*pro];
        _completeCommentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _completeCommentLabel;
}

- (UILabel *)contentLabel{

    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"不错不错，下次还要来买，店家态度很好，物流也很快，商品 质量也很好，店家也耐心的给我讲解，不错不错，下次还要来 买，店家态度很好，物流也很快，商品质量也。";
        _contentLabel.textColor = RGBColor(102, 102, 102);
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return _contentLabel;
}

- (UILabel *)timeLabel{

    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"2015-05-06";
        _timeLabel.textColor = RGBColor(153, 153, 153);
        _timeLabel.font = [UIFont systemFontOfSize:11*pro];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

-(UIImageView *)firstImage
{
    if (!_firstImage) {
        _firstImage = [[UIImageView alloc] init];
    }
    return _firstImage;
}

-(UIImageView *)secondImage
{
    if (!_secondImage) {
        _secondImage = [[UIImageView alloc] init];
    }
    return _secondImage;
}

-(UIImageView *)thirdImage
{
    if (!_thirdImage) {
        _thirdImage = [[UIImageView alloc] init];
    }
    return _thirdImage;
}

-(UIImageView *)fourImage
{
    if (!_fourImage) {
        _fourImage = [[UIImageView alloc] init];
        
    }
    return _fourImage;
}

#pragma mark init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

#pragma mark 初始化UI
- (void)initUI{

    [self addSubview:self.GoodsImgeView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.completeCommentLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.firstImage];
    [self addSubview:self.secondImage];
    [self addSubview:self.thirdImage];
    [self addSubview:self.fourImage];
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_GoodsImgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.width.mas_equalTo(@(40*pro));
        make.height.mas_equalTo(@(40*pro));
        
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_GoodsImgeView.mas_right).with.offset(10*pro);
        make.centerY.equalTo(_GoodsImgeView.mas_centerY);
        make.width.mas_equalTo(@(150*pro));
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_completeCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_nameLabel.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.left.equalTo(_nameLabel.mas_right).with.offset(10*pro);
        make.height.equalTo(@(20*pro));
        
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.top.equalTo(_GoodsImgeView.mas_bottom).with.offset(10*pro);
    }];
    
    [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.commentHeight*pro));
    }];
    
    [_firstImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.top.equalTo(_contentLabel.mas_bottom).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-50*pro)/4, (SCREENWIDTH-50*pro)/4));
    }];
    
    [_secondImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_firstImage.mas_right).with.offset(10*pro);
        make.top.equalTo(_contentLabel.mas_bottom).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-50*pro)/4, (SCREENWIDTH-50*pro)/4));
    }];
    
    [_thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_secondImage.mas_right).with.offset(10*pro);
        make.top.equalTo(_contentLabel.mas_bottom).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-50*pro)/4, (SCREENWIDTH-50*pro)/4));
    }];
    
    [_fourImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_thirdImage.mas_right).with.offset(10*pro);
        make.top.equalTo(_contentLabel.mas_bottom).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-50*pro)/4, (SCREENWIDTH-50*pro)/4));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.equalTo(@(20*pro));
    }];
}

#pragma mark - setter getter
-(void)setCommentListModel:(CLSHAccountCommentListModel *)commentListModel
{
    _commentListModel = commentListModel;
    [_GoodsImgeView sd_setImageWithURL:[NSURL URLWithString:commentListModel.avatar] placeholderImage:nil];
    _nameLabel.text = commentListModel.name;
    _completeCommentLabel.text = [NSString stringWithFormat:@"评分：%@分", commentListModel.score];
    _contentLabel.text = commentListModel.content;
    CGSize  size = [NSString sizeWithStr:_contentLabel.text font:[UIFont systemFontOfSize:12*pro] width:SCREENWIDTH-20*pro];
    self.commentHeight = size.height;
    //时间戳
    NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([commentListModel.assessmentTime doubleValue]/1000.0)];
    NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
    _timeLabel.text = timeString;
    _firstImage.image = nil;
    _secondImage.image = nil;
    _thirdImage.image = nil;
    _fourImage.image = nil;
    NSMutableArray *array = [NSMutableArray arrayWithObjects:_firstImage, _secondImage, _thirdImage, _fourImage, nil];
    for (int i = 0; i < commentListModel.image.count; i++) {
        UIImageView *arrayImage = array[i];
        [arrayImage sd_setImageWithURL:[NSURL URLWithString:commentListModel.image[i]] placeholderImage:nil];
    }
}

@end
