//
//  CreationAndEditionVC.m
//  NavCtrl
//
//  Created by Cristian Molina on 8/20/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "CreationAndEditionVC.h"
#import "Companies.h"
#import "CompanyVC.h"
#import "NavControllerAppDelegate.h"

@interface CreationAndEditionVC () {
    CGRect newFrame;
}
@end

@implementation CreationAndEditionVC

- (void)viewDidLoad {
    [super viewDidLoad];
   UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButton;
    self.navigationItem.leftBarButtonItem = cancelButton;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybaordWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self loadPlaceHoldersAndText];
    
    [cancelButton release];
    [saveButton release];

}

-(void) keyboardWasShown:(NSNotification *)notification
{

//    //GET THE FRAME FOR THE KEYBOARD
    NSValue* keyboardEndFramValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keybaordEngFrame = [keyboardEndFramValue CGRectValue];

    //GET THE KEYBAORD DUATION TIME
    NSNumber* animationDurationNumber = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = [animationDurationNumber doubleValue];

    NSNumber* animationCurveNumber = [[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = [animationCurveNumber intValue];
    UIViewAnimationOptions animationOptions = animationCurve << 16;

    [UIView animateWithDuration:animationDuration //NSTimeInterval
                          delay:0.0
                        options:animationOptions //UIViewAnimationOptions
                     animations:^{
                          CGRect textFieldFrame = newFrame;
   
                         textFieldFrame.origin.y = (textFieldFrame.origin.y - keybaordEngFrame.origin.y) +
                         textFieldFrame.size.height + 5;
                         //self.theView.frame = textFieldFrame;
                        // distance = self.theView.frame.origin.y;
                         CGRect theViewFrame = self.theView.frame;
                         //
                         //
                         theViewFrame.origin.y = (int)-textFieldFrame.origin.y;
                  
                         //distance = (int)-textFieldFrame.origin.y;

                         [self.theView setTranslatesAutoresizingMaskIntoConstraints:true];

                         self.theView.frame = theViewFrame;

                     }
                     completion:^(BOOL finished) {

                   }];
    
}

-(void) keybaordWillHide:(NSNotification *)notification
{
    [self.theView setTranslatesAutoresizingMaskIntoConstraints:false];
}

//  Activates when keybaord pops out
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    newFrame = textField.frame;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //nothing
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
////    The enter button on keyboard
//    [textField resignFirstResponder];
//    return true;

    NSInteger nextTag = textField.tag + 1;
    UIResponder* nextResponder = [self.view viewWithTag:nextTag];
    if (nextResponder && textField.returnKeyType != UIReturnKeyDone) {
        [nextResponder becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}





-(void) cancel
{
    [self.view endEditing:true];
    [self dismissViewControllerAnimated:NO completion:nil];
  //  [self.navigationController popToRootViewControllerAnimated:YES];
    if(_currCompanyForProduct){
    [self.navigationController popToViewController:self.navigationController.viewControllers[1]   animated:YES];
    } else
    {
        [self.navigationController popViewControllerAnimated:true];
        
    }
}




-(void) save
{
    if(![_nameTextField.text  isEqual: @""] && ![_iconTextField.text  isEqual: @""] && ![_thirdTextField.text  isEqual: @""])
    {
        NSString* name = _nameTextField.text;
        NSString* logo = _iconTextField.text;
        NSString* thirdTextField = _thirdTextField.text;
        float pricing = [_productPriceField.text floatValue];

        if(_currProductForCompany && _currCompanyForProduct)
        {
            [Companies.theCompanies editProduct:_currProductForCompany forCompany:_currCompanyForProduct withName:name andLogo:logo andURL:thirdTextField price:pricing];
            [self dismissViewControllerAnimated:NO completion:nil];
            [self.navigationController popToViewController:self.navigationController.viewControllers[1]   animated:YES];
        } else if (_currCompanyForProduct)
        {
            [Companies.theCompanies addProductForCompany:_currCompanyForProduct prodcutName:name logo:logo andURL:thirdTextField price:pricing];
            
            [self dismissViewControllerAnimated:NO completion:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } else if (_currCompany)
        {
            [Companies.theCompanies editCompany:_currCompany editedName:name editedLogo:logo edittedApi:thirdTextField];
            [self dismissViewControllerAnimated:NO completion:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } else
        {
            [Companies.theCompanies addCompany:name api:thirdTextField logo:logo];
            [self dismissViewControllerAnimated:NO completion:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }

}


-(void) loadPlaceHoldersAndText
{
    self.nameTextField.delegate = self;
    self.iconTextField.delegate = self;
    self.thirdTextField.delegate = self;
    self.productPriceField.delegate = self;
    if(_currCompanyForProduct)
    {
        _thirdTextField.placeholder = @"Product URL";
        _nameTextField.placeholder = @"Name Of Product";
        _iconTextField.placeholder = @"Product Image URL";
        _productPriceField.placeholder = @"Price of Product";
    } else
    {
        _thirdTextField.placeholder = @"Company API";
        _nameTextField.placeholder = @"Name Of Company";
        _iconTextField.placeholder = @"Company Image URL";
    }
    
    
    if(_currProductForCompany && _currCompanyForProduct)
    {
        _nameTextField.text = _currProductForCompany.name;
        _iconTextField.text = _currProductForCompany.image;
        _thirdTextField.text = _currProductForCompany.prodcutURL;
        _productPriceField.text = [NSString stringWithFormat:@"%.2f", _currProductForCompany.price];
        
    } else if (_currCompanyForProduct)
    {
        _nameTextField.text = @"";
        _iconTextField.text = @"";
        _thirdTextField.text = @"";
        _productPriceField.text = @"";
        [_deleteButtonAppearance setHidden:true];

    }
    else if (_currCompany)
    {
        _nameTextField.text = _currCompany.name;
        _iconTextField.text = _currCompany.logo ;
        _thirdTextField.text = _currCompany.api;
        [_thirdTextField setReturnKeyType:UIReturnKeyDone];
        _deleteButtonTopConstraint.constant = -(_thirdTextField.frame.size.height - 5);
        [_productPriceField setHidden:TRUE];    

    } else
    {
        _nameTextField.text = @"";
        _iconTextField.text = @"";
        _thirdTextField.text = @"";
        [_thirdTextField setReturnKeyType:UIReturnKeyDone];
        [_productPriceField setHidden:TRUE];
        [_deleteButtonAppearance setHidden:true];
        

    }
}

- (IBAction)deleteButton:(id)sender {

    if(_currProductForCompany && _currCompanyForProduct)
    {
        [Companies.theCompanies deleteProduct:_currProductForCompany company:_currCompanyForProduct];
        [self.view endEditing:true];
        [self dismissViewControllerAnimated:NO completion:nil];
        [self.navigationController popToViewController:self.navigationController.viewControllers[1]   animated:YES];
        
    } else if (_currCompany)
    {
        [Companies.theCompanies deleteCompany: _currCompany];
        [self.view endEditing:true];
        [self dismissViewControllerAnimated:NO completion:nil];
         [self.navigationController popViewControllerAnimated:true];
    } else
    {
        NSLog(@"The button should of be inivisible");
    }
    
    
    
    
}



- (void)dealloc { //double-check
  
    [[ NSNotificationCenter defaultCenter ] removeObserver:self ];
   
    
    [_nameTextField release];
    [_iconTextField release];
    [_thirdTextField release];
    [_currCompany release];
    [_deleteButtonTopConstraint release];

    [_theView release];
    [_currProductForCompany release];
    [_productPriceField release];
    [_currCompanyForProduct release];
    [_deleteButtonAppearance release];
     [super dealloc];

}

@end
