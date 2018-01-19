//
//  JobsDetailViewController.m
//  CCG
//
//  Created by sriram angajala on 05/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "JobsDetailViewController.h"
#import "JobsViewController.h"
#import "GlobalVariables.h"
#import "CustomIOSAlertView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ApiClass.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <Social/Social.h>
#define Device_Width [[UIScreen mainScreen] bounds].size.width
#define Device_Height [[UIScreen mainScreen] bounds].size.height

#define IMAGE_HEIGHT 160
#define NO_Of_Pages 5
#define PAGE_CONTROL_WIDTH 120
#define PAGE_CONTROL_HEIGHT 25
@interface JobsDetailViewController ()<CustomIOSAlertViewDelegate,apiRequestProtocol>

@end

@implementation JobsDetailViewController
{
    NSMutableArray *imagesArray;
    NSMutableArray *imgArr;
    UIImageView *image;
    NSString *jobid;
    NSString *userid;
    NSString *moduleType;
    NSString *alertMsg;
    NSString *jobModuleID;
    UIAlertController * alert;
    UIAlertAction* yesButton;
    UIAlertAction* noButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    imagesArray = [NSMutableArray new];
    
 //   imagesArray = [NSMutableArray arrayWithObjects:@"sample1",@"sample2",@"Sample",@"Sample",@"Sample", nil];
     userid = [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
     moduleType = @"2";
    _registerButton.layer.cornerRadius = 20.0;
    _registerButton.layer.borderColor=[UIColor whiteColor].CGColor;
    _registerButton.layer.borderWidth=1.0f;
    
   
    _photoView.hidden =YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([moduleType isEqualToString:_homeStr]) {
        
       jobModuleID = [[NSUserDefaults standardUserDefaults] valueForKey:@"jobModuleId"];
      [self getJob];
        
    }
    else
    {
        
        [self.jobImageView sd_setImageWithURL:[NSURL URLWithString:self.urlStringjobImage] placeholderImage:[UIImage imageNamed:@"NoImage"]];
        
        FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
        content.contentURL = [NSURL
                              URLWithString:self.urlStringjobImage];
        FBSDKShareButton *shareButton = [[FBSDKShareButton alloc] init];
        shareButton.shareContent = content;
        
        shareButton.frame = CGRectMake(self.extraView.frame.origin.x+self.extraView.frame.size.width-80, 10, self.extraView.frame.size.width-20, 30);
        [self.extraView addSubview:shareButton];
        
        NSString *jobdate = [[NSUserDefaults standardUserDefaults] valueForKey:@"dateLabel"];
        NSString *jobday = [[NSUserDefaults standardUserDefaults] valueForKey:@"dayLabel"];
        NSString *jobaddress1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"jobaddress1"];
        NSString *jobaddress2 = [[NSUserDefaults standardUserDefaults] valueForKey:@"jobaddress2"];
        NSString *jobcity = [[NSUserDefaults standardUserDefaults] valueForKey:@"jobcity"];
        NSString *jobpostcode = [[NSUserDefaults standardUserDefaults] valueForKey:@"jobpostcode"];
        jobid = [[NSUserDefaults standardUserDefaults] valueForKey:@"jobId"];
       
       
        
        NSString *jobstatus = [[NSUserDefaults standardUserDefaults] valueForKey:@"jobstatus"];
        
        if ([jobstatus isEqualToString:@"1"]) {
            [_registerButton setTitle:@"Applied" forState:UIControlStateNormal];
            _registerButton.userInteractionEnabled = NO;
            
            _registerButton.hidden = YES;
            _buttonCheckImage.hidden = NO;
            
            [_buttonCheckImage setImage:[UIImage imageNamed:@"buttoncheck"]];
        }
        else
        {
            [_registerButton setTitle:@"Apply" forState:UIControlStateNormal];
            _registerButton.userInteractionEnabled = YES;
            _buttonCheckImage.hidden = YES;
        }
        
        _nameLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"jobName"];
        _dateTimeLabel.text = [NSString stringWithFormat:@"%@  %@", jobdate,jobday];
        _locationLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"jobcity"];
        
        _contactNameLabel.text =[[NSUserDefaults standardUserDefaults] valueForKey:@"jobperson"];
        _contactPhoneLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"jobcontact"];
        
        _descriptionTextView.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"jobdisc"];
        
        
        
        _addressLabel.text = [NSString stringWithFormat:@"%@  %@  %@  %@",jobaddress1,jobaddress2,jobcity,jobpostcode];
    }
    
    
    
    // [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    //[self pageControlInitialisation];
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
    
    self.navigationItem.title = @"Choosen Care Group";
    
}
-(void)HomeView
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)pageControlInitialisation
{
    // Scroll View
    imagesScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Device_Width, IMAGE_HEIGHT)];
    imagesScrollView.backgroundColor=[UIColor clearColor];
    imagesScrollView.delegate=self;
    imagesScrollView.pagingEnabled=YES;
    imagesScrollView.showsHorizontalScrollIndicator = NO;
    [imagesScrollView setContentSize:CGSizeMake(imagesScrollView.frame.size.width*imagesArray.count, imagesScrollView.frame.size.height)];
    imagesScrollView.showsVerticalScrollIndicator = NO;
    // page control
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((Device_Width/2.5), IMAGE_HEIGHT - (PAGE_CONTROL_HEIGHT + 5), PAGE_CONTROL_WIDTH, PAGE_CONTROL_HEIGHT)];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.tintColor = [UIColor darkGrayColor];
    pageControl.numberOfPages = imagesArray.count;
    [pageControl addTarget:self action:@selector(pageChanged) forControlEvents:UIControlEventValueChanged];
    // images added to scrollview
    CGFloat x=0;
    for(int i=0;i<imagesArray.count;i++)
    {
        //  image = [[UIImageView alloc] initWithFrame:CGRectMake(x+0, 0, Device_Width, IMAGE_HEIGHT)];
        
        image = [[UIImageView alloc] initWithFrame:CGRectMake(x+0, 0, self.photoView.frame.size.width, self.photoView.frame.size.height)];
        //   UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x+0, 0, self.photoView.frame.size.width, self.photoView.frame.size.height)];
        
        //        if ([GDCUtilities1 isNetworkAvailable] == false)
        //        {
        //            [[GDCUtilities1 sharedInstance]showMessage:@"Please check your internet Connection" withTitle:@"No Internet"];
        //            return;
        //        }
        //        NSString *imageUrl = [NSString stringWithFormat:@"http://mobileappdevelopmentsolutions.com/wholster/%@",[BannersArray objectAtIndex:i]];
        //        [image setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]]];
        
        //   imgArr = [NSMutableArray new];
        
        NSString *imageStr = [imagesArray objectAtIndex:i];
        [image setImage:[UIImage imageNamed: imageStr]];
        
        //   UIImage *btnImage = [UIImage imageNamed:imageStr];
        //  [button setImage:btnImage forState:UIControlStateNormal];
        
        //  if (imagesArray.count == 0) {
        //      [image setImage:[UIImage imageNamed: @"camera.png"]];
        // }
        // else{
        //  [image setImage:[imagesArray objectAtIndex:i]];
        //  }
        [imagesScrollView addSubview:image];
        x+=Device_Width;
    }
    [self.photoView addSubview:imagesScrollView];
    [self.photoView addSubview:pageControl];
}
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    CGFloat pageWidth = imagesScrollView.frame.size.width;
    float fractionalPage = imagesScrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    pageControl.currentPage = page;
}
// page control action method
- (void)pageChanged {
    long int pageNumber = pageControl.currentPage;
    CGRect frame = imagesScrollView.frame;
    frame.origin.x = frame.size.width*pageNumber;
    frame.origin.y = 0;
    [imagesScrollView scrollRectToVisible:frame animated:YES];
}

-(void)getJob
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        NSString *urlStr = [NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/Events/GetJobbyUserID?UserID=%@&Job_ID=%@",userid,jobModuleID];
        
        [apiRequest SendHttpGetwithUrl:urlStr withrequestType:RequestTypeGetJobsById];
    });
}

-(void)servicecall
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        NSString *strURL=[NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/User/ModuleRegister?EventID=%@&UserID=%@&Module_Type=%@",jobid,userid,moduleType];
        
        NSDictionary *trainningData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       jobid,@"EventID",
                                       userid,@"UserID",
                                       moduleType,@"Module_Type",
                                       nil];
        
        [apiRequest SendHttpPost:trainningData withUrl:strURL withrequestType:RequestTypeRegisterJob];
        
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
            
            
            if(requestType ==RequestTypeRegisterJob)
            {
                NSLog(@"%@",responseObject);
                //    NSDictionary *responseDict = [responseObject valueForKey:@"OMsg"];
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                    

                    _registerButton.hidden = YES;
                    _buttonCheckImage.hidden = NO;
                    [_buttonCheckImage setImage:[UIImage imageNamed:@"buttoncheck"]];
                    
                    alert=[UIAlertController
                           
                           alertControllerWithTitle:@"CCG" message:@"Successfully Applied" preferredStyle:UIAlertControllerStyleAlert];
                    
                     yesButton = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [GlobalVariables appVars].JobRegister = @"JobRegister";
                                     
                                    [self.navigationController popViewControllerAnimated:NO];
                                     
                                 }];
                  
                    
                    
                    [alert addAction:yesButton];
                  
                    [self presentViewController:alert animated:YES completion:nil];
    
                }
                else if([respCode isEqualToString:@"401"])
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
            else  if(requestType == RequestTypeGetJobsById)
            {
                NSLog(@"%@",responseObject);
                NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                
                
                
                //    NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseDict valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                    
                  
                    
                    
                    
                    NSString *eventdisc = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Job_Description"]];
                    //    _descriptionTextView.text = [eventArray valueForKey:@"Event_Description"];
                    
                    _nameLabel.text = [responseObject valueForKey:@"Job_Title"];
                    _locationLabel.text = [responseObject valueForKey:@"Job_City"];
                    _contactNameLabel.text = [responseObject valueForKey:@"Job_ContactPersonname"];
                    _contactPhoneLabel.text = [responseObject valueForKey:@"Job_ContactPersonnumber"];
                    _descriptionTextView.text = eventdisc;
                    
                    NSString *eventday = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Job_Day"]];
                    NSString *eventdate = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Job_EndDate_Format"]];
                    
                    NSString *eventaddress1 = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Job_Address1"]];
                    NSString *eventaddress2 = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Job_Address2"]];
                    NSString *eventcity = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Job_City"]];
                    NSString *eventpostcode = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Job_Postcode"]];
                    
                    _dateTimeLabel.text = [NSString stringWithFormat:@"%@  %@", eventdate,eventday];
                    
                    _addressLabel.text = [NSString stringWithFormat:@"%@  %@  %@  %@",eventaddress1,eventaddress2,eventcity,eventpostcode];
                    
                    NSString *eventImage = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Job_Image"]];
                    
                    [self.jobImageView sd_setImageWithURL:[NSURL URLWithString:eventImage] placeholderImage:[UIImage imageNamed:@"nullimage.png"]];
                    
                    NSString *eventstatus = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Register_Status"]];
                    
                    if ([eventstatus isEqualToString:@"1"]) {
                        [_registerButton setTitle:@"Registered" forState:UIControlStateNormal];
                        _registerButton.userInteractionEnabled = NO;
                        
                        _registerButton.hidden = YES;
                        _buttonCheckImage.hidden = NO;
                        
                        [_buttonCheckImage setImage:[UIImage imageNamed:@"buttoncheck"]];
                    }
                    else
                    {
                        [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
                        _registerButton.userInteractionEnabled = YES;
                        _buttonCheckImage.hidden = YES;
                    }
                    
                    
                    
                }
                
                else
                {
                    alertMsg= [responseObject valueForKey:@"Message"];
                    [self showAlertWith:alertMsg];
                }
                
            }
            
            
            
            else{
                
                alertMsg= [NSMutableString stringWithFormat:@"Server not responding Try After Some Time"];
                [self showAlertWith:alertMsg];
                
            }
            
        }
    });
    
}

-(void)showAlertWith:(NSString *)alertString{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"CCG"  message:alertString preferredStyle:UIAlertControllerStyleAlert];
    //  UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action){}];
    
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

- (IBAction)registerClick:(id)sender {
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", @"Register", nil]];
    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    if (buttonIndex == 0) {
        NSLog(@"vamsi");
    }
    if (buttonIndex == 1) {
        [self servicecall];
    }
    
    
    [alertView close];
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    
    
    
//    demoView.layer.cornerRadius = 36.0;
//    demoView.layer.borderColor=[UIColor whiteColor].CGColor;
//    demoView.layer.borderWidth=1.0f;
//
//
//    demoView.layer.shadowColor = [UIColor blackColor].CGColor;
//    demoView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
//    demoView.layer.shadowOpacity = 0.9f;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, 140)];
  //  [imageView setImage:[UIImage imageNamed:@"Sample"]];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.urlStringjobImage] placeholderImage:[UIImage imageNamed:@"NoImage"]];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 270, 20)];
    label.textColor = [UIColor darkGrayColor];
    // [label setFrame:position];
    label.backgroundColor=[UIColor clearColor];
    // label.textColor=[UIColor darkGrayColor];
    [label setLineBreakMode:NSLineBreakByCharWrapping];
    [label setTextAlignment:NSTextAlignmentCenter];
    
    [label setNumberOfLines:2];
    label.userInteractionEnabled=NO;
    label.text= @"Are You sure want to Apply?";
    
    
    [demoView addSubview:label];
    
    [demoView addSubview:imageView];
    
    return demoView;
}
- (IBAction)phoneClick:(id)sender {
    
   //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_contactPhoneLabel.text]];
    
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:_contactPhoneLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
}
@end
