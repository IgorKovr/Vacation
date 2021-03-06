//
//  NSDictionary+NTMappingAdditions.h
//  PetPhone
//
//  Created by Igor Kovryzhkin on 4/7/16.
//  Copyright © 2016 Igor Kovryzhkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface NSDictionary (NTMappingAdditions)

+ (NSArray *)JSONArrayForModels:(NSArray *)models additionalParams:(NSDictionary *)params removeNULL:(BOOL)removeNULL error:(NSError *)error;

+ (NSDictionary *)JSONDictionaryFromModel:(id<MTLJSONSerializing>)model additionalParams:(NSDictionary *)params removeNULL:(BOOL)removeNULL error:(NSError *)error;

- (NSDictionary *)removeNULLFromDictionary;

@end
