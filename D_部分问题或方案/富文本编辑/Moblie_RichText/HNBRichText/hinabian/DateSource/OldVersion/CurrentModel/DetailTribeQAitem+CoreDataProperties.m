//
//  DetailTribeQAitem+CoreDataProperties.m
//  
//
//  Created by hnbwyh on 17/4/19.
//
//

#import "DetailTribeQAitem+CoreDataProperties.h"

@implementation DetailTribeQAitem (CoreDataProperties)

+ (NSFetchRequest<DetailTribeQAitem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DetailTribeQAitem"];
}

@dynamic title;
@dynamic questionid;
@dynamic answerid;
@dynamic answername;
@dynamic qadescription;
@dynamic userhead_url;
@dynamic userid;
@dynamic username;
@dynamic labels;
@dynamic view_num;
@dynamic certified;
@dynamic certified_type;
@dynamic level;
@dynamic collect;
@dynamic timestamp;
@dynamic time;
@dynamic tribe_id;

@end
