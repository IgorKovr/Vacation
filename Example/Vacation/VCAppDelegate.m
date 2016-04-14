//
//  VCAppDelegate.m
//  Vacation
//
//  Created by IgorK on 04/12/2016.
//  Copyright (c) 2016 IgorK. All rights reserved.
//

#import "VCAppDelegate.h"
#import "Vacation.h"
#import "VCDatastreamsViewController.h"

@implementation VCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [VCWebService setBaseURL:@"https://api.xively.com/"];
    
    [VCWebService sharedInstance].securityPolicy.allowInvalidCertificates = YES;
    [VCWebService sharedInstance].securityPolicy.validatesDomainName = NO;
    
    [[VCWebService sharedInstance].requestSerializer setValue:@"vqA5aaDchjEBnPBENb3X4ufUXjo7eq19HsW7OqzoQmzrFeah"
                                           forHTTPHeaderField:@"X-ApiKey"];
    
    return YES;
}

@end
