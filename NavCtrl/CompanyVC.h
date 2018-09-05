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
#import "CompnayMO+CoreDataClass.h"
//@import CoreData;
#import "ImageFetcher.h"




@interface CompanyVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray<CompnayMO*> *companyList;
@property (nonatomic, retain) ProductVC *productViewController;
@property (retain, nonatomic) IBOutlet UIView *emptyArrayView;

//FUNCTION
- (IBAction)addButton:(id)sender;

@end
