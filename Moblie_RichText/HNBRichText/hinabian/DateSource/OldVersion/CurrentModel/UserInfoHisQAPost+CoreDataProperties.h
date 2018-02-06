//
//  UserInfoHisQAPost+CoreDataProperties.h
//  hinabian
//
//  Created by hnbwyh on 16/7/28.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserInfoHisQAPost.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoHisQAPost (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *comment_brief;
@property (nullable, nonatomic, retain) NSString *content;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *formated_time;
@property (nullable, nonatomic, retain) NSString *question_id;
@property (nullable, nonatomic, retain) NSString *answer_id;
@property (nullable, nonatomic, retain) NSString *answer_num;
@property (nullable, nonatomic, retain) NSString *view_num;
@property (nullable, nonatomic, retain) NSString *label;
@property (nullable, nonatomic, retain) NSString *timestamp;

@end

NS_ASSUME_NONNULL_END
