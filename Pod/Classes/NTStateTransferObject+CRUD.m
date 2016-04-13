//
//  NTStateTransferObject+CRUD.m
//  PetPhone
//
//  Created by Igor Kovryzhkin on 4/7/16.
//  Copyright © 2016 RAWR. All rights reserved.
//

#import "NTStateTransferObject+CRUD.h"
#import "NSDictionary+NTMappingAdditions.h"

@implementation NTStateTransferObject (CRUD)

- (void)getWithParams:(NSDictionary *)params
              success:(void (^)(AFHTTPRequestOperation *operation, id responce))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSString *urlString = self.defaultURL;
    if (self.server_id){
        urlString = [urlString stringByAppendingPathComponent:self.server_id.stringValue];
    }
    __weak NTStateTransferObject *weakSelf = self;
    [[self.class operationManager] GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        NTStateTransferObject  *object = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:responseObject error:&error];
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
    //    if (!self.server_id){
    //        failure(nil, [NSError errorWithDomain:@"local" code:-1 userInfo:@{NSLocalizedDescriptionKey: @" is nil"}]);
    //        return;
    //    }
    __weak NTStateTransferObject *weakSelf = self;
    NSString *urlString = [self.defaultURL stringByAppendingPathComponent:self.server_id.stringValue];
    
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
        NTStateTransferObject  *object = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:responseObject error:&error];
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
    __weak NTStateTransferObject *weakSelf = self;
    NSString *urlString = self.defaultURL;
    
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
        NTStateTransferObject  *object = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:responseObject error:&error];
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
    
    NSString *urlString = self.defaultURL;
    if (self.server_id){
        urlString = [urlString stringByAppendingPathComponent:self.server_id.stringValue];
    }
    //    else {
    //        @throw [NSException exceptionWithName:NSInvalidArgumentException
    //                                       reason:[NSString stringWithFormat:@"Tried to delete object of class %@, with sererID = nil", self.class]
    //                                     userInfo:nil];
    //
    //    }
    [[self.class operationManager] DELETE:urlString parameters:nil success:success failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(operation, error);
        }
    }];
}

@end