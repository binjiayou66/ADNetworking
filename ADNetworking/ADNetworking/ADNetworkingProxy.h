//
//  ADNetworkingProxy.h
//  ADNetworking
//
//  Created by Andy on 2017/8/23.
//  Copyright © 2017年 Andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADHttpBaseApi.h"
#import "ADURLResponse.h"

typedef void (^ADRequestCallBack)(ADURLResponse * response);

@interface ADNetworkingProxy : NSObject

+ (instancetype)proxy;

- (NSUInteger)loadDataWithApi:(ADHttpBaseApi *)api success:(ADRequestCallBack)success failure:(ADRequestCallBack)failure;
- (NSUInteger)uploadDataWithApi:(ADHttpBaseApi *)api success:(ADRequestCallBack)success failure:(ADRequestCallBack)failure;

- (void)cancelRequestWithRequestID:(NSUInteger)requestID;

@end
