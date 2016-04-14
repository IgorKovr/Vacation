//
//  VCWebService.h
//  Antresol
//
//  Created by Igor Kovrizhkin on 3/21/14.
//  Copyright (c) 2014 Igor Kovrizhkin. All rights reserved.
//

#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "VCFileWrapper.h"

@interface VCWebService : AFHTTPRequestOperationManager

+ (instancetype) sharedInstance;
+ (instancetype) setBaseURL:(NSString *)url;

@end