//
//  KBImageToolViewController.h
//  KBCustomPhoto
//
//  Created by kobe on 16/4/22.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KBImageToolViewController;

@protocol KBImageToolViewControllerDelegate<NSObject>

-(void)imageCropper:(KBImageToolViewController *)kBImageToolViewController didFinished:(UIImage *)editedImage;
-(void)imageCropperCancel:(KBImageToolViewController *)kBImageToolViewController;

@end

@interface KBImageToolViewController : UIViewController

/** 索引值 */
@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,weak)id<KBImageToolViewControllerDelegate>delegate;
/** 裁剪的尺寸 */
@property(nonatomic,assign)CGRect cropFrame;
//裁剪图片
-(id)initWithImage:(UIImage *)originImage cropFrame:(CGRect)cropFrame scaleRatio:(NSInteger)scaleRatio;

@end
