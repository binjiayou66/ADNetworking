//
//  ADNetworkingProxy.m
//  ADNetworking
//
//  Created by Andy on 2017/8/23.
//  Copyright © 2017年 Andy. All rights reserved.
//

#import "ADNetworkingProxy.h"
#import <AFHTTPSessionManager.h>
#import <AFURLRequestSerialization.h>

@interface ADNetworkingProxy ()

@property (nonatomic, assign) NSUInteger requestID;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableDictionary *taskDict;
@property (nonatomic, strong) NSArray *requestMethodArray;

@end

@implementation ADNetworkingProxy

#pragma mark - public method

+ (instancetype)proxy
{
    static ADNetworkingProxy *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ADNetworkingProxy alloc] init];
    });
    return instance;
}

- (NSUInteger)loadDataWithApi:(ADHttpBaseApi *)api success:(void (^)(ADURLResponse * response))success failure:(void (^)(ADURLResponse * response))failure
{
    NSUInteger requestID = [self generateRequestID];
    NSURLRequest *request = [self generateDataRequestWithApi:api];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        __strong ADNetworkingProxy *strongSelf = weakSelf;
        if (error)
        {   // 请求失败
            [strongSelf failureWithRequestID:requestID error:error failure:failure];
        }
        else
        {   // 请求成功
            [strongSelf successWithRequestID:requestID responseData:responseObject success:success];
        }
    }];
    self.taskDict[@(requestID)] = task;
    [task resume];
    
    return requestID;
}

- (NSUInteger)uploadDataWithApi:(ADHttpBaseApi *)api success:(void (^)(ADURLResponse * response))success failure:(void (^)(ADURLResponse * response))failure
{
    NSUInteger requestID = [self generateRequestID];
#warning generate upload request
    NSURLRequest *request = nil;
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [self.sessionManager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        __strong ADNetworkingProxy *strongSelf = weakSelf;
        if (error)
        {   // 请求失败
            [strongSelf failureWithRequestID:requestID error:error failure:failure];
        }
        else
        {   // 请求成功
            [strongSelf successWithRequestID:requestID responseData:responseObject success:success];
        }
    }];
    self.taskDict[@(requestID)] = task;
    [task resume];
    
    return requestID;
}

- (void)cancelRequestWithRequestID:(NSUInteger)requestID
{
    NSURLSessionTask *task = self.taskDict[@(requestID)];
    if (!task) { return; }
    [task cancel];
    [self.taskDict removeObjectForKey:@(requestID)];
}

#pragma mark - private method

- (NSUInteger)generateRequestID
{
    if (self.requestID == NSUIntegerMax) {
        self.requestID = 0;
    }
    return ++self.requestID;
}

#warning - 此处可配置request头部信息
- (NSURLRequest *)generateDataRequestWithApi:(ADHttpBaseApi *)api
{
    // Request基本配置，url、method、parameters
    NSAssert([api requestHost].length > 0, @"请配置网络请求主机地址");
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [api requestHost], [api uri]];
    NSDictionary *params = [api parameters];
    NSString *method = self.requestMethodArray[[api requestMethod]];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:method URLString:urlString parameters:params error:nil];
    // Request高级配置，token、header参数
    NSString *localToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"RequestToken"];
    NSString *token = [api respondsToSelector:@selector(requestToken)] ? [api requestToken] : ([localToken length] > 0 ? localToken : @"anonymous");
    [request setValue:token forHTTPHeaderField:@"Request-Token"];
    [request setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forHTTPHeaderField:@"App-Version"];
    // 请求超时时长
    NSTimeInterval timeout = [api requestTimeOutInterval];
    [request setTimeoutInterval:timeout];
    
    return request;
}

- (void)successWithRequestID:(NSUInteger)requestID responseData:(NSData *)data success:(ADRequestCallBack)success
{
    // 移除记录
    NSURLSessionTask *task = self.taskDict[@(requestID)];
    if (!task) { return; }
    [self.taskDict removeObjectForKey:@(requestID)];
    
    // 回调
    ADURLResponse *response = [[ADURLResponse alloc] initWithResponseData:data];
    success(response);
}

- (void)failureWithRequestID:(NSUInteger)requestID error:(NSError *)error failure:(ADRequestCallBack)failure
{
    // 移除记录
    NSURLSessionTask *task = self.taskDict[@(requestID)];
    if (!task) { return; }
    [self.taskDict removeObjectForKey:@(requestID)];
    
    // 回调
    ADURLResponse *response = [[ADURLResponse alloc] initWithError:error];
    failure(response);
}

#pragma mark - getter and setter

- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _sessionManager;
}

- (NSMutableDictionary *)taskDict
{
    if (!_taskDict) {
        _taskDict = [[NSMutableDictionary alloc] init];
    }
    return _taskDict;
}

- (NSArray *)requestMethodArray
{
    if (!_requestMethodArray) {
        _requestMethodArray = [[NSArray alloc] initWithObjects:@"GET", @"POST", @"PUT", @"DELETE", nil];
    }
    return _requestMethodArray;
}

@end
