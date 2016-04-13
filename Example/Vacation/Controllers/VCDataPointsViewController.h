//
//  VCDataPointsViewController.h
//  Vacation
//
//  Created by Igor Kovryzhkin on 4/13/16.
//  Copyright © 2016 IgorK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCDataStream.h"

@interface VCDataPointsViewController : UITableViewController

@property (nonatomic, strong) VCDataStream *dataStream;

@end
