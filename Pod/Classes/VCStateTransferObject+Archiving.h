//
//  VCStateTransferObject+Archiving.h
//  PetPhone
//
//  Created by Igor Kovryzhkin on 4/6/16.
//  Copyright © 2016 Igor Kovryzhkin. All rights reserved.
//

#import "VCStateTransferObject.h"

@interface VCStateTransferObject (Archiving) <NSCoding, NSCopying>

- (BOOL) archiveToFile:(NSString *)archivePath;
+ (VCStateTransferObject *) unarchiveFromFile:(NSString *)archivePath;

@end