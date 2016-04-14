//
//  VCFileWrapper.h
//  PetPhone
//
//  Created by Igor Kovryzhkin on 4/11/16.
//  Copyright © 2016 Igor Kovryzhkin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FileType) {
    FileTypePhoto,
    FileTypeVideo,
};

@interface VCFileWrapper : NSObject

@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *fileName;
@property (assign, nonatomic) FileType fileType;

@end