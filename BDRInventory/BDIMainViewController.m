//
//  BDIMainViewController.m
//  BDRInventory
//
//  Created by Amr Lotfy on 7/2/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDIMainViewController.h"

@interface BDIMainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *expireFilterState;

@end

@implementation BDIMainViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBarController *rootTabBarController =(UITabBarController * )[
                                                                [(AppDelegate*)
                                                                 [
                                                                  [UIApplication sharedApplication] delegate] window] rootViewController
                                                                ];
    
    NSUInteger selectedIndex=rootTabBarController.selectedIndex;
    NSLog(@"selected index: %lu",(unsigned long)selectedIndex);
    
    self.expireFilterState.text= @"Expired";
    self.expireFilterMode=BDIProductExpired;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"expireFilter"]) {
        NSLog(@"going to expireFilter ...");
        [(BDIExpireFilterViewController *)[segue destinationViewController] setStoredFilterMode:self.expireFilterMode];
        
        [(BDIExpireFilterViewController *)[segue destinationViewController] setStoredStartDate:self.startDate];
        [(BDIExpireFilterViewController *)[segue destinationViewController] setStoredEndDate:self.endDate];

    }
}


@end
