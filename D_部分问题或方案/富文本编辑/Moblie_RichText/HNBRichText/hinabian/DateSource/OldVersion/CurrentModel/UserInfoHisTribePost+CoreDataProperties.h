//
//  UserInfoHisTribePost+CoreDataProperties.h
//  hinabian
//
//  Created by hnbwyh on 16/7/27.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserInfoHisTribePost.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoHisTribePost (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *comment_brief;
@property (nullable, nonatomic, retain) NSString *comment_id;
@property (nullable, nonatomic, retain) NSString *comment_num;
@property (nullable, nonatomic, retain) NSString *ess_img;
@property (nullable, nonatomic, retain) NSString *theme_id;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *tribe_name;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *view_num;
@property (nullable, nonatomic, retain) NSString *formated_time;
@property (nullable, nonatomic, retain) NSString *formated_view_num;
@property (nullable, nonatomic, retain) NSString *timestamp;

@end

NS_ASSUME_NONNULL_END
