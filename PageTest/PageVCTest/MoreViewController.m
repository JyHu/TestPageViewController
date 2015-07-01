//
//  MoreViewController.m
//  PageVCTest
//
//  Created by 胡金友 on 15/6/30.
//  Copyright (c) 2015年 胡金友. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

@synthesize myWebview = _myWebview;
@synthesize dataObj = _dataObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadView
{
    [super loadView];
    
    NSLog(@"-- %@", NSStringFromSelector(_cmd));
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    self.myWebview = [[UIWebView alloc] initWithFrame:CGRectMake(20, 20, size.width - 40, size.height - 60)];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"-- %@", NSStringFromSelector(_cmd));
    
    [super viewWillAppear:animated];
    [self.myWebview loadHTMLString:_dataObj baseURL:nil];
    [self.view addSubview:self.myWebview];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
