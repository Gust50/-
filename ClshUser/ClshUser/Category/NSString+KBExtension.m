//
//  NSString+KBExtension.m
//  ClshUser
//
//  Created by kobe on 16/6/13.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "NSString+KBExtension.h"

@implementation NSString (KBExtension)

+(CGSize)sizeWithStr:(NSString *)str
                font:(UIFont *)font
               width:(CGFloat)width
{
    
    NSDictionary *dict=@{NSFontAttributeName:font};
    CGSize size=[str boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                  attributes:dict
                                     context:nil].size;
    return size;

}

+(void)labelString:(UILabel *)lable
              font:(UIFont *)font
             range:(NSRange)range
             color:(UIColor *)color
{
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:lable.text];
    [str addAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color} range:range];
    lable.attributedText=str;
}

+(NSNumberFormatter *)numberFormatter{
    //修改金额格式
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //数字格式化
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.locale=locale;
    formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    
    return formatter;
}

//处理高亮文案，根据{}
+ (NSAttributedString *)attriTipBySpecialSymbolWithTipStr:(NSString *)tipStr
                                              normalColor:(UIColor *)nColor
                                                highColor:(UIColor *)hColor
                                               normalSize:(CGFloat)nSize
                                                 highSize:(CGFloat)hSize{
    
    NSDictionary *nAttri = @{NSFontAttributeName : [UIFont systemFontOfSize:nSize],
                             NSForegroundColorAttributeName : nColor};
    NSDictionary *hAttri = @{NSFontAttributeName : [UIFont systemFontOfSize:hSize],
                             NSForegroundColorAttributeName : hColor};
    
    NSArray *strArr1 = [tipStr componentsSeparatedByString:@"}"];
    NSMutableAttributedString *attriTipStr = [[NSMutableAttributedString alloc] init];
    
    for (NSString *str1 in strArr1) {
        
        NSArray *strArr2 = [str1 componentsSeparatedByString:@"{"];
        for (NSInteger i=0; i<strArr2.count; i++) {
            
            NSDictionary *attri = i==0 ? nAttri : hAttri;
            [attriTipStr appendAttributedString:[[NSAttributedString alloc] initWithString:strArr2[i] attributes:attri]];
        }
    }
    
    return attriTipStr;
}
@end
