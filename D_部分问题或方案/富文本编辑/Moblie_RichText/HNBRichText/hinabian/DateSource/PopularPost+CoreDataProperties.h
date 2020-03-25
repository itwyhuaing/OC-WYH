//
//  PopularPost+CoreDataProperties.h
//  hinabian
//
//  Created by hnbwyh on 16/5/23.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PopularPost.h"

NS_ASSUME_NONNULL_BEGIN

@interface PopularPost (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *collect;
@property (nullable, nonatomic, retain) NSString *comment_num;
@property (nullable, nonatomic, retain) NSString *ess_img;
@property (nullable, nonatomic, retain) NSString *head_url;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *show_time;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSString *view_num;
@property (nullable, nonatomic, retain) NSString *timestamp;

@end

NS_ASSUME_NONNULL_END
