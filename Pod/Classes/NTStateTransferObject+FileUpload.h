//
//  NTObject+ImageUpload.h
//  PetPhone
//
//  Created by IgorK on 11/11/15.
//  Copyright © 2015 Igor Kovryzhkin. All rights reserved.
//

#import "NTStateTransferObject.h"

@interface NTStateTransferObject (FileUpload)

/*!
 @abstract Uploads model via POST
 @params key key that will represent file in json
 @params params additional parameters dictionary
 */
- (void)uploadWithFile:(FileWrapper *)fileWrapper forKey:(NSString *)key params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/*!
 @abstract Uploads model via POST
 @params arrayOfFiles aray of FileWrapper objects
 @params key that will represent file array in json
 @params params additional parameters dictionary
 */
- (void)uploadWithArrayOfFiles:(NSArray *)arrayOfFiles forKey:(NSString *)key params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/*!
 @abstract Updates model state via PUT
 @params arrayOfFiles aray of FileWrapper objects
 @params key that will represent file array in json
 @params params additional parameters dictionary
 */
- (void)updateWithArrayOfFiles:(NSArray *)arrayOfFiles forKey:(NSString *)key params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
