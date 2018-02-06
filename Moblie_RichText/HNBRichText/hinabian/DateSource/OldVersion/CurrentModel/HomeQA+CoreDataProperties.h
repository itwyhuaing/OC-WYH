//
//  HomeQA+CoreDataProperties.h
//  hinabian
//
//  Created by hnbwyh on 16/5/31.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HomeQA.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeQA (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) NSString *img;
@property (nullable, nonatomic, retain) NSString *labelGroup;
@property (nullable, nonatomic, retain) NSString *questionId;
@property (nullable, nonatomic, retain) NSString *related_num;
@property (nullable, nonatomic, retain) NSString *timestamp;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *configLabelGroupId;

@end

NS_ASSUME_NONNULL_END
