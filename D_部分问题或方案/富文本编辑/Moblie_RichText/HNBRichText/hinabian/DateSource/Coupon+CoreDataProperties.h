//
//  Coupon+CoreDataProperties.h
//  hinabian
//
//  Created by hnbwyh on 16/5/23.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Coupon.h"

NS_ASSUME_NONNULL_BEGIN

@interface Coupon (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *describe;
@property (nullable, nonatomic, retain) NSString *endtime;
@property (nullable, nonatomic, retain) NSString *expiring;
@property (nullable, nonatomic, retain) NSString *expiring_day;
@property (nullable, nonatomic, retain) NSString *flag;
@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *isForbid;
@property (nullable, nonatomic, retain) NSString *isLost;
@property (nullable, nonatomic, retain) NSString *isNew;
@property (nullable, nonatomic, retain) NSString *jumpdescribe;
@property (nullable, nonatomic, retain) NSString *jumpurl;
@property (nullable, nonatomic, retain) NSString *platform;
@property (nullable, nonatomic, retain) NSString *program;
@property (nullable, nonatomic, retain) NSString *quota;
@property (nullable, nonatomic, retain) NSString *starttime;
@property (nullable, nonatomic, retain) NSString *suitName;
@property (nullable, nonatomic, retain) NSString *suitTitle;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *timestamp;

@end

NS_ASSUME_NONNULL_END
