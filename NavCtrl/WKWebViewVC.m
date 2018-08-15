//
//  WKWebViewVC.m
//  NavCtrl
//
//  Created by Cristian Molina on 8/15/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "WKWebViewVC.h"
#import <WebKit/WebKit.h>



@implementation WKWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

   // self.productURL = @"https://www.apple.com/iphone/";
    
    NSURL *url = [NSURL URLWithString:self.productURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    _mainWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [_mainWebView loadRequest:request];
    _mainWebView.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_mainWebView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_mainWebView release];
    [super dealloc];
}


@end
