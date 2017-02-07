//
//  VCStateTransferObject+DateTransformer.m
//  Pods
//
//  Created by ValentineBo on 07.02.17.
//
//

#import "VCStateTransferObject+DateTransformer.h"

@implementation VCStateTransferObject (DateTransformer)

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter;
    if (dateFormatter) {
        return dateFormatter;
    }
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [dateFormatter setTimeZone:timeZone];
    dateFormatter = dateFormatter;
    
    return dateFormatter;
}

+ (NSValueTransformer *)updated_atJSONTransformer {
    return [self transformerForDates];
}

+ (NSValueTransformer *)created_atJSONTransformer {
    return [self transformerForDates];
}

+ (MTLValueTransformer *)transformerForDates {
    static MTLValueTransformer *transformerForDates;
    if (!transformerForDates) {
        transformerForDates = [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
            return [self.dateFormatter dateFromString:dateString];
        } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
            return [self.dateFormatter stringFromDate:date];
        }];
    }
    return transformerForDates;
}

@end
