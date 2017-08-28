//
//  BaiDuApi.m
//  ADNetworking
//
//  Created by Andy on 2017/8/25.
//  Copyright © 2017年 Andy. All rights reserved.
//

#import "BaiDuApi.h"

@implementation BaiDuApi

- (ADHttpRequestType)requestMethod
{
    return ADHttpRequestTypeGet;
}

- (NSString *)requestHost
{
    return @"http://www.andy1991.cn";
}

- (NSString *)uri
{
    return @"/demo/adselect.php";
}

- (NSDictionary *)parameters
{
    return @{@"name":@"Lee", @"age":@(18)};
}

@end
