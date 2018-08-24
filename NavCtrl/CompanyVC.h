//
//  CompanyVC.h
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductVC.h"
#import "Companies.h"
#import "Company.h"
#import "CreationAndEditionVC.h"
@interface CompanyVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray<Company*> *companyList;
@property (nonatomic, retain) ProductVC *productViewController;
@property (nonatomic, retain) CreationAndEditionVC* creationViewController;








@end
