//
//  MTLJSONAdapter+NTMappingAdditions.m
//  Pods
//
//  Created by Igor Kovryzhkin on 8/8/16.
//
//

#import "MTLJSONAdapter+NTMappingAdditions.h"
#import "NSDictionary+NTMappingAdditions.h"

@implementation MTLJSONAdapter (NTMappingAdditions)

+ (NSArray *)JSONArrayForModels:(NSArray *)models additionalParams:(NSDictionary *)params removeNULL:(BOOL)removeNULL error:(NSError *)error {
    NSMutableArray *jsonArray = [NSMutableArray new];
    if (!models.count)
        return nil;
    
    for (id<MTLJSONSerializing>model in models) {
        NSDictionary *allParams = [self JSONDictionaryFromModel:model additionalParams:params removeNULL:removeNULL error:error];
        if (allParams)
            [jsonArray addObject:allParams];
    }
    
    return [jsonArray copy];;
}

+ (NSDictionary *)JSONDictionaryFromModel:(id<MTLJSONSerializing>)model additionalParams:(NSDictionary *)params removeNULL:(BOOL)removeNULL error:(NSError *)error {
    NSDictionary *allParams = [MTLJSONAdapter JSONDictionaryFromModel:model error: &error];
    if (removeNULL) {
        allParams = [allParams removeNULLFromDictionary];
    }
    if (params) {
        NSMutableDictionary *modifiedDictionaryValue = [[allParams removeNULLFromDictionary] mutableCopy];
        [modifiedDictionaryValue addEntriesFromDictionary:params];
        allParams = [modifiedDictionaryValue copy];
    }
    return allParams;
}

@end
