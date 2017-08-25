//
//  ViewController.m
//  ADNetworking
//
//  Created by Andy on 2017/8/23.
//  Copyright © 2017年 Andy. All rights reserved.
//

#import "ViewController.h"
#import "BaiDuApi.h"
#import "BaiduApiProcessor.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface ViewController ()<ADHttpBaseApiCallBackDelegate>

@property (nonatomic, strong) BaiDuApi *api;
@property (nonatomic, strong) BaiduApiProcessor *processor;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.api = [[BaiDuApi alloc] init];
    self.api.delegate = self;
    [self.api loadData];
    self.processor = [[BaiduApiProcessor alloc] init];
    
//    unsigned int i = 0;
//    Method *methodList = class_copyMethodList(objc_getMetaClass("Animal"), &i);
//    for (int j = 0; j < i; j++) {
//        NSLog(@"----%@", NSStringFromSelector(method_getName(methodList[j])));
//    }
}

- (void)apiRequestCallbackDidSuccess:(ADHttpBaseApi *)api
{
    [api processDataWithProcessor:self.processor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
