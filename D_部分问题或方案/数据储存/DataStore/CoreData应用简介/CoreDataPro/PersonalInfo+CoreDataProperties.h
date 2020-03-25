//
//  PersonalInfo+CoreDataProperties.h
//  
//
//  Created by hnbwyh on 2018/8/8.
//
//

#import "PersonalInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PersonalInfo (CoreDataProperties)

+ (NSFetchRequest<PersonalInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *head_url;
@property (nullable, nonatomic, retain) NSObject *levelInfo;
@property (nullable, nonatomic, retain) NSObject *moderator;

@end

NS_ASSUME_NONNULL_END
