//
//  LoginViewController.h
//  CCG
//
//  Created by sriram angajala on 07/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACFloatingTextfield-Objc/ACFloatingTextField.h>
@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userNameTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;

@property (strong, nonatomic) IBOutlet UIButton *checkBoxButton;
@property (strong, nonatomic) IBOutlet UIButton *forgotPasswordButton;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)checkBoxButtonClick:(id)sender;
- (IBAction)loginButtonClick:(id)sender;
- (IBAction)forgotButtonClick:(id)sender;

- (IBAction)agreeTermsClick:(id)sender;

@end
