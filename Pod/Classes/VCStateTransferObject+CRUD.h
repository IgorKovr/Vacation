//
//  VCStateTransferObject+CRUD.h
//  PetPhone
//
//  Created by Igor Kovryzhkin on 4/7/16.
//  Copyright © 2016 Igor Kovryzhkin. All rights reserved.
//

#import "VCStateTransferObject.h"

@interface VCStateTransferObject (CRUD)

/*!
 @abstract sends GET request for object -endpointURL. Maps returned JSON values onto the same object on which the method was called. Use this method to <b>obtain new data</b> for object.
 @param params parameters that will be sent in json.
 @param customURL a special url provided for request. If nil +endpointURL method of VCStateTransferObject will be used
 @param acceptNULLValues if true - rewrites parameters which came NULL from server
 @param success a block called if response code is 201(created), and received values are successfully mapped.
 @param failure a block called if any error occures. Contains error message and AFHTTPRequestOperation instance if request was made.
 */
- (AFHTTPRequestOperation *)getWithParams:(NSDictionary *)params
                                customURL:(NSString *)urlString
                         acceptNULLValues:(BOOL)acceptNULL
                                  success:(void (^)(AFHTTPRequestOperation *operation, id responce))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/*!
 @abstract sends GET request for object -endpointURL. Maps returned JSON values onto the same object on which the method was called. Use this method to <b>obtain new data</b> for object.
 @param params parameters that will be sent in json.
 @param success a block called if response code is 201(created), and received values are successfully mapped.
 @param failure a block called if any error occures. Contains error message and AFHTTPRequestOperation instance if request was made.
 */
- (AFHTTPRequestOperation *)getWithParams:(NSDictionary *)params
                                  success:(void (^)(AFHTTPRequestOperation *operation, id responce))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/*!
 @abstract sends POST request with object parameters using -JSONDictionaryFromModel: . Maps returned JSON values onto the same object on which the method was called. Use this method to <b>crate</b> the object representation on the server.
 @param params additional parameters that will be sent in json. Overrides object values for same keys.
 @param customURL a special url provided for request. If nil +endpointURL method of VCStateTransferObject will be used
 @param acceptNULLValues if true - rewrites parameters which came NULL from server
 @param success a block called if response code is 201(created), and received values are successfully mapped.
 @param failure a block called if any error occures. Contains error message and AFHTTPRequestOperation instance if request was made.

 */
- (AFHTTPRequestOperation *)createWithParams:(NSDictionary *)params
                                   customURL:(NSString *)urlString
                            acceptNULLValues:(BOOL)acceptNULL
                                     success:(void (^)(AFHTTPRequestOperation *operation, id responce))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/*!
 @abstract sends POST request with object parameters using -JSONDictionaryFromModel: . Maps returned JSON values onto the same object on which the method was called. Use this method to <b>crate</b> the object representation on the server.
 @param params additional parameters that will be sent in json. Overrides object values for same keys.
 @param success a block called if response code is 201(created), and received values are successfully mapped.
 @param failure a block called if any error occures. Contains error message and AFHTTPRequestOperation instance if request was made.
 */
- (AFHTTPRequestOperation *)createWithParams:(NSDictionary *)params
                                     success:(void (^)(AFHTTPRequestOperation *operation, id responce))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


/*!
 @abstract sends PUT request with object parameters using -JSONDictionaryFromModel: . Maps returned JSON values onto the same object on which the method was called. Use this method to <b>update</b> the object representation on the server.
 @param acceptNULLValues if true - rewrites parameters which came NULL from server
 @param params additional parameters that will be sent in json. Overrides object values for same keys.
 @param success a block, called if response code is 200(ok), and received values are successfully mapped.
 @param failure a block called if any error occures. Contains error message and AFHTTPRequestOperation instance if request was made.
 */
- (AFHTTPRequestOperation *)updateWithParams:(NSDictionary *)params
                                     success:(void (^)(AFHTTPRequestOperation *operation, id responce))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/*!
 @abstract sends PUT request with object parameters using -JSONDictionaryFromModel: . Maps returned JSON values onto the same object on which the method was called. Use this method to <b>update</b> the object representation on the server.
 @param params additional parameters that will be sent in json. Overrides object values for same keys.
 @param customURL a special url provided for request. If nil +endpointURL method of VCStateTransferObject will be used
 @param acceptNULLValues if true - rewrites parameters which came NULL from server
 @param success a block, called if response code is 200(ok), and received values are successfully mapped.
 @param failure a block called if any error occures. Contains error message and AFHTTPRequestOperation instance if request was made.
 */
- (AFHTTPRequestOperation *)updateWithParams:(NSDictionary *)params
                                   customURL:(NSString *)urlString
                            acceptNULLValues:(BOOL)acceptNULL
                                     success:(void (^)(AFHTTPRequestOperation *operation, id responce))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/*!
 @abstract sends DELETE request. Use this method to <b>delete</b> the object representation on the server.
 @param success a block, called if response code is 204(no content).
 @param failure a block, called if any error occures. Contains error message and AFHTTPRequestOperation instance if request was made.
 */
- (AFHTTPRequestOperation *)deleteSuccess:(void (^)(AFHTTPRequestOperation *operation, id responce))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
