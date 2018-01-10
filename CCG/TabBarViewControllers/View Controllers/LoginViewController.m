//
//  LoginViewController.m
//  CCG
//
//  Created by sriram angajala on 07/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeScreenViewController.h"
#import "ApiClass.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "Validation.h"
#import "ForgotPasswordViewController.h"
#import "GlobalVariables.h"
#import "AppDelegate.h"
#import "GlobalVariables.h"
@interface LoginViewController ()<apiRequestProtocol>

@end

@implementation LoginViewController
{
    NSString *alertMsg;
    int loginFlag;
    UIAlertView *statusAlert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self.navigationController setNavigationBarHidden:YES animated:NO];
    _loginButton.layer.cornerRadius = 20.0;
    _loginButton.layer.borderColor=[UIColor whiteColor].CGColor;
    _loginButton.layer.borderWidth=1.0f;
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.passwordTF.leftView = paddingView;
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    
   UIImageView  *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginUser"]];
    arrow.frame = CGRectMake(0.0, 0.0, arrow.image.size.width+80.0, arrow.image.size.height);
    arrow.contentMode = UIViewContentModeCenter;
    
    _userNameTF.leftView = arrow;
    _userNameTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView  *arrow1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginPassword"]];
    arrow1.frame = CGRectMake(0.0, 0.0, arrow.image.size.width+80.0, arrow.image.size.height);
    arrow1.contentMode = UIViewContentModeCenter;
    
    
    _passwordTF.leftView = arrow1;
    _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    
       // _userNameTF.leftViewMode = UITextFieldViewModeAlways;
      //  _userNameTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginUser"]];
     //   _passwordTF.leftViewMode = UITextFieldViewModeAlways;
     //   _passwordTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginPassword"]];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)sendLoginRequest
{
    loginFlag =0;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSDictionary *loginData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   _userNameTF.text,@"Username",
                                   _passwordTF.text,@"Password",
                                   nil];
        
        [apiRequest SendHttpPost:loginData withUrl:@"http://ccg.bananaappscenter.com/api/User/Login" withrequestType:RequestTypeLogin];
        
    });
}

-(void)responseMethod:(id) responseObject withRequestType:(RequestType) requestType;
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if([responseObject isKindOfClass:[NSString class]])
        {
            [self showAlertWith:responseObject];
        }
        else{
            // RequestTypeLogin
            
            if(loginFlag == 0)
            {
                NSLog(@"%@",responseObject);
                NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                NSString * respStr = [NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseDict valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                  
               [[NSUserDefaults standardUserDefaults] setValue:[responseObject valueForKey:@"Name"] forKey:@"Name"];
                    
               [[NSUserDefaults standardUserDefaults] setValue:[responseObject valueForKey:@"User_Pic"] forKey:@"User_Pic"];
                    
               [[NSUserDefaults standardUserDefaults] setValue:[responseDict valueForKey:@"Message"] forKey:@"LoginMessage"];

               [[NSUserDefaults standardUserDefaults] setValue:[responseObject valueForKey:@"ID"] forKey:@"userId"];

               [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    _userNameTF.text = @"";
                    _passwordTF.text = @"";
                    [_checkBoxButton setImage:[UIImage imageNamed:@"UnCheckMark"] forState:UIControlStateNormal];
                    
//                    HomeScreenViewController *homeVC;
//                    homeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"HomeScreenViewController"];
//
//                    // hospVC.urlStringdignosticImage = [Dict valueForKey:@"centerimage"];
//
//                    [self.navigationController pushViewController:homeVC animated:YES];
                    
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        HomeScreenViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeScreenViewController"];
                    
                        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
                    
                    
                        UIWindow *window = [UIApplication sharedApplication].delegate.window;
                    
                        window.rootViewController = navigationController;
                    
                    
                }
             else if([respStr isEqualToString:@"401"])
                {
                    alertMsg= [responseObject valueForKey:@"Message"];
                    [self showAlertWith:alertMsg];
                }
               
                else
                {
                    alertMsg= [responseDict valueForKey:@"Message"];
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

-(void)showAlertWith:(NSString *)alertString{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"CCG"  message:alertString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    alertMsg= [NSMutableString stringWithFormat:@""];
    
}

#pragma mark - Keyboard Methods

- (void)keyboardWasShown:(NSNotification*)notification
{
    
}

- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    
    
    [self.userNameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _userNameTF)
    {
        //        if (textField.text.length >=16 && range.length == 0) {
        //            return NO;
        //        }
        if ([string isEqualToString:@" "] )
        {
            return NO;
        }
        
    }
    if (textField == _passwordTF)
    {
        if ([string isEqualToString:@" "])
        {
            return NO;
        }
    }
    
    return YES;
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

- (IBAction)checkBoxButtonClick:(id)sender {
    if( [[_checkBoxButton imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"UnCheckMark"]])
    {
        [_checkBoxButton setImage:[UIImage imageNamed:@"CheckMark"] forState:UIControlStateNormal];
    }
    else
    {
        [_checkBoxButton setImage:[UIImage imageNamed:@"UnCheckMark"] forState:UIControlStateNormal];
    }
}

- (IBAction)loginButtonClick:(id)sender {
     _checkBoxButton.selected  = ! _checkBoxButton.selected;
     Validation *validate = [Validation new];
    if (_userNameTF.text.length == 0) {
        alertMsg = [NSMutableString stringWithFormat:@"Enter User Name"];
        [self showAlertWith:alertMsg];

    }
    else if (![validate isNameString:_userNameTF.text])
    {
        alertMsg = [NSMutableString stringWithFormat:@"Enter Valid  User Name"];
        [self showAlertWith:alertMsg];

    }

    else if (_passwordTF.text.length == 0)
    {
        alertMsg = [NSMutableString stringWithFormat:@"Enter Password"];
        [self showAlertWith:alertMsg];

    }
    else if ( [[_checkBoxButton imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"UnCheckMark"]])
    {
        alertMsg= [NSMutableString stringWithFormat:@"Please Agree Terms and Conditions"];
        [self showAlertWith:alertMsg];
    }
    else
   {
       [[NSUserDefaults standardUserDefaults]setValue:_passwordTF.text forKey:@"userPassword"];
       [[NSUserDefaults standardUserDefaults]synchronize];
       [self sendLoginRequest];

    }
}

- (IBAction)forgotButtonClick:(id)sender {
    ForgotPasswordViewController *homeVC;
    homeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    
    // hospVC.urlStringdignosticImage = [Dict valueForKey:@"centerimage"];
    
    [self.navigationController pushViewController:homeVC animated:YES];
}

- (IBAction)agreeTermsClick:(id)sender {
    
//        statusAlert = [[UIAlertView alloc] initWithTitle:@"Agree Terms and Conditions"
//        message:@"By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. We are offering you this app to use for your own personal use without cost, but you should be aware that you cannot send it on to anyone else, and you’re not allowed to copy, or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages, or make derivative versions. The app itself, and all the trade marks, copyright, database rights and other intellectual property rights related to it, still belong to Chosen Care Group.Chosen care Group is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services.The Chosen Care Group app stores and processes personal data that you have provided to us so that you can book trainings or events. Its your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Chosen Care Group app won’t work properly or at all.The connection can be Wi-Fi, or provided by your mobile network provider, but Chosen Care Group cannot take responsibility for the app not working at full functionality if you dont have access to Wi-Fi, and you dont have any of your data allowance left.If you are using the app outside of an area with WiFi, you should remember that your terms of agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. In using the app, youa re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app. Along the same lines, Chosen Care Group cannot always take responsibility for the way you use the app. At some point we may wish to update the app. The app is currently available on Android and iOS the requirements for both systems (and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. Chosen Care Group does not promise that it will always update the app so that it is relevant to you and/or works with the iOS/Android version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, we may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device."
//                                                delegate:self
//                                       cancelButtonTitle:@"OK"
//                                       otherButtonTitles:nil];
//
//        [statusAlert show];
     PopAlertView *cv = [GlobalVariables popupAlert];
    
    [self.view addSubview:cv];
    
    

}
@end
