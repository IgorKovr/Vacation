//
//  NTStateTransferObject.h
//  PetPhone
//
//  Created by Igor Kovryzhkin on 4/6/16.
//  Copyright © 2016 RAWR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import <Mantle/MTLReflection.h>
#import "NTWebService.h"

/*!
 Base class for model objects capable of automatic properties mapping and State Transfering
 */

@interface NTStateTransferObject : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber * server_id;
@property (nonatomic, strong) NSDate   * updated_at;
@property (nonatomic, strong) NSDate   * created_at;

/*!
 models URL endpoint
 subclasses ought to override this property getter in order to support state transfering
 */
@property (nonatomic, strong, readonly) NSString *defaultURL;

/*!
 A subclass needs to implement this method in order to perform Web requests
 */
+ (AFHTTPRequestOperationManager *)operationManager;

/*!
 A dictionary used to map pamater names from server side with NTStateTransferObject subclas parameter names
 
 Subclasses shoud override this method if any of fetched parameter names are not the same provided from server responce
 
 if nil current parameter names will be used
 
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
 Override this method in order to handle Error
 */
- (void)handleStateTransferError:(NSError *)error;

@end