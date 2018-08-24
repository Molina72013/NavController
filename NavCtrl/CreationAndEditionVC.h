//
//  CreationAndEditionVC.h
//  NavCtrl
//
//  Created by Cristian Molina on 8/20/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
@interface CreationAndEditionVC : UIViewController <UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *companyNameInput;
@property (retain, nonatomic) IBOutlet UITextField *companyURLInput;
@property (retain, nonatomic) IBOutlet UITextField *apiInput;
@property (retain, nonatomic) IBOutlet Company* currCompany;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *centercon;


@property (retain, nonatomic) IBOutlet UIView *theView;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;


@end
