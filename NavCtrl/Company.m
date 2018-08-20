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

-(instancetype)initWithName: (NSString*) name andLogo:(NSString*) logo {
    if (self == [super init]) {
        self.companyName = name;
        self.companyLogoName = logo;
        self.companyProducts = [NSMutableArray array];
    }
    return self;
}


-(void)dealloc {
    
    [self.companyName release];
    [self.companyLogoName release];
    [self.companyProducts removeAllObjects];
    [self.companyProducts release];
    
    [super dealloc];
}


//-(void) addProducts:(NSString*)n i:(NSString*)i u:(NSString*)u
//{
//    Products* currAddedProdut = [[Products alloc] init];
//
//    currAddedProdut.productName = [NSString stringWithFormat:@"%@",n];
//    currAddedProdut.productURL = [NSString stringWithFormat:@"%@",u];
//    currAddedProdut.logoPicuture = [UIImage imageNamed:i];
//
//    if(!companyProducts)
//    {
//        companyProducts = [[NSMutableArray alloc] init];
//    }
//
//    [companyProducts addObject:currAddedProdut];
//
//    [self.companysEntireInfo setObject:companyProducts forKey:@"company products"];
//}













@end
