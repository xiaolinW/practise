//
//  XLFaceView.h
//  CustemKeyborad
//
//  Created by Mac on 16/6/9.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import //声明表情对应的block,用于把点击的表情的图片和图片信息传到上层视图
typedef void (^FaceBlock) (UIImage *image, NSString *imageText);

@interface XLFaceView : UIView

//图片对应的文字
@property (nonatomic, strong) NSString *imageText;
//表情图片
@property (nonatomic, strong) UIImage *headerImage;

//设置block回调
-(void)setFaceBlock:(FaceBlock)block;

//设置图片，文字
-(void)setImage:(UIImage *) image ImageText:(NSString *) text;

@end
