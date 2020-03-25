//
//  DataHandler.h
//  hinabian
//
//  Created by hnbwyh on 16/5/11.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DataHandlerComplete)(id info);

@interface DataHandler : NSObject

+ (void)doGetAllTribesHandleData:(id)responseObject complete:(DataHandlerComplete)completion;

@end
