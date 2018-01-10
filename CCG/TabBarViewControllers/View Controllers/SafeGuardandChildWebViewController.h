//
//  SafeGuardandChildWebViewController.h
//  CCG
//
//  Created by sriram angajala on 15/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SafeGuardandChildWebViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *safeguardLable;
@property (strong, nonatomic) IBOutlet UIButton *safeGuardButton;

@property (strong,nonatomic)NSString *safeguarding;
@property (strong,nonatomic)NSString *childProtection;
@property (strong, nonatomic) IBOutlet UIButton *contactButton;
- (IBAction)contactClick:(id)sender;

- (IBAction)safeGuardButtonClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *childProtectionButton;

- (IBAction)childProtectionButtonClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIWebView *webview;










@end
