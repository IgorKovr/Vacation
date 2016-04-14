//
//  VCWebService.m
//  Antresol
//
//  Created by Igor Kovrizhkin on 3/21/14.
//  Copyright (c) 2014 Igor Kovrizhkin. All rights reserved.
//

#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "VCWebService.h"

@implementation VCWebService

#pragma mark - Allocators

static VCWebService* sharedInstance = nil;
static dispatch_once_t oncePredicate;

+ (instancetype)sharedInstance {
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[VCWebService alloc] initWithBaseURL:nil];
    });
    return sharedInstance;
}

+ (instancetype)setBaseURL:(NSString *)url {
    dispatch_once(&oncePredicate, ^{
        NSURL *baseUrl = [NSURL URLWithString:url];
        sharedInstance = [[VCWebService alloc] initWithBaseURL:baseUrl];
    });
    return sharedInstance;
}

#pragma mark - Instance initialization

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
    
    self.securityPolicy.allowInvalidCertificates = YES;
    
    NSString *apiKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"X-ApiKey"];
    [self.requestSerializer setValue:apiKey forHTTPHeaderField:@"X-ApiKey"];
    return self;
}

@end