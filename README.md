<p align="center" >
<img src="https://s3-eu-west-1.amazonaws.com/imagestoragekovr/13020345_1203407616366722_1160336882_n.jpg" alt="Vacation" title="Vacation">
</p>

# Vacation

[![CI Status](http://img.shields.io/travis/IgorK/Vacation.svg?style=flat)](https://travis-ci.org/IgorK/Vacation)
[![Version](https://img.shields.io/cocoapods/v/Vacation.svg?style=flat)](http://cocoapods.org/pods/Vacation)
[![License](https://img.shields.io/cocoapods/l/Vacation.svg?style=flat)](http://cocoapods.org/pods/Vacation)
[![Platform](https://img.shields.io/cocoapods/p/Vacation.svg?style=flat)](http://cocoapods.org/pods/Vacation)

Vacation is a drag'n'drop REST solution for an Objective-C model.
It is build on top of AFNetworking and Mantle.

## Usage Example

We will try Vacation with Xively. Xively is a service for hosting your ioT projects. It creates an easy RESTfull Web service for uploading and reading data from various sensors.  

First we create a subclass of a VCObject.

Xively uses 'Feed' to represent a single project. 'Datastream' to represent a stream of sensors data
and 'Datapoint' to represent a single sensor record.


This is how the objects are represented in JSON, and in our app.  

Feed JSON:

```json
 {
 	"id": 121601,
 	"title": "Demo",
 	"private": "false",
 	"feed": "https://api.xively.com/v2/feeds/121601.json",
 	"status": "frozen",
 	"updated": "2013-04-23T03:25:48.686462Z",
 	"created": "2013-03-29T15:50:43.398788Z",
 	"creator": "https://xively.com/users/calumbarnes",
 	"version": "1.0.0",
 	"datastreams": [
 	{
 		"id": "example",
 		"current_value": "333",
 		"at": "2013-04-23T01:10:02.986063Z",
 		"max_value": "333.0",
 		"min_value": "333.0"},
 	{
 		"id": "key",
 		"current_value": "value",
 		"at": "2013-04-23T00:40:34.032979Z"},
 	{
 		"id": "temp"
 	}],
 	"location": {
 		"domain": "physical"
 	}
}
```

in VCFeed.h file:

```objc

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

```

and the .m file

```objc

+ (NSDictionary *)mappingDictionary {
    return @{@"feed_description" : @"description"};
}

- (NSString *)endpointURL {
   return @"/v2/feeds";
}

+ (NSValueTransformer *)datastreamsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:VCDataStream.class];
}

+ (NSValueTransformer *)privateJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"true"  : @1,
                                                                           @"false" : @0
                                                                           }];
}

```

We use -mappingDictionary to map different property names. As descibed in Mantle framework.

Any model should represent  -endpointURL method that is basicaly an andpoint URL.

The -...JSONTransformer method presents a custom mapping behaviour. Such as Arrays, VCObjectSubclasses dates BOOL (as shown in -privateJSONTransformer) e.t.c. 
For more information on this topic see Mantle framework. 

## Try it!

That's it. VCObject will use it's power to add GET, POST, PUT and DELETE methods to any VCObject. It will also map all the property's including nested ones. Also it will upload all provided properties.


## Installation

Vacation is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Vacation"
```

## Author

Igor Kovryzhkin, IgorKovr@gmail.com

## License

Vacation is available under the MIT license. See the LICENSE file for more info.
