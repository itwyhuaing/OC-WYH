//
//  PersonalInfo+CoreDataProperties.m
//  
//
//  Created by hnbwyh on 2018/8/8.
//
//

#import "PersonalInfo+CoreDataProperties.h"

@implementation PersonalInfo (CoreDataProperties)

+ (NSFetchRequest<PersonalInfo *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"PersonalInfo"];
}

@dynamic head_url;
@dynamic levelInfo;
@dynamic moderator;

@end
