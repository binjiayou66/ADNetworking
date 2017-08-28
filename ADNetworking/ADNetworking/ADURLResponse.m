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

#warning - 此处可进行符合公司请求返回的通用标准格式解析
- (void)parseResponseData:(NSData *)responseData
{
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        _status = [self statusWithError:error];
        _content = error.userInfo;
        return;
    }
    _status = ADURLResponseStatusSuccess;
    _content = dict;
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
