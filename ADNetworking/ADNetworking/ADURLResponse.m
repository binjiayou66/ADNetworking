//
//  ADURLResponse.m
//  ADNetworking
//
//  Created by Andy on 2017/8/23.
//  Copyright © 2017年 Andy. All rights reserved.
//

#import "ADURLResponse.h"

@implementation ADURLResponse

#pragma mark - life cycle

- (instancetype)initWithResponseData:(NSData *)responseData
{
    if (self = [super init]) {
        [self parseResponseData:responseData];
    }
    return self;

}

- (instancetype)initWithError:(NSError *)error
{
    if (self = [super init]) {
        _status = [self statusWithError:error];
        _content = error.userInfo;
    }
    return self;
}

#pragma mark - private method

- (void)parseResponseData:(NSData *)responseData
{
    
}

- (NSInteger)statusWithError:(NSError *)error
{
    if (error) {
        switch (error.code) {
            case NSURLErrorTimedOut:
                return ADURLResponseStatusErrorTimeout;
                break;
                
            default:
                return ADURLResponseStatusErrorBadNetwork;
                break;
        }
    }else {
        return ADURLResponseStatusSuccess;
    }
}

@end
