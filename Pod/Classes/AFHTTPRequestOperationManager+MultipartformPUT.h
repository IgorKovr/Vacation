//
//  AFHTTPRequestOperationManager+MultipartformPUT.h
//  PetPhone
//
//  Created by Igor Kovryzhkin on 4/11/16.
//  Copyright © 2016 Igor Kovryzhkin. All rights reserved.
//

#import <AFNetworking/AFHTTPRequestOperationManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTPRequestOperationManager (MultipartformPUT)

- (nullable AFHTTPRequestOperation *)PUT:(NSString *)URLString
                              parameters:(nullable id)parameters
               constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                 success:(nullable void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                 failure:(nullable void (^)(AFHTTPRequestOperation * __nullable operation, NSError *error))failure;

@end

NS_ASSUME_NONNULL_END