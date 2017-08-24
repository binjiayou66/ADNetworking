//
//  ADHttpBaseApi.h
//  ADNetworking
//
//  Created by Andy on 2017/8/23.
//  Copyright © 2017年 Andy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ADHttpBaseApi;

/**
 请求方法枚举类型
 */
typedef NS_ENUM(NSUInteger, ADHttpRequestType) {
    ADHttpRequestTypeGet = 1,
    ADHttpRequestTypePost,
    ADHttpRequestTypePut,
    ADHttpRequestTypeDelete
};

/**
 请求错误类型枚举类型
 */
typedef NS_ENUM(NSUInteger, ADHttpRequestErrorType) {
    ADHttpRequestErrorTypeUnknown = 0,
    ADHttpRequestErrorTypeFailed,
    ADHttpRequestErrorTypeTimeOut,
    ADHttpRequestErrorTypeNoNetwork,
    ADHttpRequestErrorTypeNoCotent
};

/**
 Api请求结束，代理实现下述协议中的方法，可以获取请求结果
 */
@protocol ADHttpBaseApiCallBackDelegate <NSObject>

@optional
- (void)apiRequestCallbackDidSuccess:(ADHttpBaseApi *)api;
- (void)apiRequestCallbackDidFailure:(ADHttpBaseApi *)api;

@end

/**
 ADURLResponse处理器需要遵循的协议
 
 - @selector(process:data:) 处理ADURLResponse数据的方法入口
 - @property(dataSource) 数据处理结束得到的符合当前业务场景的数据集合
 - @property(configuration) 可选配置属性，用于扩展存储配置内容
 */
@protocol ADURLResponseProcessorDelegate <NSObject>

@required
@property (nonatomic, strong) NSMutableArray *dataSource;
- (void)process:(ADHttpBaseApi *)api data:(NSDictionary *)data;

@optional
@property (nonatomic, strong) NSDictionary *configuration;

@end

/**
 Api参数配置协议
 */
@protocol ADHttpBaseApiDataSource <NSObject>

@required
// 请求参数
- (NSDictionary *)parameters;
// 请求uri
- (NSString *)uri;

@optional
// 请求方法：GET，POST
- (ADHttpRequestType)requestMethod;
// host
- (NSString *)requestHost;
// 请求时间
- (NSTimeInterval)requestTimeOutInterval;
// token
- (NSString *)requestToken;
// 上传文件内容
- (NSDictionary *)uploadContentData;
// 上传文件名称
- (NSString *)uploadFileName;
// 上传文件类型
- (NSString *)uploadFileType;
// 上传文件mimeType
- (NSString *)uploadFileMimeType;

@end

/**
 ADHttpBaseApi
 */
@interface ADHttpBaseApi : NSObject <ADHttpBaseApiDataSource>

@property (nonatomic, assign) NSUInteger requestID;
@property (nonatomic, strong) id responseData;
@property (nonatomic, weak) id<ADHttpBaseApiCallBackDelegate> delegate;

// 协议代理方法
- (void)loadData;
- (void)uploadData;

// block方法
- (void)loadDataWithSuccess:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure;
- (void)uploadDataWithSuccess:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure;

// 取消请求
- (void)cancel;

// 数据处理
- (void)processDataWithProcessor:(id)processor;

@end
