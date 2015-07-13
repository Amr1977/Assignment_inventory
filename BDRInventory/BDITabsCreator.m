//
//  BDITabsCreator.m
//  BDRInventory
//
//  Created by Amr Lotfy on 7/8/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDITabsCreator.h"

@implementation BDITabsCreator

- (UITabBarController *)createTabs {
  UITabBarController *tabBarController = [[UITabBarController alloc] init];
  UIStoryboard *mainStoryboard =
      [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  NSMutableArray *vcs = [NSMutableArray new];

  for (NSString *title in
       @[ @"Manufacturer", @"Exporter", @"Category", @"No Group" ]) {
    UINavigationController *navigationVC =
        [[UINavigationController alloc] init];
    navigationVC.title = title;
    BDIMainViewController *mainVC = (BDIMainViewController *)
        [mainStoryboard instantiateViewControllerWithIdentifier:@"rootView"];
    [navigationVC setViewControllers:@[ mainVC ]];
    mainVC.productFilter = [BDIProductFilter new];
    mainVC.productFilter.groupingMode = [self stringToGrouping:title];
    [vcs addObject:navigationVC];
  }

  tabBarController.viewControllers = [vcs copy];

  return tabBarController;
}

- (BDInventoryGropingMode)stringToGrouping:(NSString *)groupingStr {
  if ([groupingStr isEqualToString:@"Manufacturer"]) {
    return BDIManufacturersGrouping;
  }
  if ([groupingStr isEqualToString:@"Exporter"]) {
    return BDIExporterGrouping;
  }
  if ([groupingStr isEqualToString:@"Category"]) {
    return BDICategoryGrouping;
  }
  return BDINoGroup;
}

@end