//
//  ProfileViewController.h
//  CCG
//
//  Created by sriram angajala on 04/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *submitLayoutConstraint;

@property (strong, nonatomic) IBOutlet UIView *userView;
@property (strong, nonatomic) IBOutlet UIView *userExtraView;
@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *titleTF;
@property (strong, nonatomic) IBOutlet UILabel *mailLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *userMailLabel;



@property (strong, nonatomic) IBOutlet UIButton *editButton;

@property (strong, nonatomic) IBOutlet UIButton *changePasswordButton;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UITextField *currentPasswordTF;
@property (strong, nonatomic) IBOutlet UITextField *PasswordTF;

@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTF;
@property (strong, nonatomic) IBOutlet UIButton *imageChangeButton;

@property (strong, nonatomic) IBOutlet UIButton *contactusButton;

- (IBAction)contactusClick:(id)sender;


- (IBAction)imageChangeButtonClick:(id)sender;

- (IBAction)changePasswordClick:(id)sender;
- (IBAction)editButtonClick:(id)sender;
- (IBAction)submitClick:(id)sender;


@end
