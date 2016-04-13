//
//  VCDataPoint.h
//  Vacation
//
//  Created by Igor Kovryzhkin on 4/13/16.
//  Copyright © 2016 IgorK. All rights reserved.
//

#import "Vacation.h"

@interface VCDataPoint : NTStateTransferObject

@property (nonatomic, strong) NSString *at;
@property (nonatomic, strong) NSString *value;

@end
