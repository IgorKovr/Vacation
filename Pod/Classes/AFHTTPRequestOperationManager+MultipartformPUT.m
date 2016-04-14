//
//  AFHTTPRequestOperationManager+MultipartformPUT.m
//  PetPhone
//
//  Created by Igor Kovryzhkin on 4/11/16.
//  Copyright © 2016 Igor Kovryzhkin. All rights reserved.
//

#import "AFHTTPRequestOperationManager+MultipartformPUT.h"

@implementation AFHTTPRequestOperationManager (MultipartformPUT)

- (nullable AFHTTPRequestOperation *)PUT:(NSString *)URLString
                              parameters:(nullable id)parameters
               constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                 success:(nullable void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                 failure:(nullable void (^)(AFHTTPRequestOperation * __nullable operation, NSError *error))failure {
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"PUT" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        return nil;
    }
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self.operationQueue addOperation:operation];
    return operation;
}

@end
