//
//  CODActivityIndex.h
//  hinabian
//
//  Created by 何松泽 on 17/1/11.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>


@interface CODActivityIndex : NSObject

// Insert code here to declare functionality of your managed object subclass
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *img;
@property (copy, nonatomic) NSString *is_new;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *view_num;

@end

