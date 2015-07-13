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
  if (self.product) {
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
    self.name.text = self.product.name;
    self.manufacturer.text = self.product.manufacturer;
    self.category.text = self.product.category;
    self.exporterId.text = self.product.exporterID;
    self.expireDate.text = [format stringFromDate:self.product.expireDate];
    self.price.text = [NSString
        stringWithFormat:@"%@", [currencyFormatter
                                    stringFromNumber:self.product.price]];
    self.quantity.text = [numberFormatter
        stringFromNumber:[NSNumber numberWithInteger:self.product.quantity]];
  } else {
    NSLog(@">>>>>>>>>>>>>>>>>>>>details controller: product not set "
          @"<<<<<<<<<<<<<<<<<<<<<<<");
  }
}

@end
