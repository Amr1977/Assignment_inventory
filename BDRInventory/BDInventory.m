//
//  BDInventory.m
//  BDRInventory
//
//  Created by Amr Lotfy on 6/3/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDInventory.h"

@interface BDInventory()

@property (nonatomic) NSArray * products;

@end

@implementation BDInventory


-(instancetype) init{
    self =[super init];
    if (self){
       //load data from data source
    }else{
        NSLog(@"%@ Error initializing ", [self class]);
    }
    
    return self;
}

@end
