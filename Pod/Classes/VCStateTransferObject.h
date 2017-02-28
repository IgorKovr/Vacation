//
//  VCStateTransferObject.h
//  PetPhone
//
//  Created by Igor Kovryzhkin on 4/6/16.
//  Copyright © 2016 Igor Kovryzhkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import <Mantle/MTLReflection.h>
#import "VCWebService.h"

/*!
 Base class for model objects capable of automatic properties mapping and State Transfering
 */

@interface VCStateTransferObject : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber * server_id;
@property (nonatomic, strong) NSDate   * updated_at;
@property (nonatomic, strong) NSDate   * created_at;

/*!
 models URL endpoint
 subclasses ought to override this property getter in order to support state transfering
 */
@property (nonatomic, strong, readonly) NSString * endpointURL;

/*!
 A AFHTTPRequestOperationManager subclass instance for HTTP communication
 
 Override this method if you want to provide custom AFHTTPRequestOperationManager subclass for HTTP operations
 
 returns VCWebService instance by default
 */
+ (AFHTTPRequestOperationManager *)operationManager;

/*!
 A dictionary used to map pamater names from server side with VCStateTransferObject subclas parameter names
 
 Subclasses should override this method if any of fetched parameter names are not equal to server parameters
 
 if nil - current parameter names will be used
 
 returns nil by default
 */
+ (NSDictionary *)mappingDictionary;

/*!
 Specifies an array of parameters that will be uploaded to server
 
 Subclasses shoud override this method if parameters should be restricted to provided array
 
 if nil all parameters will be used as soon as -filterParametersKeys doesn't return a valid array
 
 returns nil by default
 */
- (NSArray *)permitParameterKeys;

/*!
 Specifies an array of parameters that will be filtered from all parameters set when uploaded to server
 
 Subclasses shoud override this method if parameters should be filtered with provided array
 
 This method will not be executed if -permitParameterKeys returns a valid array
 
 if nil all parameters will be used
 
 returns nil by default
 */
- (NSArray *)filterParametersKeys;

/*!
 Override this method if you want to to handle StateTransfer Errors
 */
- (void)handleStateTransferError:(NSError *)error;

/*! Merges the values of the given model object into the receiver, using
    -mergeValueForKey:fromModel:acceptNULL: for each key in +propertyKeys.
    `model` must be an instance of the receiver's class or a subclass thereof.
     acceptNULL if true - rewrites parameters that are NULL in given model
 */
- (void)mergeValuesForKeysFromModel:(id<MTLModel>)model acceptNULL:(BOOL)acceptNULL;

@end
