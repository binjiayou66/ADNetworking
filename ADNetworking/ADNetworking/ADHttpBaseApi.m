//
//  ADHttpBaseApi.m
//  ADNetworking
//
//  Created by Andy on 2017/8/23.
//  Copyright © 2017年 Andy. All rights reserved.
//

#import "ADHttpBaseApi.h"

@implementation ADHttpBaseApi

#pragma mark - life cycle
- (instancetype)init
{
    if (self= [super init]) {
        
    }
    return self;
}

- (void)dealloc
{
    // 取消请求
    [self cancel];
}

#pragma mark - ADHttpBaseApiDataSource

- (NSDictionary *)parameters { return @{}; }
- (NSString *)uri { return @""; }
// 此处可配置默认host
- (NSString *)requestHost { return @""; }
- (ADHttpRequestType)requestMethod { return ADHttpRequestTypePost; }
- (NSTimeInterval)requestTimeOutInterval { return 15; }

#pragma mark - public method

- (void)loadData
{
    
}

- (void)uploadData
{
    
}

- (void)loadDataWithSuccess:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure
{
    
}

- (void)uploadDataWithSuccess:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure
{
    
}

- (void)cancel
{
    
}

- (void)processDataWithProcessor:(id)processor
{
    if ([processor respondsToSelector:@selector(process:data:)]) {
        [processor process:self data:self.responseData];
    }
}

#pragma mark - private method

@end
