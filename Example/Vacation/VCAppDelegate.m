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
    [NTWebService setBaseURL:@"https://api.xively.com/"];
    
    [NTWebService sharedInstance].securityPolicy.allowInvalidCertificates = YES;
    [NTWebService sharedInstance].securityPolicy.validatesDomainName = NO;
    
    [[NTWebService sharedInstance].requestSerializer setValue:@"vqA5aaDchjEBnPBENb3X4ufUXjo7eq19HsW7OqzoQmzrFeah"
                                           forHTTPHeaderField:@"X-ApiKey"];
    
    return YES;
}

@end
