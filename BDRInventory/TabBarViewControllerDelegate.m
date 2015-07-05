//
//  TabBarViewControllerDelegate.m
//  BDRInventory
//
//  Created by Amr Lotfy on 7/2/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "TabBarViewControllerDelegate.h"

@interface TabBarViewControllerDelegate ()

@end

@implementation TabBarViewControllerDelegate

- (void)viewDidLoad {
  [super viewDidLoad];
  self.delegate = self;

  UIStoryboard *mainStoryboard =
      [UIStoryboard storyboardWithName:@"Main" bundle:nil];

  UINavigationController *manufacturerNavigation =
      [[UINavigationController alloc] init];
  manufacturerNavigation.title = @"Manufacturer";
  UIViewController *mainVC = (UIViewController *)
      [mainStoryboard instantiateViewControllerWithIdentifier:@"rootView"];
  [manufacturerNavigation setViewControllers:@[ mainVC ]];

  UINavigationController *exporterNavigation =
      [[UINavigationController alloc] init];
  exporterNavigation.title = @"Exporter";
  mainVC = (UIViewController *)
      [mainStoryboard instantiateViewControllerWithIdentifier:@"rootView"];
  [exporterNavigation setViewControllers:@[ mainVC ]];

  UINavigationController *categoryNavigation =
      [[UINavigationController alloc] init];
  categoryNavigation.title = @"Category";
  mainVC = (UIViewController *)
      [mainStoryboard instantiateViewControllerWithIdentifier:@"rootView"];
  [categoryNavigation setViewControllers:@[ mainVC ]];

  UINavigationController *nogroupNavigation =
      [[UINavigationController alloc] init];
  nogroupNavigation.title = @"No Group";
  mainVC = (UIViewController *)
      [mainStoryboard instantiateViewControllerWithIdentifier:@"rootView"];
  [nogroupNavigation setViewControllers:@[ mainVC ]];

  self.viewControllers = @[
    manufacturerNavigation,
    categoryNavigation,
    exporterNavigation,
    nogroupNavigation
  ];
  NSLog(@"====================== /n");
  for (UIViewController *vc in self.viewControllers) {
    NSLog(@"title: %@ /n", [vc title]);
  }
  // Do any additional setup after loading the view.
}

- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController {
  NSLog(@"Selected tab: %@", [[self selectedViewController] title]);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
