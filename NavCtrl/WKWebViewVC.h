//
//  WKWebViewVC.h
//  NavCtrl
//
//  Created by Cristian Molina on 8/15/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "CompnayMO+CoreDataClass.h"
#import "Product+CoreDataClass.h"

@interface WKWebViewVC : UIViewController
@property (strong, nonatomic) IBOutlet WKWebView* mainWebView;
@property (strong, nonatomic) NSString *productURL;
@property (retain, nonatomic)  CompnayMO* wKPCompany;
@property (retain, nonatomic)  Product* wkProdcut;


@end
