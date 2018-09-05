//
//  Products.m
//  NavCtrl
//
//  Created by Cristian Molina on 8/16/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "Products.h"

@implementation Products


-(instancetype) initWithName:(NSString*)name andLogo:(NSString*)logo andURL:(NSString*)URL
{
    if(self = [super init])
    {
        self.productName = name;
        self.productURL = URL;
        self.productLogo = logo;
    }
    
    return self;
}


-(void) dealloc
{
    [_productName release];
    [_productURL release];
    [_productLogo release];
    [super dealloc];
}

@end
