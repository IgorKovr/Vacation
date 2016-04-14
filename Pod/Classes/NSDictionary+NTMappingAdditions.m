//
//  NSDictionary+NTMappingAdditions.m
//  PetPhone
//
//  Created by Igor Kovryzhkin on 4/7/16.
//  Copyright © 2016 Igor Kovryzhkin. All rights reserved.
//

#import "NSDictionary+NTMappingAdditions.h"

@implementation NSDictionary (NTMappingAdditions)

+ (NSDictionary *)JSONDictionaryFromModel:(id<MTLJSONSerializing>)model additionalParams:(NSDictionary *)params removeNULL:(BOOL)removeNULL error:(NSError *)error {
    NSDictionary *allParams = [MTLJSONAdapter JSONDictionaryFromModel:model error: &error];
    NSMutableDictionary *modifiedDictionaryValue = [allParams mutableCopy];
    if (removeNULL) {
        for (NSString *originalKey in allParams) {
            NSLog(@"%@", originalKey);
            if ([allParams objectForKey:originalKey] == NSNull.null) {
                [modifiedDictionaryValue removeObjectForKey:originalKey];
            }
        }
    }
    [modifiedDictionaryValue addEntriesFromDictionary:params];
    return [modifiedDictionaryValue copy];
}


@end
