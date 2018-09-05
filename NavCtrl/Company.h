//
//  Company.h
//  NavCtrl
//
//  Created by Cristian Molina on 8/16/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Products;
@interface Company : NSObject

@property (nonatomic, retain) NSString *companyName;
@property (nonatomic, retain) NSString* companyLogoURL;
@property (nonatomic, retain) NSString* companyAPI;
@property (nonatomic) float companyAPIValue;
@property (nonatomic, retain) NSMutableArray<Products *> *companyProducts;

-(instancetype)initWithName: (NSString*) name api:(NSString*)api andLogo:(NSString*) logo;




@end
