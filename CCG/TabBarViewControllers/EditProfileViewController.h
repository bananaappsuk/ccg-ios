//
//  EditProfileViewController.h
//  CCG
//
//  Created by sriram angajala on 08/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *submitLayoutConstraint;

@property (strong, nonatomic) IBOutlet UIView *userView;
@property (strong, nonatomic) IBOutlet UIView *userExtraView;
@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *titleTF;

@property (strong, nonatomic) IBOutlet UITextField *mailTF;

@property (strong, nonatomic) IBOutlet UITextField *phoneNumTF;


@property (strong, nonatomic) IBOutlet UIButton *editButton;

@property (strong, nonatomic) IBOutlet UIButton *changePasswordButton;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UITextField *currentPasswordTF;
@property (strong, nonatomic) IBOutlet UITextField *PasswordTF;

@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTF;
@property (strong, nonatomic) IBOutlet UIButton *imageChangeButton;




- (IBAction)imageChangeButtonClick:(id)sender;

- (IBAction)changePasswordClick:(id)sender;
- (IBAction)editButtonClick:(id)sender;
- (IBAction)submitClick:(id)sender;
@end
