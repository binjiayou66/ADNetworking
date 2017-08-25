//
//  BaiduApiProcessor.h
//  ADNetworking
//
//  Created by Andy on 2017/8/25.
//  Copyright © 2017年 Andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADHttpBaseApi.h"

@interface BaiduApiProcessor : NSObject <ADURLResponseProcessorDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end
