//
//  ADHttpBaseApi.m
//  ADNetworking
//
//  Created by Andy on 2017/8/23.
//  Copyright © 2017年 Andy. All rights reserved.
//

#import "ADHttpBaseApi.h"
#import "ADNetworkingProxy.h"
#import <AFNetworkReachabilityManager.h>

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
    NSUInteger requestID = 0;
    __weak typeof(self) weakSelf = self;
    if ( [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus != AFNetworkReachabilityStatusNotReachable )
    {
        requestID = [[ADNetworkingProxy proxy] loadDataWithApi:self success:^(ADURLResponse *response) {
            __strong ADHttpBaseApi *strongSelf = weakSelf;
            [strongSelf successWithResponse:response];
        } failure:^(ADURLResponse *response) {
            
        }];
    }
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

- (void)successWithResponse:(ADURLResponse *)response
{
    [self successWithResponse:response success:nil failure:nil];
}

- (void)successWithResponse:(ADURLResponse *)response success:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure
{
    if (self.delegate && success) {
        NSAssert(0, @"block方法和delegate方法不能共存");
        return;
    }
    self.responseData = response.content;
    if ([self.delegate respondsToSelector:@selector(apiRequestCallbackDidSuccess:)]) {
        [self.delegate apiRequestCallbackDidSuccess:self];
    }else if (success) {
        success(self.responseData);
    }
}

- (void)failureWithResponse:(ADURLResponse *)response
{
    [self failureWithResponse:response success:nil failure:nil];
}

- (void)failureWithResponse:(ADURLResponse *)response success:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure
{
    
}

@end
