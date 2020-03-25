//
//  HotPoint+CoreDataProperties.h
//  
//
//  Created by 余坚 on 17/1/11.
//
//

#import "HotPoint+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface HotPoint (CoreDataProperties)

+ (NSFetchRequest<HotPoint *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *f_title;
@property (nullable, nonatomic, copy) NSString *f_sub_title;
@property (nullable, nonatomic, copy) NSString *f_follow_num;
@property (nullable, nonatomic, copy) NSString *f_img;
@property (nullable, nonatomic, copy) NSString *f_url;
@property (nullable, nonatomic, copy) NSString *timestamp;

@end

NS_ASSUME_NONNULL_END
