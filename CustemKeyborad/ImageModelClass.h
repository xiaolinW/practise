//
//  ImageModelClass.h
//  CustemKeyborad
//
//  Created by Mac on 16/6/9.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLFunctionView.h"
#import "HistoryImage.h"
#import "HistoryImage+CoreDataProperties.h"
@interface ImageModelClass : NSObject
//保存数据
-(void)save:(NSData *) image ImageText:(NSString *) imageText;
//查询所有的图片
-(NSArray *) queryAll;
@end
