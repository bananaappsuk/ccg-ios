//
//  EditProfileViewController.m
//  CCG
//
//  Created by sriram angajala on 08/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController
{
    NSString *buttonStr,*alertMsg;
    UIImagePickerController *imagePicker;
    
    NSString *currentImageStr;
    NSString *imageData_base64;
    
    
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
    
    _currentPasswordTF.hidden = YES;
    _PasswordTF.hidden = YES;
    _confirmPasswordTF.hidden = YES;
    _submitButton.hidden = YES;
    
    buttonStr = @"0";
    //  self.submitLayoutConstraint.constant = -185;
}
-(void)viewWillAppear:(BOOL)animated
{
    _currentPasswordTF.hidden = YES;
    _PasswordTF.hidden = YES;
    _confirmPasswordTF.hidden = YES;
    _submitButton.hidden = YES;
    
    //[_changePasswordButton setTitle:@"ChangePassword" forState:UIControlStateNormal];
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

- (IBAction)changePasswordClick:(id)sender {
    if([buttonStr isEqualToString:@"0"])
    {
        buttonStr=@"1";
        [_changePasswordButton setTitle: @"Cancel" forState: UIControlStateNormal];
        _currentPasswordTF.hidden = NO;
        _PasswordTF.hidden = NO;
        _confirmPasswordTF.hidden = NO;
        _submitButton.hidden = NO;
        //   self.submitLayoutConstraint.constant = -185;
    }
    else if([buttonStr isEqualToString:@"1"])
    {
        buttonStr= @"0";
        [_changePasswordButton setTitle: @"ChangePassword" forState: UIControlStateNormal];
        _currentPasswordTF.hidden = YES;
        _PasswordTF.hidden = YES;
        _confirmPasswordTF.hidden = YES;
        _submitButton.hidden = YES;
        
        //  self.submitLayoutConstraint.constant = 185;
    }
    
}

- (IBAction)editButtonClick:(id)sender {
    // _submitButton.hidden = NO;
    
}

- (IBAction)submitClick:(id)sender {
}

@end
