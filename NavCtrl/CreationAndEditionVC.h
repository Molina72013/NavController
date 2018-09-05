//
//  CreationAndEditionVC.h
//  NavCtrl
//
//  Created by Cristian Molina on 8/20/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "CompnayMO+CoreDataClass.h"
#import "ImageFetcher.h"
#import "Product+CoreDataClass.h"

@interface CreationAndEditionVC : UIViewController <UITextFieldDelegate>
//TEXTFIELDS
@property (retain, nonatomic) IBOutlet UITextField *nameTextField;
@property (retain, nonatomic) IBOutlet UITextField *iconTextField;
@property (retain, nonatomic) IBOutlet UITextField *thirdTextField;
@property (retain, nonatomic) IBOutlet UITextField *productPriceField;

//DELETE BUTTON FUNCTIONALITY AND CONSTRAINT(for the top)
@property (retain, nonatomic) IBOutlet UIButton *deleteButtonAppearance;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *deleteButtonTopConstraint;
@property (retain, nonatomic) IBOutlet UIView *theView;
@property (retain, nonatomic)  CompnayMO* currCompany;//CompanyVC
@property (retain, nonatomic)  CompnayMO* currCompanyForProduct;//ProductVC
@property (retain, nonatomic)  Product* currProductForCompany;//ProdcutVC
//FUNCTIONS
- (IBAction)deleteButton:(id)sender;
@end
