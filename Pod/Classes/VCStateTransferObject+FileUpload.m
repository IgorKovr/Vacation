//
//  NTObject+ImageUpload.m
//  PetPhone
//
//  Created by IgorK on 11/11/15.
//  Copyright © 2015 Igor Kovryzhkin. All rights reserved.
//

#import "VCStateTransferObject+FileUpload.h"
#import "NSDictionary+NTMappingAdditions.h"

static int TIME_OUT_INTERVAL = 800;

@implementation VCStateTransferObject (FileUpload)

- (AFHTTPRequestOperation *)uploadWithFile:(VCFileWrapper *)fileWrapper forKey:(NSString *)key params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSArray *filesArray = nil;
    if (fileWrapper)
        filesArray = @[fileWrapper];
    return [self requestMethod:@"POST" WithArrayOfFiles:filesArray forKey:key params:params success:success failure:failure];
}

- (AFHTTPRequestOperation *)uploadWithArrayOfFiles:(NSArray *)arrayOfFiles forKey:(NSString *)key params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    return [self requestMethod:@"POST" WithArrayOfFiles:arrayOfFiles forKey:key params:params success:success failure:failure];
}

- (AFHTTPRequestOperation *)updateWithArrayOfFiles:(NSArray *)arrayOfFiles forKey:(NSString *)key params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    return [self requestMethod:@"PUT" WithArrayOfFiles:arrayOfFiles forKey:key params:params success:success failure:failure];
}

- (AFHTTPRequestOperation *)updateWithFile:(VCFileWrapper *)fileWrapper forKey:(NSString *)key params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSArray *filesArray = nil;
    if (fileWrapper)
        filesArray = @[fileWrapper];
    return [self requestMethod:@"PUT" WithArrayOfFiles:filesArray forKey:key params:params success:success failure:failure];
}

#pragma mark - Private

- (AFHTTPRequestOperation *)requestMethod:(NSString *)method WithArrayOfFiles:(NSArray *)arrayOfFiles forKey:(NSString *)key params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    id constructingBodyBlock = [self multipartFormConstructionBlockWithArayOfFiles:arrayOfFiles forKey:key failureBlock:failure];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",[self manager].baseURL, self.endpointURL];
    if (self.server_id)
        url = [NSString stringWithFormat:@"%@/%@", url, self.server_id];
    
    NSError *error;
    NSURLRequest *request = [[self manager].requestSerializer multipartFormRequestWithMethod:method
                                                           URLString:url
                                                          parameters:[self dictionaryWithMegedParams:params failureBlock:failure] constructingBodyWithBlock:constructingBodyBlock
                                                               error:&error];
    if (error) {
        // Handle Error
        [self handleStateTransferError:error];
        failure(nil, error);
    }
    
    AFHTTPRequestOperation *operation = [[self manager] HTTPRequestOperationWithRequest:request
                                                                                success:[self operationSuccessHandlerWithBlock:success failure:failure]
                                                                         failure:[self operationFailureHandlerWithBlock:failure]];
    [[self manager].operationQueue addOperation:operation];
    return operation;
} 

#pragma mark multipartForm constructionBlock

- (void (^)(id <AFMultipartFormData> formData))multipartFormConstructionBlockWithArayOfFiles:(NSArray *)arrayOfFiles forKey:(NSString *)key failureBlock:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    id block = ^(id<AFMultipartFormData> formData) {
        int i = 0;
        // form mimeType
        for (VCFileWrapper *VCFileWrapper in arrayOfFiles) {
            NSString *mimeType = nil;
            switch (VCFileWrapper.fileType) {
                case FileTypePhoto:
                    mimeType = @"image/jpeg";
                    break;
                case FileTypeVideo:
                    mimeType = @"video/mp4";
                    break;
                default:
                    break;
            }
            // form imageKey
            NSString *imageName = key;
            if (arrayOfFiles.count > 1)
                // add array specificator if more than one file
                imageName = [imageName stringByAppendingString: [NSString stringWithFormat:@"[%d]",i++]];
            // specify file name if not presented
            if (!VCFileWrapper.fileName)
                VCFileWrapper.fileName  = [NSString stringWithFormat:@"image_%d.jpg",i];
            NSError *error = nil;
            
            // Make the magic happen
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:VCFileWrapper.filePath]
                                       name:imageName
                                   fileName:VCFileWrapper.fileName
                                   mimeType:mimeType
                                      error:&error];
            if (error) {
                // Handle Error
                [self handleStateTransferError:error];
                failure(nil, error);
            }
        }
    };
    return block;
}

#pragma mark responce handlers

- (void (^)(AFHTTPRequestOperation *operation, id responseObject))operationSuccessHandlerWithBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    // Take weak Self
    __weak VCStateTransferObject *weakSelf = self;
    // Generate Success Block
    id successHandler = ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        // Create & Map New NT Object
        VCStateTransferObject  *object = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:responseObject error:&error];
        if (!object){
            // Call failure block mapping fails
            failure(operation, error);
            [self handleStateTransferError:error];
        }
        // Merge new object with self
        [weakSelf mergeValuesForKeysFromModel:object];
        // Call success block
        success(operation, responseObject);
    };
    return successHandler;
}

- (void (^)(AFHTTPRequestOperation *operation, NSError *error))operationFailureHandlerWithBlock:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    id failureHandler =  ^(AFHTTPRequestOperation *operation, NSError *error) {
        // Log Error
        [self handleStateTransferError:error];
        // Call regular filure block
        failure(operation, error);
    };
    return failureHandler;
}

#pragma mark - dictionary with model params

- (NSDictionary *)dictionaryWithMegedParams:(NSDictionary *)params failureBlock:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSError *error;
    NSDictionary *allParams = [NSDictionary JSONDictionaryFromModel:self additionalParams:params removeNULL:YES error:error];
    
    if (error) {
        [self handleStateTransferError:error];
        failure(nil, error);
    }
    return allParams;
}

#pragma mark - operation manager

- (AFHTTPRequestOperationManager *)manager {
    AFHTTPRequestOperationManager *manager =  [[VCWebService sharedInstance] copy];
    // Additional timeout to upload fat files
    manager.requestSerializer.timeoutInterval = TIME_OUT_INTERVAL;
    return manager;
}

@end
