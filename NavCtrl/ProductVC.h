//
//  ProductVC.h
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKWebViewVC.h"


@interface ProductVC : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) WKWebViewVC* wkwebViewController;

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSMutableArray* productURLS;
@property (nonatomic, retain) NSMutableArray* logoPicuture;


@property (nonatomic, retain) NSString* currentKeyProduct;
@property (nonatomic, retain) NSMutableDictionary* productDictionary;





@end
