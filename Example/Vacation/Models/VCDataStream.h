//
//  VCDataStream.h
//  Vacation
//
//  Created by Igor Kovryzhkin on 4/12/16.
//  Copyright © 2016 IgorK. All rights reserved.
//

#import "Vacation.h"

@interface VCDataStream : NTStateTransferObject

@property (nonatomic, strong) NSString *current_value;
@property (nonatomic, strong) NSString *at;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *max_value;
@property (nonatomic, strong) NSString *min_value;
@property (nonatomic, strong) NSArray  *datapoints;

@end