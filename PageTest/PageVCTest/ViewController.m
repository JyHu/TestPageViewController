//
//  ViewController.m
//  PageVCTest
//
//  Created by 胡金友 on 15/6/30.
//  Copyright (c) 2015年 胡金友. All rights reserved.
//

#import "ViewController.h"
#import "MoreViewController.h"

@interface ViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (retain, nonatomic) UIPageViewController *pageViewController;

@property (retain, nonatomic) NSArray *pageContent;

@property (retain, nonatomic) NSMutableArray *viewControllersArray;

@end

@implementation ViewController

@synthesize pageContent = _pageContent;

@synthesize pageViewController = _pageViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    self.viewControllersArray = [[NSMutableArray alloc] init];
    
    [self createContentPages];
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    [[_pageViewController view] setFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20)];
    
    MoreViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    [_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:_pageViewController];
    [[self view] addSubview:_pageViewController.view];
}

- (void)createContentPages
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
    for (NSInteger i = 0 ; i < 11 ; i++)
    {
        NSString *contentString = [NSString stringWithFormat:@"Chapter %@ . This is the page %@ of content displayed using UIPPageViewController in iOS 5", @(i), @(i)];
        [pageStrings addObject:contentString];
    }
    
    self.pageContent = [[NSArray alloc] initWithArray:pageStrings];
}

- (MoreViewController *)viewControllerAtIndex:(NSInteger)index
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"%@", @(index));
    
    if (([self.pageContent count] == 0) || (index >= [self.pageContent count]))
    {
        return nil;
    }
    else
    {
        for (MoreViewController *vc in self.viewControllersArray)
        {
            if (vc.dataObj == nil)
            {
                continue;
            }
            if ([self.pageContent containsObject:vc.dataObj])
            {
                NSLog(@"reuse");
                return vc;
            }
        }
    }
    
    NSLog(@"new");
    MoreViewController *dataViewController = [[MoreViewController alloc] init];
    dataViewController.dataObj = [self.pageContent objectAtIndex:index];
    
    [self.viewControllersArray addObject:dataViewController];
    
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(MoreViewController *)viewController
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    return [self.pageContent indexOfObject:viewController.dataObj];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"%@\n\n", ((MoreViewController *)viewController).dataObj);
    
    NSUInteger index = [self indexOfViewController:(MoreViewController *)viewController];
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    
    index --;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"%@\n\n", ((MoreViewController *)viewController).dataObj);
    
    NSUInteger index = [self indexOfViewController:(MoreViewController *)viewController];
    if (index == NSNotFound)
    {
        return nil;
    }
    index ++;
    
    if (index == [self.pageContent count])
    {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
