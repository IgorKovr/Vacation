//
//  VCStateTransferObject.m
//  PetPhone
//
//  Created by Igor Kovryzhkin on 4/6/16.
//  Copyright © 2016 Igor Kovryzhkin. All rights reserved.
//

#import "VCStateTransferObject.h"

@implementation VCStateTransferObject

+ (AFHTTPRequestOperationManager *)operationManager {
    return [VCWebService sharedInstance];
}

+ (NSDictionary *)mappingDictionary {
    return @{
             @"server_id": @"id",
             @"created_at": @"created_at",
             @"updated_at": @"updated_at"
             };
}

- (NSArray *)permitParameterKeys {
    return nil;
}

- (NSArray *)filterParametersKeys {
    return nil;
}

- (NSString *)endpointURL {
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:[NSString stringWithFormat:@"Need to override -endpointURL in %@, cmd: %@", [self class], NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void)handleStateTransferError:(NSError *)error {
    NSLog(@"State transfer Error: %@", error.localizedDescription);
}

#pragma mark - Overriding MTLModel methods

/*!
 @abstract overrides MTLModel +JSONKeyPathsByPropertyKey to set mapping Dictionary with existing parameter names by default
 @abstract instead of overriding this method provide -mappingDictionary for mapping
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *keyPathsByPropertyKey = [NSDictionary mtl_identityPropertyMapWithModel:self];
    NSDictionary *mappingDictionary = [self mappingDictionary];
    if (mappingDictionary)
        keyPathsByPropertyKey = [keyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:mappingDictionary];
    return keyPathsByPropertyKey;
}

#pragma mark Merging parameters from two VCStateTransferObjects

/*!
 @abstract overrides MTLModel -mergeValueForKey to ignore nill values from the incomming model
 @abstract ovveride this method in your model to accept nill values from model
 */
- (void)mergeValueForKey:(NSString *)key fromModel:(NSObject<MTLModel> *)model acceptNULL:(BOOL)acceptNULL {
    NSParameterAssert(key != nil);
    SEL selector = MTLSelectorWithCapitalizedKeyPattern("merge", key, "FromModel:");
    if (![self respondsToSelector:selector]) {
        if (model != nil) {
            id value = [model valueForKey:key];
            if (value != nil) {
                if (value != (id)[NSNull null] || acceptNULL){
                    [self setValue:value forKey:key];
                }
            }
        }
        return;
    }
    
    IMP imp = [self methodForSelector:selector];
    void (*function)(id, SEL, id<MTLModel>) = (__typeof__(function))imp;
    function(self, selector, model);
}

- (void)mergeValuesForKeysFromModel:(id<MTLModel>)model acceptNULL:(BOOL)acceptNULL{
    NSSet *propertyKeys = model.class.propertyKeys;
    for (NSString *key in self.class.propertyKeys) {
        if (![propertyKeys containsObject:key]) continue;
        [self mergeValueForKey:key fromModel:model acceptNULL:acceptNULL];
    }
}

/*!
 @abstract overrides MTLModel -dictionaryValue so it checks for -permitParameterKeys and -filterParametersKeys first
 */
- (NSDictionary *)dictionaryValue {
    if ([self permitParameterKeys])
        return [[super dictionaryValue] dictionaryWithValuesForKeys:[self permitParameterKeys]];
    else
        if ([self filterParametersKeys])
            return [[super dictionaryValue] mtl_dictionaryByRemovingValuesForKeys:[self filterParametersKeys]];
        else
            return [super dictionaryValue];
}


@end
