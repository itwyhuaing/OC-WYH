//
//  NSURL+ChangeScheme.m
//  WKLocalImagesDemo
//
//  Created by hnbwyh on 2021/1/14.
//

#import "NSURL+ChangeScheme.h"

@implementation NSURL (ChangeScheme)

- (NSURLComponents *)extracted {
    NSURLComponents *cpts = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:TRUE];
    return cpts;
}

-(NSURL *)changeURLSchemeWithName:(NSString *)name {
    NSURLComponents * cpts = [self extracted];
    cpts.scheme = name;
    return cpts.URL;
}

@end
