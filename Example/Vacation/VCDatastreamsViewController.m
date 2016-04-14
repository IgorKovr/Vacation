//
//  VCDatastreamsViewController.m
//  Vacation
//
//  Created by Igor Kovryzhkin on 4/13/16.
//  Copyright © 2016 IgorK. All rights reserved.
//

#import "VCDatastreamsViewController.h"
#import "VCFeed.h"
#import "VCDataStream.h"
#import "VCDataPointsViewController.h"

NSString * const segueIdentifier = @"selectedDataStreem";

@interface VCDatastreamsViewController ()

@property (nonatomic, strong) VCFeed *dataFeed;

@end

@implementation VCDatastreamsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataFeed = [[VCFeed alloc] initWithDictionary:@{@"server_id" : @1799206591} error:NULL];
    [_dataFeed getWithParams:nil success:^(AFHTTPRequestOperation *operation, id responce) {
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Refreshing Xively Feed: %@", error.localizedDescription);
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VCDataStream * datastream = [_dataFeed.datastreams objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:segueIdentifier sender:datastream];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return [_dataFeed.datastreams count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    
    VCDataStream * dataStream = [_dataFeed.datastreams objectAtIndex:indexPath.row];
    cell.textLabel.text = dataStream.title;
    cell.detailTextLabel.text = dataStream.current_value;
    
    // set the accessory view:
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:segueIdentifier]) {
        VCDataPointsViewController *datapointVC = (VCDataPointsViewController *)[segue destinationViewController];
        datapointVC.dataStream = sender;
    }
}

@end
