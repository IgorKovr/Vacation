//
//  VCStateTransferObject+CRUD.m
//  PetPhone
//
//  Created by Igor Kovryzhkin on 4/7/16.
//  Copyright © 2016 Igor Kovryzhkin. All rights reserved.
//

#import "VCStateTransferObject+CRUD.h"
#import "NSDictionary+NTMappingAdditions.h"

@implementation VCStateTransferObject (CRUD)

- (void)getWithParams:(NSDictionary *)params
              success:(void (^)(AFHTTPRequestOperation *operation, id responce))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSString *urlString = self.endpointURL;
    if (self.server_id){
        urlString = [urlString stringByAppendingPathComponent:self.server_id.stringValue];
    }
    __weak VCStateTransferObject *weakSelf = self;
    [[self.class operationManager] GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        VCStateTransferObject  *object = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:responseObject error:&error];
        if (!object){
            failure(operation, error);
            [self handleStateTransferError:error];
        }
        [weakSelf mergeValuesForKeysFromModel:object];
        if (success)
            success(operation, responseObject);
    } failure:failure];
}

- (void)updateWithParams:(NSDictionary *)params
                 success:(void (^)(AFHTTPRequestOperation *operation, id responce))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    __weak VCStateTransferObject *weakSelf = self;
    NSString *urlString = [self.endpointURL stringByAppendingPathComponent:self.server_id.stringValue];
    
    NSError *error;
    NSDictionary *allParams = [NSDictionary JSONDictionaryFromModel:self
                                                   additionalParams:params
                                                         removeNULL:YES
                                                              error:error];
    if (error) {
        if (failure) {
            failure(nil, error);
        }
        [self handleStateTransferError:error];
    }
    
    [[self.class operationManager] PUT:urlString parameters:allParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        VCStateTransferObject  *object = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:responseObject error:&error];
        if (!object) {
            if (failure) {
                failure(operation, error);
            }
            [self handleStateTransferError:error];
        }
        [weakSelf mergeValuesForKeysFromModel:object];
        success(operation, responseObject);
    } failure:failure];
}

- (void)createWithParams:(NSDictionary *)params
                 success:(void (^)(AFHTTPRequestOperation *operation, id responce))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    __weak VCStateTransferObject *weakSelf = self;
    NSString *urlString = self.endpointURL;
    
    if (weakSelf.server_id)
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:[NSString stringWithFormat:@"Tried to create already existing object of class %@ with server_id: %@", self.class, self.server_id]
                                     userInfo:nil];
    
    NSError *error;
    NSDictionary *allParams = [NSDictionary JSONDictionaryFromModel:self
                                                   additionalParams:params
                                                         removeNULL:YES
                                                              error:error];
    if (error) {
        if (failure) {
            failure(nil, error);
        }
        [self handleStateTransferError:error];
    }
    [[self.class operationManager] POST:urlString parameters:[allParams copy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        VCStateTransferObject  *object = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:responseObject error:&error];
        if (!object){
            failure(operation, error);
            [self handleStateTransferError:error];
        }
        [weakSelf mergeValuesForKeysFromModel:object];
        success(operation, responseObject);
    } failure:failure];
}

- (void)deleteSuccess:(void (^)(AFHTTPRequestOperation *, id))success
              failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    NSString *urlString = self.endpointURL;
    if (self.server_id){
        urlString = [urlString stringByAppendingPathComponent:self.server_id.stringValue];
    }
    [[self.class operationManager] DELETE:urlString parameters:nil success:success failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(operation, error);
        }
    }];
}

@end