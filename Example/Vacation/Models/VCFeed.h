//
//  VCFeed.h
//  Vacation
//
//  Created by Igor Kovryzhkin on 4/12/16.
//  Copyright © 2016 IgorK. All rights reserved.
//

#import "Vacation.h"
#import <Foundation/Foundation.h>

@interface VCFeed : VCStateTransferObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) BOOL private;
@property (nonatomic, strong) NSString * status;
@property (nonatomic, strong) NSString * version;
@property (nonatomic, strong) NSString * creator;
@property (nonatomic, strong) NSArray  * tags;
@property (nonatomic, strong) NSString * feed_description;
@property (nonatomic, strong) NSArray  * datastreams;

@end