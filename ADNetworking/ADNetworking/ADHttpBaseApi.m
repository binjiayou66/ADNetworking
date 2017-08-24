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
    
}

#pragma mark - private method

@end
