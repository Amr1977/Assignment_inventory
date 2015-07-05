//
//  BDIProductDetailsViewController.h
//  BDRInventory
//
//  Created by Amr Lotfy on 6/30/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDIProduct.h"

@interface BDIProductDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *manufacturer;
@property (strong, nonatomic) IBOutlet UITextField *category;
@property (strong, nonatomic) IBOutlet UITextField *exporterID;
@property (strong, nonatomic) IBOutlet UITextField *expireDate;
@property (strong, nonatomic) IBOutlet UITextField *price;
@property (strong, nonatomic) IBOutlet UITextField *quantity;
@property (nonatomic) BDIProduct *product;

@end
