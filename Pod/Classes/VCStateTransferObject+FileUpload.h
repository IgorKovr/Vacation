//
//  NTObject+ImageUpload.h
//  PetPhone
//
//  Created by IgorK on 11/11/15.
//  Copyright © 2015 Igor Kovryzhkin. All rights reserved.
//

#import "VCStateTransferObject.h"

@interface VCStateTransferObject (FileUpload)

/*!
 @abstract Uploads model via POST
 @params fileWrapper - File To be uploaded
 @params key key that will represent file in json
 @params params additional parameters dictionary
 */
- (AFHTTPRequestOperation *)uploadWithFile:(VCFileWrapper *)fileWrapper forKey:(NSString *)key params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/*!
 @abstract Uploads model via POST
 @params arrayOfFiles aray of VCFileWrapper objects
 @params key that will represent file array in json
 @params params additional parameters dictionary
 */
- (AFHTTPRequestOperation *)uploadWithArrayOfFiles:(NSArray *)arrayOfFiles forKey:(NSString *)key params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/*!
 @abstract Updates model state via PUT
 @params arrayOfFiles aray of VCFileWrapper objects
 @params key that will represent file array in json
 @params params additional parameters dictionary
 */
- (AFHTTPRequestOperation *)updateWithArrayOfFiles:(NSArray *)arrayOfFiles forKey:(NSString *)key params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/*!
 @abstract Updates model state via PUT
 @params fileWrapper - File To be uploaded
 @params key that will represent file array in json
 @params params additional parameters dictionary
 */
- (AFHTTPRequestOperation *)updateWithFile:(VCFileWrapper *)fileWrapper forKey:(NSString *)key params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
