//
//  SafeGuardingViewController.h
//  CCG
//
//  Created by sriram angajala on 11/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SafeGuardingViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *safeGuardTextView;
@property (strong, nonatomic) IBOutlet UIButton *safeGuardButton;
- (IBAction)safeGuardButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIWebView *webview;

@end
