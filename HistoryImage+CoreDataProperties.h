//
//  HistoryImage+CoreDataProperties.h
//  CustemKeyborad
//
//  Created by Mac on 16/6/9.
//  Copyright © 2016年 Mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HistoryImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryImage (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *headerImage;
@property (nullable, nonatomic, retain) NSString *imageText;
@property (nullable, nonatomic, retain) NSDate *time;

@end

NS_ASSUME_NONNULL_END
