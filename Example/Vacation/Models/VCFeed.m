//
//  VCFeed.m
//  Vacation
//
//  Created by Igor Kovryzhkin on 4/12/16.
//  Copyright © 2016 IgorK. All rights reserved.
//

#import "VCFeed.h"
#import "VCDataStream.h"

@implementation VCFeed

+ (NSDictionary *)mappingDictionary {
    return @{@"feed_description" : @"description"};
}

- (NSString *)defaultURL {
   return @"/v2/feeds";
}

+ (NSValueTransformer *)datastreamsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:VCDataStream.class];
}

+ (NSValueTransformer *)privateJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"true"  : @1,
                                                                           @"false" : @0
                                                                           }];
}

@end