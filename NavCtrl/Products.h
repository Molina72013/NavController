//
//  Products.h
//  NavCtrl
//
//  Created by Cristian Molina on 8/16/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Products : NSObject
@property (nonatomic, retain) NSString *productName;
@property (nonatomic, retain) NSString* productURL;
@property (nonatomic, retain) NSString* productLogo;

-(instancetype) initWithName:(NSString*)name andLogo:(NSString*)logo andURL:(NSString*)URL;



@end
