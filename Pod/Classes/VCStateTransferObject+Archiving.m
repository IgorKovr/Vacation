//
//  VCStateTransferObject+Archiving.m
//  PetPhone
//
//  Created by Igor Kovryzhkin on 4/6/16.
//  Copyright © 2016 Igor Kovryzhkin. All rights reserved.
//

#import "VCStateTransferObject+Archiving.h"

// Used in archives to store the modelVersion of the archived instance.
static NSString * const MTLModelVersionKey = @"MTLModelVersion";

@implementation VCStateTransferObject (Archiving)

#pragma mark - Archiving

- (BOOL) archiveToFile:(NSString *)archivePath {
    NSMutableData *archiveData = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archiveData];
    
    [self encodeWithCoder:archiver];
    [archiver finishEncoding];
    BOOL result = [archiveData writeToFile:archivePath atomically:YES];
    return result;
}

+ (VCStateTransferObject *) unarchiveFromFile:(NSString *)archivePath {
    NSData *archiveData = [[NSData alloc] initWithContentsOfFile:archivePath];
    if (!archiveData)
        return nil;
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:archiveData];
    VCStateTransferObject *model;
    if (![unarchiver containsValueForKey:@"root"]) {
        model = [[[self class] alloc] initWithCoder:unarchiver];
    } else {
        NSLog(@"error: you should use 'archiveToFile:' method to unarchive with 'unarchiveFromFile:'");
    }
    [unarchiver finishDecoding];
    return model;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:@(self.class.modelVersion) forKey:MTLModelVersionKey];
    
    NSDictionary *encodingBehaviors = self.class.encodingBehaviorsByPropertyKey;
    [self.archiveDictionaryValue enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
        @try {
            // Skip nil values.
            if ([value isEqual:NSNull.null]) return;
            
            switch ([encodingBehaviors[key] unsignedIntegerValue]) {
                    // This will also match a nil behavior.
                case MTLModelEncodingBehaviorExcluded:
                    break;
                    
                case MTLModelEncodingBehaviorUnconditional:
                    [coder encodeObject:value forKey:key];
                    break;
                    
                case MTLModelEncodingBehaviorConditional:
                    [coder encodeConditionalObject:value forKey:key];
                    break;
                    
                default:
                    NSAssert(NO, @"Unrecognized encoding behavior %@ on class %@ for key \"%@\"", self.class, encodingBehaviors[key], key);
            }
        } @catch (NSException *ex) {
            NSLog(@"*** Caught exception encoding value for key \"%@\" on class %@: %@", key, self.class, ex);
            @throw ex;
        }
    }];
}

- (NSDictionary *)archiveDictionaryValue {
    return [super dictionaryValue];
}

@end
