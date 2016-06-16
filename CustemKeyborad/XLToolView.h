//
//  XLToolView.h
//  CustemKeyborad
//
//  Created by Mac on 16/6/9.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ToolIndex) (NSInteger index);

@interface XLToolView : UIView

//块变量类型的setter方法
-(void)setToolIndex:(ToolIndex) toolBlock;

@end
