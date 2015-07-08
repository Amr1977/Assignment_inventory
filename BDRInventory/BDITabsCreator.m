//
//  BDITabsCreator.m
//  BDRInventory
//
//  Created by Amr Lotfy on 7/8/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDITabsCreator.h"

@implementation BDITabsCreator

-(UITabBarController *) createTabs{
    
    UITabBarController *tabBarController =
    [[UITabBarController alloc] init];
    UIStoryboard *mainStoryboard =
    [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSMutableArray * vcs= [NSMutableArray new];
    
    for (NSString * title in @[@"Manufacturer",@"Exporter",@"Category",@"No Group"]) {
        UINavigationController *navigationVC = [[UINavigationController alloc] init];
        navigationVC.title = title;
        UIViewController *mainVC = (UIViewController *)
        [mainStoryboard instantiateViewControllerWithIdentifier:@"rootView"];
        [navigationVC setViewControllers:@[ mainVC ]];
        [vcs addObject:navigationVC];
    }
    
    tabBarController.viewControllers = [vcs copy];
    
    return tabBarController;
}

@end
