//
//  VCDatastreamsViewController.h
//  Vacation
//
//  Created by Igor Kovryzhkin on 4/13/16.
//  Copyright © 2016 IgorK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCDatastreamsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataStream;

@end