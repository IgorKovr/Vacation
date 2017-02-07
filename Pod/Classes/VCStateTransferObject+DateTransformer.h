//
//  VCStateTransferObject+DateTransformer.h
//  Pods
//
//  Created by ValentineBo on 07.02.17.
//
//

#import <Vacation/Vacation.h>

@interface VCStateTransferObject (DateTransformer)

+ (NSDateFormatter *)dateFormatter;
+ (NSValueTransformer *)updated_atJSONTransformer;
+ (NSValueTransformer *)created_atJSONTransformer;
+ (MTLValueTransformer *)transformerForDates;

@end
