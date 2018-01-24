//
//  ProfileViewController.m
//  CCG
//
//  Created by sriram angajala on 04/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "ProfileViewController.h"
#import "ApiClass.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "Validation.h"
#import "ContactUsViewController.h"
@interface ProfileViewController ()<apiRequestProtocol>

@end

@implementation ProfileViewController
{
    NSString *buttonStr,*alertMsg,*editStr,*UserId;
    UIImagePickerController *imagePicker;
    
    NSString *currentImageStr;
    NSString *imageData_base64;
    NSString *passwordString;
    
    UIImage *image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userView.layer.shadowColor = [UIColor blackColor].CGColor;
    _userView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _userView.layer.shadowOpacity = 0.9f;
    
    _userExtraView.layer.shadowColor = [UIColor blackColor].CGColor;
    _userExtraView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _userExtraView.layer.shadowOpacity = 0.9f;
    
    _changePasswordButton.layer.shadowColor = [UIColor blackColor].CGColor;
    _changePasswordButton.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _changePasswordButton.layer.shadowOpacity = 0.6f;
    
    _currentPasswordTF.hidden = YES;
    _PasswordTF.hidden = YES;
    _confirmPasswordTF.hidden = YES;
    _submitButton.hidden = YES;
    
    _usernameTF.userInteractionEnabled = NO;
    _titleTF.userInteractionEnabled = NO;
    _firstNameTF.userInteractionEnabled = NO;
    _lastNameTF.userInteractionEnabled = NO;
    
    _userEmailTF.userInteractionEnabled = NO;
    _userPhoneTF.userInteractionEnabled = NO;
    _imageChangeButton.userInteractionEnabled = NO;
    
    
    [_userEmailTF setKeyboardType:UIKeyboardTypeEmailAddress];
    [_userPhoneTF setKeyboardType:UIKeyboardTypePhonePad];
   
   //  self.submitLayoutConstraint.constant = -160;
    
    UserId = [[NSUserDefaults standardUserDefaults]valueForKey:@"userId"];
    
    passwordString = [[NSUserDefaults standardUserDefaults]valueForKey:@"userPassword"];
    
    [self GetProfileData];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    buttonStr = @"0";
    editStr = @"0";
    _currentPasswordTF.hidden = YES;
    _PasswordTF.hidden = YES;
    _confirmPasswordTF.hidden = YES;
    _submitButton.hidden = YES;
    _currentPasswordTF.text = @"";
    _PasswordTF.text = @"";
    _confirmPasswordTF.text = @"";
   // [_changePasswordButton setTitle:@"ChangePassword" forState:UIControlStateNormal];
}

-(void)viewDidDisappear:(BOOL)animated
{
     [_changePasswordButton setTitle:@"ChangePassword" forState:UIControlStateNormal];
}


-(void)showAlertWith:(NSString *)alertString{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"CCG"  message:alertString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction*  action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    alertMsg= [NSMutableString stringWithFormat:@""];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _currentPasswordTF)
    {
        //        if (textField.text.length >=16 && range.length == 0) {
        //            return NO;
        //        }
        if ([string isEqualToString:@" "] )
        {
            return NO;
        }
        
    }
    if (textField == _PasswordTF)
    {
        if ([string isEqualToString:@" "])
        {
            return NO;
        }
    }
    if (textField == _confirmPasswordTF)
    {
        if ([string isEqualToString:@" "])
        {
            return NO;
        }
    }
    
    return YES;
}



- (IBAction)imageChangeButtonClick:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *startNewSession = [UIAlertAction actionWithTitle:@"Take a Photo"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                                [self pushTakePhotoScreenInDelegate];
                                                            }];
    
    UIAlertAction *gal = [UIAlertAction actionWithTitle:@"Choose from your Gallery"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        [self pushChoosePhotoScreenInDelegate];
                                                        }];
    
    UIAlertAction *doNothingAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                            }];
    
    // Add actions to the controller so they will appear
    [alert addAction:gal];
    [alert addAction:startNewSession];
    [alert addAction:doNothingAction];
    [self presentViewController:alert animated:YES completion:nil];
   
}

-(void)pushTakePhotoScreenInDelegate{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)pushChoosePhotoScreenInDelegate{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    UIImage *chosenImage = [info objectForKey:UIImagePickerControllerEditedImage];

    NSData *imagData = [[NSData alloc] initWithData:UIImageJPEGRepresentation((chosenImage), 1.0)];

    NSLog(@"original image size ::: %@",[NSByteCountFormatter stringFromByteCount:imagData.length countStyle:NSByteCountFormatterCountStyleFile]);

    CGSize imageSize =  CGSizeMake(79, 79);

    UIImage *resizedImage = [self imageWithImage:chosenImage scaledToSize:imageSize];

    [_imageChangeButton setImage:resizedImage forState:UIControlStateNormal];

//    _imageButton.layer.borderWidth=1.0f;
//    _imageButton.layer.cornerRadius = 80/2.0f;
//    _imageButton.clipsToBounds = YES;

    NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation((resizedImage), 1.0)];

    NSLog(@"resized image size ::: %@",[NSByteCountFormatter stringFromByteCount:imageData.length countStyle:NSByteCountFormatterCountStyleFile]);

    [picker dismissViewControllerAnimated:YES completion:NULL];

}

-(UIImage *)imageWithImage:(UIImage*)givenImage scaledToSize:(CGSize)newSize
{
    // Create a bitmap context.
    UIGraphicsBeginImageContextWithOptions(newSize, YES, [UIScreen mainScreen].scale);
    [givenImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}

- (NSString *)encodeToBase64String:(UIImage *)givenImage {
    return [UIImagePNGRepresentation(givenImage) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

-(void)GetProfileData
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        NSString *urlStr = [NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/User/Profile?UserID=%@",UserId];
        
        [apiRequest SendHttpGetwithUrl:urlStr withrequestType:RequestTypeGetProfile];
    });
    
    
}

-(void)EditProfileRequest
{
    
    NSString *imageData_base64 = [self encodeToBase64String:_imageChangeButton.imageView.image];
    
    if([imageData_base64 isEqualToString:@""] || imageData_base64 == nil)
    {
        imageData_base64 = @"";
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSDictionary *profileData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      UserId,@"ID",
                                     _userEmailTF.text,@"Email",
                                     _userPhoneTF.text,@"Mobile",
                                     imageData_base64,@"User_Pic",
                                     
                                     nil];
        
        [apiRequest SendHttpPost:profileData withUrl:@"http://ccg.bananaappscenter.com/api/User/ProfileUpdate" withrequestType:RequestTypeEditProfile];
        
    });
    
    
}

-(void)ChangePasswordRequest
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSDictionary *passwordData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      UserId,@"ID",
                                      _confirmPasswordTF.text,@"Password",
                                      nil];
        
        [apiRequest SendHttpPost:passwordData withUrl:@"http://ccg.bananaappscenter.com/api/User/ChangePassword" withrequestType:RequestTypeChangePassword];
        
    });
    
    
}


-(void)responseMethod:(id) responseObject withRequestType:(RequestType) requestType;
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // NSMutableDictionary *userinfo;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if([responseObject isKindOfClass:[NSString class]])
        {
            [self showAlertWith:responseObject];
        }
        else{
            
            if(requestType == RequestTypeEditProfile)
            {
                NSLog(@"%@",responseObject);
                // NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                
                if([respCode isEqualToString:@"200"])
                {
                    //    [[NSUserDefaults standardUserDefaults] setObject: [responce valueForKey:@"user_name"] forKey:@"UserName"];
                    //    [[Constants getUserDefaults] setObject: [responce valueForKey:@"profile_pic"] forKey:@"UserProfilePic"];
                    
                    // [Constants showMessage:@"Profile updated successfully" withTitle:@"Success"];
                    
                    UIAlertController * alert=[UIAlertController
                                               
                                               alertControllerWithTitle:@"Success" message:@"Profile updated successfully" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* noButton = [UIAlertAction
                                               actionWithTitle:@"OK"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action)
                                               {
                                                   //   [self.navigationController popToRootViewControllerAnimated:YES];
                                                   
                                                   [self GetProfileData];
                                                   
                                               }];
                    
                    [alert addAction:noButton];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                }
                else
                {
                    alertMsg= [responseObject valueForKey:@"Message"];
                    [self showAlertWith:alertMsg];
                    
                }
            }
         else  if(requestType == RequestTypeChangePassword)
            {
                NSLog(@"%@",responseObject);
                // NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                    
                
                   // alertMsg= [responseObject valueForKey:@"Message"];
                   // [self showAlertWith:alertMsg];
                    
                    _currentPasswordTF.text = @"";
                    _PasswordTF.text = @"";
                    _confirmPasswordTF.text = @"";
                    
                    
                    [self.navigationController popToRootViewControllerAnimated:NO];
                    
                }
                else
                {
                    alertMsg= [responseObject valueForKey:@"Message"];
                    [self showAlertWith:alertMsg];
                    
                }
                
            }
            
            else if(requestType == RequestTypeGetProfile)
            {
                NSLog(@"%@",responseObject);
                // NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                
                //   NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                
                NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseDict valueForKey:@"StatusCode"]];
                
                if([respCode isEqualToString:@"200"])
                {

                    
                    _userEmailTF.text = [responseObject valueForKey:@"Email"];
                    _userPhoneTF.text = [responseObject valueForKey:@"Mobile"];
                    _mailLabel.text = [responseObject valueForKey:@"Email"];
                    _firstNameTF.text = [responseObject valueForKey:@"Name"];
                    _titleTF.text = [responseObject valueForKey:@"Title"];
                    _lastNameTF.text = [responseObject valueForKey:@"LastName"];
                    _usernameTF.text = [responseObject valueForKey:@"Username"];
                    
                    
                  NSString *imageStr = [responseObject valueForKey:@"User_Pic"];
                    
                    
                    [[NSUserDefaults standardUserDefaults]setValue:imageStr forKey:@"User_Pic"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                //    NSString *textLine = imageStr;
                //    textLine = [textLine stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
                    
                //    NSString *imageStr = [userInfo valueForKey:@"profile_pic"];
                    
                    if([imageStr isEqualToString:@""])
                    {
                        [_imageChangeButton setImage:[UIImage imageNamed:@"NoImage"] forState:UIControlStateNormal];
                    }
                    else
                    {
                        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
                        dispatch_async(queue, ^{
//                            NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[textLine stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                             NSData *data = [[NSData alloc] initWithBase64EncodedString:imageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [_imageChangeButton setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];

                            });
                        });
                   
                       
                        
                  //      [_imageChangeButton setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
                    }

                }
                else
                {
                    alertMsg= [responseObject valueForKey:@"Message"];
                    [self showAlertWith:alertMsg];
                    
                }
            }
            else{
                
                alertMsg= [NSMutableString stringWithFormat:@"Try After Some Time"];
                [self showAlertWith:alertMsg];
                
            }
        }
    });
    
}


- (IBAction)changePasswordClick:(id)sender {
    if([buttonStr isEqualToString:@"0"])
    {
        buttonStr=@"1";
        [_changePasswordButton setTitle: @"Cancel" forState: UIControlStateNormal];
        _currentPasswordTF.hidden = NO;
        _PasswordTF.hidden = NO;
        _confirmPasswordTF.hidden = NO;
        _submitButton.hidden = NO;
       //  self.submitLayoutConstraint.constant = 170;
    }
    else if([buttonStr isEqualToString:@"1"])
    {
        buttonStr= @"0";
        [_changePasswordButton setTitle: @"ChangePassword" forState: UIControlStateNormal];
        _currentPasswordTF.hidden = YES;
        _PasswordTF.hidden = YES;
        _confirmPasswordTF.hidden = YES;
        _submitButton.hidden = YES;
        
        _currentPasswordTF.text = @"";
        _PasswordTF.text = @"";
        _confirmPasswordTF.text = @"";
       // self.submitLayoutConstraint.constant = -160;
    }
  
}

- (IBAction)editButtonClick:(id)sender {
    Validation *validate = [Validation new];
    
    if([editStr isEqualToString:@"0"])
    {
        editStr=@"1";
        [_editButton setTitle: @"Save" forState: UIControlStateNormal];
       
          _userEmailTF.userInteractionEnabled = YES;
          _userPhoneTF.userInteractionEnabled = YES;
          _imageChangeButton.userInteractionEnabled = YES;
        
    }
    else if([editStr isEqualToString:@"1"])
    {
        editStr= @"0";
       
        
      
        if (_userEmailTF.text.length == 0) {
            alertMsg = [NSMutableString stringWithFormat:@"Enter User Name"];
            [self showAlertWith:alertMsg];
        }
        else if (_userPhoneTF.text.length == 0)
        {
            alertMsg = [NSMutableString stringWithFormat:@"Enter Mobile Number"];
            [self showAlertWith:alertMsg];
        }
        else if (![validate isEmailString:_userEmailTF.text])
        {
            alertMsg = [NSMutableString stringWithFormat:@"Enter Valid Email"];
            [self showAlertWith:alertMsg];
            
        }
        else if (![validate isPhoneNumString:_userPhoneTF.text])
        {
            alertMsg = [NSMutableString stringWithFormat:@"Enter Valid Mobile Number"];
            [self showAlertWith:alertMsg];
            
        }
        else
        {
            
            [_editButton setTitle: @"Edit" forState: UIControlStateNormal];
            
            _userEmailTF.userInteractionEnabled = NO;
            _userPhoneTF.userInteractionEnabled = NO;
            _imageChangeButton.userInteractionEnabled = NO;
            [self EditProfileRequest];
        }
       
    }
    
}

- (IBAction)contactusClick:(id)sender {
    
    ContactUsViewController *contactVC;
    contactVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ContactUsViewController"];
    
    // hospVC.urlStringdignosticImage = [Dict valueForKey:@"centerimage"];
    
    [self.navigationController pushViewController:contactVC animated:YES];
}

- (IBAction)submitClick:(id)sender {
    
    if (_currentPasswordTF.text.length == 0) {
        alertMsg = [NSMutableString stringWithFormat:@"Enter Current Password"];
        [self showAlertWith:alertMsg];
    }
    else if (![_currentPasswordTF.text isEqualToString:passwordString])
    {
        alertMsg = [NSMutableString stringWithFormat:@"Invalid Current Password"];
        [self showAlertWith:alertMsg];
    }
    else if (_PasswordTF.text.length == 0)
    {
        alertMsg = [NSMutableString stringWithFormat:@"Enter New Password"];
        [self showAlertWith:alertMsg];
    }
    else if (_confirmPasswordTF.text.length == 0)
    {
        alertMsg = [NSMutableString stringWithFormat:@"Enter Confirm Password"];
        [self showAlertWith:alertMsg];
    }
    else if (![_PasswordTF.text isEqualToString:_confirmPasswordTF.text])
    {
        alertMsg= [NSMutableString stringWithFormat:@"Password and Confirm Password does not match"];
        [self showAlertWith:alertMsg];
        
    }
        
    else
    {
        
        [self ChangePasswordRequest];
    }
    
}
@end
