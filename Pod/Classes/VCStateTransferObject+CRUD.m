//
//  VCStateTransferObject+CRUD.m
//  PetPhone
//
//  Created by Igor Kovryzhkin on 4/7/16.
//  Copyright © 2016 Igor Kovryzhkin. All rights reserved.
//

#import "VCStateTransferObject+CRUD.h"
#import "NSDictionary+NTMappingAdditions.h"
#import "MTLJSONAdapter+NTMappingAdditions.h"

@implementation VCStateTransferObject (CRUD)

- (AFHTTPRequestOperation *)getWithParams:(NSDictionary *)params
                                customURL:(NSString *)urlString
                         acceptNULLValues:(BOOL)acceptNULL
                                  success:(void (^)(AFHTTPRequestOperation *operation, id responce))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    if (!urlString)
        urlString = self.endpointURL;
    if (self.server_id){
        urlString = [urlString stringByAppendingPathComponent:self.server_id.stringValue];
    }
    __weak VCStateTransferObject *weakSelf = self;
    return [[self.class operationManager] GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        VCStateTransferObject  *object = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:responseObject error:&error];
        if (!object){
            failure(operation, error);
            [self handleStateTransferError:error];
        }
        [weakSelf mergeValuesForKeysFromModel:object acceptNULL:acceptNULL];
        if (success)
            success(operation, responseObject);
    } failure:failure];
}

- (AFHTTPRequestOperation *)getWithParams:(NSDictionary *)params
              success:(void (^)(AFHTTPRequestOperation *operation, id responce))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    return [self getWithParams:params customURL:nil acceptNULLValues:false success:success failure:failure];
}

- (AFHTTPRequestOperation *)createWithParams:(NSDictionary *)params
                                   customURL:(NSString *)urlString
                            acceptNULLValues:(BOOL)acceptNULL
                                     success:(void (^)(AFHTTPRequestOperation *operation, id responce))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    if (!urlString)
        urlString = self.endpointURL;
    
    __weak VCStateTransferObject *weakSelf = self;
    
    
    NSError *error;
    NSDictionary *allParams = [MTLJSONAdapter JSONDictionaryFromModel:self
                                                     additionalParams:params
                                                           removeNULL:YES
                                                                error:error];
    if (error) {
        if (failure) {
            failure(nil, error);
        }
        [self handleStateTransferError:error];
    }
    return [[self.class operationManager] POST:urlString parameters:[allParams copy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        VCStateTransferObject  *object = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:responseObject error:&error];
        if (!object){
            failure(operation, error);
            [self handleStateTransferError:error];
        }
        [weakSelf mergeValuesForKeysFromModel:object acceptNULL:acceptNULL];
        success(operation, responseObject);
    } failure:failure];
}

- (AFHTTPRequestOperation *)createWithParams:(NSDictionary *)params
                 success:(void (^)(AFHTTPRequestOperation *operation, id responce))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    return [self createWithParams:params customURL:nil acceptNULLValues:false success:success failure:failure];
}


- (AFHTTPRequestOperation *)updateWithParams:(NSDictionary *)params
                                   customURL:(NSString *)urlString
                            acceptNULLValues:(BOOL)acceptNULL
                                     success:(void (^)(AFHTTPRequestOperation *operation, id responce))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    if (!urlString)
        urlString = [self.endpointURL stringByAppendingPathComponent:self.server_id.stringValue];
    
    __weak VCStateTransferObject *weakSelf = self;
    NSError *error;
    NSDictionary *allParams = [MTLJSONAdapter JSONDictionaryFromModel:self
                                                     additionalParams:params
                                                           removeNULL:YES
                                                                error:error];
    if (error) {
        if (failure) {
            failure(nil, error);
        }
        [self handleStateTransferError:error];
    }
    
    return [[self.class operationManager] PUT:urlString parameters:allParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        VCStateTransferObject  *object = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:responseObject error:&error];
        if (!object) {
            if (failure) {
                failure(operation, error);
            }
            [self handleStateTransferError:error];
        }
        [weakSelf mergeValuesForKeysFromModel:object acceptNULL:acceptNULL];
        success(operation, responseObject);
    } failure:failure];
}

- (AFHTTPRequestOperation *)updateWithParams:(NSDictionary *)params
                                     success:(void (^)(AFHTTPRequestOperation *operation, id responce))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    return [self updateWithParams:params customURL:nil acceptNULLValues:false success:success failure:failure];
}

- (AFHTTPRequestOperation *)deleteSuccess:(void (^)(AFHTTPRequestOperation *, id))success
              failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    NSString *urlString = self.endpointURL;
    if (self.server_id){
        urlString = [urlString stringByAppendingPathComponent:self.server_id.stringValue];
    }
    return [[self.class operationManager] DELETE:urlString parameters:nil success:success failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(operation, error);
        }
    }];
}

@end
