//
//  ForgotPasswordViewController.h
//  CCG
//
//  Created by sriram angajala on 20/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *emailTF;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UILabel *adminstrativeNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *adminstrativeNumLabel;
@property (strong, nonatomic) IBOutlet UIButton *phoneButton;

- (IBAction)submitClick:(id)sender;
- (IBAction)phoneButtonClick:(id)sender;

@end
