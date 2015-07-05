//
//  BDIProductDetailsViewController.m
//  BDRInventory
//
//  Created by Amr Lotfy on 6/30/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDIProductDetailsViewController.h"

@interface BDIProductDetailsViewController ()


@end

@implementation BDIProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self product]){
//        NSDateFormatter *format = [[NSDateFormatter alloc] init];
//        [format setDateFormat:@"dd/MMM/yyyy"];
//        
//        NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
//        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
//        
//        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//        //[numberFormatter setNumberStyle:NSnu];
//        [numberFormatter
//         setGroupingSeparator:[[NSLocale currentLocale]
//                               objectForKey:NSLocaleGroupingSeparator]];
//        [numberFormatter setUsesGroupingSeparator:YES];
//        NSLog(@"view did load (1)");
//        self.name.text=self.product.name;
//        self.manufacturer.text=self.product.manufacturer;
//        self.category.text=self.product.category;
//        self.exporterID.text=self.product.exporterID;
//        self.expireDate.text = [format stringFromDate:self.product.expireDate];
//        self.price.text = [NSString stringWithFormat:@"%@",[currencyFormatter stringFromNumber:self.product.price]];
//        self.quantity.text = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:self.product.quantity]];
        
    }
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
