//
//  PersonalInfo+CoreDataProperties.h
//  hinabian
//
//  Created by hnbwyh on 16/5/23.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PersonalInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *asset;
@property (nullable, nonatomic, retain) NSString *birthday;
@property (nullable, nonatomic, retain) NSString *education_bk;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *graduate_school;
@property (nullable, nonatomic, retain) NSString *head_url;
@property (nullable, nonatomic, retain) NSString *hobby;
@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *iets;
@property (nullable, nonatomic, retain) NSString *im_nation;
@property (nullable, nonatomic, retain) NSString *im_nation_cn;
@property (nullable, nonatomic, retain) NSString *im_state_cn;
@property (nullable, nonatomic, retain) NSString *is_assess;
@property (nullable, nonatomic, retain) NSString *indroduction;
@property (nullable, nonatomic, retain) NSString *mobile_nation;
@property (nullable, nonatomic, retain) NSString *mobile_num;
@property (nullable, nonatomic, retain) NSString *motto;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *sex_cn;
@property (nullable, nonatomic, retain) NSString *work_life;
@property (nullable, nonatomic, retain) NSString *work_life_in_tar_state;
@property (nullable, nonatomic, retain) NSString *certified;
@property (nullable, nonatomic, retain) NSString *certified_type;
@property (nullable, nonatomic, retain) NSString *certified_label;//专家特定标签
@property (nullable, nonatomic, retain) NSDictionary *levelInfo;
@property (nullable, nonatomic, retain) NSArray *moderator;
/*
 * 网易云IM的用户ID以及token
 */
@property (nonatomic,copy) NSString *netease_im_id;
@property (nonatomic,copy) NSString *netease_im_token;

@end

NS_ASSUME_NONNULL_END
