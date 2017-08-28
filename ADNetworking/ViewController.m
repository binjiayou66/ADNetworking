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

@interface ViewController ()<ADHttpBaseApiCallBackDelegate, UITableViewDataSource>

@property (nonatomic, strong) BaiDuApi *api;
@property (nonatomic, strong) BaiduApiProcessor *processor;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.api = [[BaiDuApi alloc] init];
    self.api.delegate = self;
    [self.api loadData];
    self.processor = [[BaiduApiProcessor alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)apiRequestCallbackDidSuccess:(ADHttpBaseApi *)api
{
    [api processDataWithProcessor:self.processor];
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.processor.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *dict = self.processor.dataSource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%@-%@", dict[@"ID"], dict[@"NAME"], dict[@"AGE"]];
    
    return cell;
}


@end
