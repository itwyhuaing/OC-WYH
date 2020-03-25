//
//  QuestionFilterItem+CoreDataProperties.h
//  hinabian
//
//  Created by hnbwyh on 16/7/27.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "QuestionFilterItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuestionFilterItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *answerid;
@property (nullable, nonatomic, retain) NSString *answername;
@property (nullable, nonatomic, retain) NSString *collect;
@property (nullable, nonatomic, retain) NSString *imageurl;
@property (nullable, nonatomic, retain) NSString *ishot;
@property (nullable, nonatomic, retain) NSString *labels;
@property (nullable, nonatomic, retain) NSString *questionid;
@property (nullable, nonatomic, retain) NSString *time;
@property (nullable, nonatomic, retain) NSString *timestamp;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *userid;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSString *userhead_url;
@property (nullable, nonatomic, retain) NSString *view_num;
@property (nullable, nonatomic, retain) NSString *qadescription;
@property (nullable, nonatomic, retain) NSString *certified;
@property (nullable, nonatomic, retain) NSString *certified_type;
@property (nullable, nonatomic, retain) NSString *level;

@end

NS_ASSUME_NONNULL_END
