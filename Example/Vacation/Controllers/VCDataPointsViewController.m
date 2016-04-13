//
//  VCDataPointsViewController.m
//  Vacation
//
//  Created by Igor Kovryzhkin on 4/13/16.
//  Copyright © 2016 IgorK. All rights reserved.
//

#import "VCDataPointsViewController.h"
#import "VCDataPoint.h"

@implementation VCDataPointsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dataStreamParams = @{@"start"    : @"2014-05-20T11:01:46Z",
                                       @"stop"     : @"2014-07-20T11:01:46Z",
                                       @"interval" : @86400,
                                       @"limit"    : @100,
                                       @"function" : @"average"};
    
    [_dataStream getWithParams:dataStreamParams success:^(AFHTTPRequestOperation *operation, id responce) {
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Refreshing Xively Feed: %@", error.localizedDescription);
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataStream.datapoints count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (_dataStream.datapoints.count > indexPath.row) {
        VCDataPoint * dataPoint = [_dataStream.datapoints objectAtIndex:indexPath.row];
        cell.textLabel.text = dataPoint.value;
        cell.detailTextLabel.text = dataPoint.at;
    } else {
        cell.textLabel.text = @"Back";
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

@end
