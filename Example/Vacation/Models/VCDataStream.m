//
//  VCDataStream.m
//  Vacation
//
//  Created by Igor Kovryzhkin on 4/12/16.
//  Copyright © 2016 IgorK. All rights reserved.
//

#import "VCDataStream.h"
#import "VCDataPoint.h"

@implementation VCDataStream

- (NSString *)defaultURL {
    NSString *endpoint = @"/v2/feeds/1799206591/datastreams/";
    return [endpoint stringByAppendingPathComponent:self.title];
}

+ (NSDictionary *)mappingDictionary {
    return @{@"title" : @"id"};
}

+ (NSValueTransformer *)datapointsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:VCDataPoint.class];
}

@end