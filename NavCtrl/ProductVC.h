//
//  ProductVC.h
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKWebViewVC.h"

@class Company;
@interface ProductVC : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) WKWebViewVC* wkwebViewController;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *products;
@property (nonatomic, retain) Company* currentCompany;



@end
