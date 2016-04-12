//
//  NTStateTransferObject+Archiving.h
//  PetPhone
//
//  Created by Igor Kovryzhkin on 4/6/16.
//  Copyright © 2016 RAWR. All rights reserved.
//

#import "NTStateTransferObject.h"

@interface NTStateTransferObject (Archiving) <NSCoding, NSCopying>

- (BOOL) archiveToFile:(NSString *)archivePath;
+ (NTStateTransferObject *) unarchiveFromFile:(NSString *)archivePath;

@end