//
//  Company.m
//  NavCtrl
//
//  Created by Cristian Molina on 8/16/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "Company.h"
#import "Products.h"

@implementation Company

-(instancetype)initWithName: (NSString*) name api:(NSString*)api andLogo:(NSString*) logo {
    if (self == [super init]) {
        self.companyName = name;
        self.companyLogoURL = logo;
        self.companyAPI = api;
        self.companyProducts = [NSMutableArray array];
     //   self.companyAPIValue = 0.0;
    }
    return self;
}


-(void)dealloc {
    
    [self.companyName release];
    [self.companyLogoURL release];
    [self.companyProducts removeAllObjects];
    [self.companyProducts release];
    
    [super dealloc];
}







@end
