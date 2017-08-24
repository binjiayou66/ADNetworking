//
//  ADURLResponse.h
//  ADNetworking
//
//  Created by Andy on 2017/8/23.
//  Copyright © 2017年 Andy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ADURLResponseStatus) {
    ADURLResponseStatusSuccess,
    ADURLResponseStatusErrorUnknown,
    ADURLResponseStatusErrorTimeout,
    ADURLResponseStatusErrorNoNetwork,
    ADURLResponseStatusErrorBadNetwork
};

@interface ADURLResponse : NSObject

@property (nonatomic, assign, readonly) ADURLResponseStatus status;
@property (nonatomic, copy, readonly) NSDictionary *content;

- (instancetype)initWithResponseData:(NSData *)responseData;
- (instancetype)initWithError:(NSError *)error;

@end
