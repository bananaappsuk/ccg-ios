//
//  ForgotPasswordViewController.m
//  CCG
//
//  Created by sriram angajala on 20/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "ApiClass.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "Validation.h"
@interface ForgotPasswordViewController ()<apiRequestProtocol>

@end

@implementation ForgotPasswordViewController
{
    NSString *alertMsg;
    UIAlertController * alert;
    UIAlertAction* yesButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      [self.navigationController setNavigationBarHidden:NO animated:NO];
    _submitButton.layer.cornerRadius = 20.0;
    _submitButton.layer.borderColor=[UIColor whiteColor].CGColor;
    _submitButton.layer.borderWidth=1.0f;
    
    [_emailTF setKeyboardType:UIKeyboardTypeEmailAddress];
}
-(void)viewWillAppear:(BOOL)animated
{
     [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    
    self.navigationController.navigationBar.backItem.title = @" ";
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:120.0f/255.0f green:120.0f/255.0f blue:130.0f/255.0f alpha:1.0f]}];
    
    //    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor]};
    //
    //    self.navigationItem.title = @"Home";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"]style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(HomeView)];
    [backButton setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = backButton;
    
    //    UIImage *image = [UIImage imageNamed:@"LogoIcon"];
    //    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    //
    
    self.navigationItem.title = @"Choosen Care Group";
}
-(void)HomeView
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)serviceCall
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
         NSString *strURL=[NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/User/ForgotPassword?User_Email=%@",_emailTF.text];
        
        NSDictionary *emailData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   _emailTF.text,@"User_Email",
                                    nil];
        
        [apiRequest SendHttpPost:emailData withUrl:strURL withrequestType:RequestTypeForgotPassword];
        
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
            
            if(requestType == RequestTypeForgotPassword)
            {
                NSLog(@"%@",responseObject);
               // NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                NSString * respStr = [NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                 
                    
                    
                    
                    alert=[UIAlertController
                           
                           alertControllerWithTitle:@"CCG" message:[responseObject valueForKey:@"Message"]
                           preferredStyle:UIAlertControllerStyleAlert];
                    
                    yesButton = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                     _emailTF.text = @"";
                                     
                                     [self HomeView];
                                     
                                 }];
                    
                    
                    
                    [alert addAction:yesButton];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                
                }
                else if([respStr isEqualToString:@"401"])
                {
                    alertMsg= [responseObject valueForKey:@"Message"];
                    [self showAlertWith:alertMsg];
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
-(void)showAlertWith:(NSString *)alertString{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"CCG"  message:alertString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    alertMsg= [NSMutableString stringWithFormat:@""];
    
}

- (IBAction)submitClick:(id)sender {
    Validation *validate = [Validation new];
    if (_emailTF.text.length == 0) {
        alertMsg = [NSMutableString stringWithFormat:@"Enter Email"];
        [self showAlertWith:alertMsg];
    }
    else if (![validate isEmailString:_emailTF.text])
    {
        alertMsg = [NSMutableString stringWithFormat:@"Enter Valid  Email"];
        [self showAlertWith:alertMsg];
        
    }
    else
    {
        [self serviceCall];
    }

    
}

- (IBAction)phoneButtonClick:(id)sender {
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:_adminstrativeNumLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
@end
