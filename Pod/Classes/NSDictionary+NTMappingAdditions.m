//
//  NSDictionary+NTMappingAdditions.m
//  PetPhone
//
//  Created by Igor Kovryzhkin on 4/7/16.
//  Copyright © 2016 Igor Kovryzhkin. All rights reserved.
//

#import "NSDictionary+NTMappingAdditions.h"

@implementation NSDictionary (NTMappingAdditions)

+ (NSArray *)JSONArrayForModels:(NSArray *)models additionalParams:(NSDictionary *)params removeNULL:(BOOL)removeNULL error:(NSError *)error {
    NSMutableArray *jsonArray = [NSMutableArray new];
    if (!models.count)
        return nil;
    
    for (id<MTLJSONSerializing>model in models) {
        NSDictionary *allParams = [MTLJSONAdapter JSONDictionaryFromModel:model error: &error];
        if (removeNULL) {
            allParams = [allParams removeNULLFromDictionary];
        }
        if (params) {
            NSMutableDictionary *modifiedDictionaryValue = [[allParams removeNULLFromDictionary] mutableCopy];
            [modifiedDictionaryValue addEntriesFromDictionary:params];
            allParams = [modifiedDictionaryValue copy];
        }
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

- (NSDictionary *)removeNULLFromDictionary {
    NSMutableDictionary *modifiedDictionaryValue = [self mutableCopy];
    
    for (NSString *originalKey in self) {
        id testedParam = [self objectForKey:originalKey];
        
        if (testedParam == NSNull.null) {
            [modifiedDictionaryValue removeObjectForKey:originalKey];
        }
        
        if ([testedParam isKindOfClass:[NSArray class]]) {
            NSMutableArray *arrayCopy = [testedParam mutableCopy];
            int i =0;
            BOOL isModified = false;
            for (id nestedObject in testedParam) {
                if ([nestedObject isKindOfClass:[NSDictionary class]]) {
                    [arrayCopy replaceObjectAtIndex:i withObject: [nestedObject removeNULLFromDictionary]];
                    isModified = true;
                }
                i++;
            }
            if (isModified)
                [modifiedDictionaryValue setObject:[arrayCopy copy] forKey:originalKey];
        }
        
        if ([testedParam isKindOfClass:[NSDictionary class]]) {
            testedParam = [testedParam removeNULLFromDictionary];
        }
    }
    
    return [modifiedDictionaryValue copy];
}

@end
