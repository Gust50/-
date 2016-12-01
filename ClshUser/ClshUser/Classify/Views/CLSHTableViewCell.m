//
//  CLSHTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/5/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHTableViewCell.h"
#import "Masonry.h"
#import "CLSHClassifyModel.h"

@implementation CLSHTableViewCell

- (UILabel *)listLabel{

    if(!_listLabel) {
        _listLabel = [[UILabel alloc] init];
        _listLabel.font = [UIFont systemFontOfSize:12*pro];
        _listLabel.textAlignment = NSTextAlignmentCenter;
//        if (self.isSelect) {
//            _listLabel.textColor = RGBColor(0, 149, 68);
//        }
    }
    return _listLabel;
}

- (UIView *)lineView{

    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor whiteColor];
//        if (self.isSelect) {
//            _lineView.backgroundColor = RGBColor(0, 149, 68);
//        }
    }
    return _lineView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

- (void)initUI{
    
    [self addSubview:self.lineView];
    [self addSubview:self.listLabel];
   
    [self updateConstraints];
}

- (void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(5*pro,weakSelf.height*pro));
    }];

    [_listLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.left.equalTo(_lineView.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
    }];
   }

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.lineView.backgroundColor = systemColor;
        self.listLabel.textColor = RGBColor(0, 149, 68);
    }
}


//-(void)setModel:(CLSHClassifyProductCategoryModel *)model{
//    _model=model;
//    self.listLabel.text=model.name;
//}
@end
