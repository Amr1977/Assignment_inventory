//
//  BDIProductDetailsViewController.m
//  BDRInventory
//
//  Created by Amr Lotfy on 6/30/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDIProductDetailsViewController.h"

@interface BDIProductDetailsViewController ()
@property(weak, nonatomic) IBOutlet UITextField *name;
@property(weak, nonatomic) IBOutlet UITextField *manufacturer;
@property(weak, nonatomic) IBOutlet UITextField *category;
@property(weak, nonatomic) IBOutlet UITextField *exporterId;

@property(weak, nonatomic) IBOutlet UITextField *expireDate;
@property(weak, nonatomic) IBOutlet UITextField *price;
@property(weak, nonatomic) IBOutlet UITextField *quantity;

@end

@implementation BDIProductDetailsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  BDIProduct *product = [[BDInventory inventory] product];
  if (product) {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd/MMM/yyyy"];

    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    //[numberFormatter setNumberStyle:NSnu];
    [numberFormatter
        setGroupingSeparator:[[NSLocale currentLocale]
                                 objectForKey:NSLocaleGroupingSeparator]];
    [numberFormatter setUsesGroupingSeparator:YES];
    NSLog(@"view did load (1)");
    self.name.text = product.name;
    self.manufacturer.text = product.manufacturer;
    self.category.text = product.category;
    self.exporterId.text = product.exporterID;
    self.expireDate.text = [format stringFromDate:product.expireDate];
    self.price.text = [NSString
        stringWithFormat:@"%@",
                         [currencyFormatter stringFromNumber:product.price]];
    self.quantity.text = [numberFormatter
        stringFromNumber:[NSNumber numberWithInteger:product.quantity]];
  }
}
/*
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/

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
