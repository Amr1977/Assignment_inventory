//
//  BDIProduct.m
//  BDRInventory
//
//  Created by Amr Lotfy on 6/3/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "BDIProduct.h"

@implementation BDIProduct



-(instancetype) initWithDictionary:(NSDictionary *) productAttributes{
    self = [super init];
    if (self){
        if(productAttributes){
            for (NSString* key in productAttributes) {
                NSLog(@"key:[%@], value:[%@]",key,productAttributes[key]);
                if ([key isEqualToString:@"expiration_date"]) {
                    _expireDate=productAttributes[key];
                }else if ([key isEqualToString:@"name"]) {
                    NSString * nameString = productAttributes[key];
                    NSArray * subStrings=[nameString componentsSeparatedByString:@"-"];
                    for (NSString * substring in subStrings) {
                        
                       // NSLog(@"Name substring: [%@]",substring);
                        NSArray * subNameComponent=[substring componentsSeparatedByString:@":"];
                        if ([subNameComponent count]==2){
                            if ([subNameComponent[0] isEqualToString:@"pr"]) {//product name
                                _name=subNameComponent[1];
                                NSLog(@"Product Name: %@",_name);
                            }else if ([subNameComponent[0] isEqualToString:@"man"]) {//product name
                                _manufacturer=subNameComponent[1];
                                NSLog(@"Manufacturer: %@",_manufacturer);
                            }else if ([subNameComponent[0] isEqualToString:@"cat"]) {//product name
                                _category=subNameComponent[1];
                                NSLog(@"Category: %@",_category);
                            }else if ([subNameComponent[0] isEqualToString:@"exp"]) {//product name
                                _exporterID=subNameComponent[1];
                                 NSLog(@"Exported ID: %@",_exporterID);
                            }
                        }
                        
                        
                    }
                    
                    
                }else if ([key isEqualToString:@"price"]) {
                    _price=productAttributes[key];
                    
                }else if ([key isEqualToString:@"quantity"]) {
                    _quantity=[productAttributes[key] integerValue];
                }
                //parse dictionary keys
                
            }
            
        }
    }
    return self;
}

@end
