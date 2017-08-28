//
//  BaiduApiProcessor.m
//  ADNetworking
//
//  Created by Andy on 2017/8/25.
//  Copyright © 2017年 Andy. All rights reserved.
//

#import "BaiduApiProcessor.h"

@implementation BaiduApiProcessor

- (void)process:(ADHttpBaseApi *)api data:(NSDictionary *)data
{
    NSLog(@"--- %@", data);
    self.dataSource.array = data[@"DATA"];
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end
