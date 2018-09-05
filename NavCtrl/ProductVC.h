//
//  ProductVC.h
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKWebViewVC.h"
#import "CompnayMO+CoreDataClass.h"
#import "Product+CoreDataClass.h"
#import "CreationAndEditionVC.h"


@class Company;
@interface ProductVC : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (retain, nonatomic) IBOutlet UIView *emptyProductArrayView;
@property (nonatomic, retain) WKWebViewVC* wkwebViewController;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (retain, nonatomic) IBOutlet UILabel *companyLabel;
@property (retain, nonatomic) IBOutlet UIImageView *companyImage;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray<Product*>* products;
@property (nonatomic, retain) CompnayMO* currentCompany;

- (IBAction)addButton:(id)sender;

@end
