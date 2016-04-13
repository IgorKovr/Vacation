//
//  NTWebService.h
//  Antresol
//
//  Created by Igor Kovrizhkin on 3/21/14.
//  Copyright (c) 2014 Igor Kovrizhkin. All rights reserved.
//

#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "FileWrapper.h"

@interface NTWebService : AFHTTPRequestOperationManager

+ (instancetype) sharedInstance;
+ (instancetype) setBaseURL:(NSString *)url;

@end