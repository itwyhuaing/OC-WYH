//
//  HTMLFactory.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "HTMLFactory.h"
#import "PLabel.h"
#import "FontLabel.h"
#import "ImgLabel.h"

@implementation HTMLFactory

+(NSString *)htmlFactoryWithTextAttributes:(NSDictionary *)attributes{
    NSString *pLabel        = [PLabel pLabelWithTextAttributes:attributes];
    NSString *fontLabel     = [FontLabel fontLabelWithTextAttributes:attributes];
    NSString *htmlContent   = [NSString stringWithFormat:@"%@%@",pLabel,fontLabel];
    
    NSLog(@"\n\n %@ \n %@ \n %@ \n\n",attributes,pLabel,fontLabel);
    
    return htmlContent;
}

@end
