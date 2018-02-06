//
//  HotPoint+CoreDataProperties.m
//  
//
//  Created by 余坚 on 17/1/11.
//
//

#import "HotPoint+CoreDataProperties.h"

@implementation HotPoint (CoreDataProperties)

+ (NSFetchRequest<HotPoint *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"HotPoint"];
}

@dynamic f_title;
@dynamic f_sub_title;
@dynamic f_follow_num;
@dynamic f_img;
@dynamic f_url;
@dynamic timestamp;

@end
