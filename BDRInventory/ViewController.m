//
//  ViewController.m
//  BDRInventory
//
//  Created by Amr Lotfy on 6/3/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) BDInventory * inventoryModel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *grouping;
@property (weak, nonatomic) IBOutlet UISegmentedControl *expireFilters;
@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation ViewController

- (IBAction)apply:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self inventoryModel]){
        NSLog(@"Initialized inventory model.");
        
    }else{
        NSLog(@"Error Initializing inventory model.");
    }
    // Do any additional setup after loading the view, typically from a nib.
}

-(BDInventory *) inventoryModel{
    if(!_inventoryModel){
        _inventoryModel=[BDInventory new];
    }
    return _inventoryModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
