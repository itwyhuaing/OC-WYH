//
//  NewActivityInfo+CoreDataProperties.h
//  hinabian
//
//  Created by hnbwyh on 16/5/30.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "NewActivityInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewActivityInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *activity_time;
@property (nullable, nonatomic, retain) NSString *end_time;
@property (nullable, nonatomic, retain) NSString *follow_num;
@property (nullable, nonatomic, retain) NSString *index_img;
@property (nullable, nonatomic, retain) NSString *index_title;
@property (nullable, nonatomic, retain) NSString *list_img;
@property (nullable, nonatomic, retain) NSString *list_title;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSString *timestamp;

@end

NS_ASSUME_NONNULL_END
