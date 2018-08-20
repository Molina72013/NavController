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
@property (nonatomic, retain) NSString* companyLogoName;


-(instancetype)initWithName: (NSString*) name andLogo:(NSString*) logo;





@property (nonatomic, retain) NSMutableArray<Products *> *companyProducts;
//@property (nonatomic, retain) NSMutableDictionary* companysEntireInfo;
//-(void) addProducts:(NSString*)n i:(NSString*)i u:(NSString*)u;





@end
