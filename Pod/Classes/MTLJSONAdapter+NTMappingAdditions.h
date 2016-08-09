//
//  MTLJSONAdapter+NTMappingAdditions.h
//  Pods
//
//  Created by Igor Kovryzhkin on 8/8/16.
//
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface MTLJSONAdapter (NTMappingAdditions)

+ (NSArray *)JSONArrayForModels:(NSArray *)models additionalParams:(NSDictionary *)params removeNULL:(BOOL)removeNULL error:(NSError *)error;

+ (NSDictionary *)JSONDictionaryFromModel:(id<MTLJSONSerializing>)model additionalParams:(NSDictionary *)params removeNULL:(BOOL)removeNULL error:(NSError *)error;

@end
