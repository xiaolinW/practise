//
//  XLFunctionView.h
//  CustemKeyborad
//
//  Created by Mac on 16/6/9.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import //定义对应的block类型，用于数据的交互
typedef void (^FunctionBlock) (UIImage *image, NSString *imageText);

@interface XLFunctionView : UIView
//资源文件名
@property (nonatomic, strong) NSString *plistFileName;
//接受block块
-(void)setFunctionBlock:(FunctionBlock) block;

@end
