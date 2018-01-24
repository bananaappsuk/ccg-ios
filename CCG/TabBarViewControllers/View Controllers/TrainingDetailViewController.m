//
//  TrainingDetailViewController.m
//  CCG
//
//  Created by sriram angajala on 05/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "TrainingDetailViewController.h"
#import "TrainingViewController.h"
#import "CustomIOSAlertView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ApiClass.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "GlobalVariables.h"
#import "TGRImageViewController.h"
#import "TGRImageZoomAnimationController.h"
#define Device_Width [[UIScreen mainScreen] bounds].size.width
#define Device_Height [[UIScreen mainScreen] bounds].size.height
#define IMAGE_HEIGHT 160
#define NO_Of_Pages 5
#define PAGE_CONTROL_WIDTH 120
#define PAGE_CONTROL_HEIGHT 25
@interface TrainingDetailViewController ()<CustomIOSAlertViewDelegate,apiRequestProtocol,UIViewControllerTransitioningDelegate>

@end

@implementation TrainingDetailViewController
{
    NSMutableArray *imagesArray;
    NSMutableArray *imgArr;
    UIImageView *image;
    NSString *traingid;
    NSString *userid;
    NSString *moduleType;
    NSString *alertMsg, *buttonStr;
    NSString *trainingModuleID;
    UIAlertController * alert;
    UIAlertAction* yesButton;
    UIAlertAction* noButton;
    UIButton *checkButton,*tcButton;
     UIAlertView *statusAlert;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    imagesArray = [NSMutableArray new];
    
   // imagesArray = [NSMutableArray arrayWithObjects:@"sample1",@"sample2",@"Sample",@"Sample",@"Sample", nil];
    
    userid = [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
    moduleType = @"3";
    
   
    self.trainingImageView.contentMode = UIViewContentModeScaleAspectFill;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    if ([moduleType isEqualToString:_homestr]) {
          _registerButton.hidden = YES;
        trainingModuleID = [[NSUserDefaults standardUserDefaults] valueForKey:@"trainingModuleId"];
        
        [self getTraining];
    }
    else
    {
          _registerButton.hidden = NO;
        imagesArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"trainingimageArr"];
        [self.trainingImageView sd_setImageWithURL:[NSURL URLWithString:self.urlStringtrainingImage] placeholderImage:[UIImage imageNamed:@"NoImage"]];
        _registerButton.layer.cornerRadius = 22.0;
        _registerButton.layer.borderColor=[UIColor whiteColor].CGColor;
        _registerButton.layer.borderWidth=1.0f;
        
        NSString *traingdate = [[NSUserDefaults standardUserDefaults] valueForKey:@"traningdateLabel"];
        NSString *traingday = [[NSUserDefaults standardUserDefaults] valueForKey:@"traningdayLabel"];
        NSString *traingaddress1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"traningaddress1"];
        NSString *traingaddress2 = [[NSUserDefaults standardUserDefaults] valueForKey:@"traningaddress2"];
        NSString *traingcity = [[NSUserDefaults standardUserDefaults] valueForKey:@"traningcity"];
        NSString *traingpostcode = [[NSUserDefaults standardUserDefaults] valueForKey:@"traningpostcode"];
        
        traingid = [[NSUserDefaults standardUserDefaults] valueForKey:@"trainingId"];
       
        NSString *trainingstatus = [[NSUserDefaults standardUserDefaults] valueForKey:@"trainingStatus"];
        
        if ([trainingstatus isEqualToString:@"1"]) {
            [_registerButton setTitle:@"Un Register" forState:UIControlStateNormal];
            
            buttonStr = @"0";
          //  _registerButton.userInteractionEnabled = NO;
            
          //  _registerButton.hidden = YES;
          //  _checkimage.hidden = NO;
            
         //   [_checkimage setImage:[UIImage imageNamed:@"buttoncheck"]];
        }
        else
        {
            [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
          //  _registerButton.userInteractionEnabled = YES;
          //  _checkimage.hidden = YES;
            
        }
        
        _nameLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"traningName"];
        _daytimeLabel.text = [NSString stringWithFormat:@"%@  %@", traingdate,traingday];
        _locationLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"traningcity"];
        
        _contactNameLabel.text =[[NSUserDefaults standardUserDefaults] valueForKey:@"traningperson"];
        _contactPhoneLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"traningcontact"];
        
        _discriptionTextView.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"traningdisc"];
        
        
        
        _addressLabel.text = [NSString stringWithFormat:@"%@  %@  %@  %@",traingaddress1,traingaddress2,traingcity,traingpostcode];
        
    }
    
    
    // [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    [self pageControlInitialisation];
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
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if ([presented isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.trainingImageView];
    }
    return nil;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.trainingImageView];
    }
    return nil;
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
        
        [image setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]]]];
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getTraining
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        NSString *urlStr = [NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/Events/GetTraningbyUserID?UserID=%@&Traning_ID=%@",userid,trainingModuleID];
        
        [apiRequest SendHttpGetwithUrl:urlStr withrequestType:RequestTypeGetTrainingById];
    });
}

-(void)servicecall
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        NSString *strURL=[NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/User/ModuleRegister?EventID=%@&UserID=%@&Module_Type=%@",traingid,userid,moduleType];
        
        NSDictionary *trainningData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   traingid,@"EventID",
                                   userid,@"UserID",
                                   moduleType,@"Module_Type",
                                   nil];
        
        [apiRequest SendHttpPost:trainningData withUrl:strURL withrequestType:RequestTypeRegisterTraining];
        
    });
}
-(void)unregisterservicecall
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        NSString *strURL=[NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/User/Unregistred?UserID=%@&ModuleID=%@",userid,traingid];
        
        NSDictionary *trainningData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       traingid,@"ModuleID",
                                       userid,@"UserID",
                                       moduleType,@"Module_Type",
                                       nil];
        
        [apiRequest SendHttpPost:trainningData withUrl:strURL withrequestType:RequestTypeUnRegisterTraining];
        
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
            
            
            if(requestType ==RequestTypeRegisterTraining)
            {
                NSLog(@"%@",responseObject);
                //    NSDictionary *responseDict = [responseObject valueForKey:@"OMsg"];
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                    
                    
                [_registerButton setTitle:@"Un Register" forState:UIControlStateNormal];
                   
                 //   _registerButton.hidden = YES;
                //    _checkimage.hidden = YES;
                    
                //    [_checkimage setImage:[UIImage imageNamed:@"buttoncheck"]];
                    alert=[UIAlertController
                           
                           alertControllerWithTitle:@"CCG" message:@"Successfully Registerd" preferredStyle:UIAlertControllerStyleAlert];
                    
                    yesButton = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                     [GlobalVariables appVars].TrainingRegister = @"TrainingRegister";
                                     
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
            else  if(requestType == RequestTypeGetTrainingById)
            {
                NSLog(@"%@",responseObject);
                NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                
                
                
                //    NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseDict valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                    
                    NSString *eventdisc = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Traning_Description"]];
                    //    _descriptionTextView.text = [eventArray valueForKey:@"Event_Description"];
                    
                    _nameLabel.text = [responseObject valueForKey:@"Traning_Title"];
                    _locationLabel.text = [responseObject valueForKey:@"Traning_City"];
                    _contactNameLabel.text = [responseObject valueForKey:@"Traning_ContactPersonname"];
                    _contactPhoneLabel.text = [responseObject valueForKey:@"Traning_ContactPersonnumber"];
                    _discriptionTextView.text = eventdisc;
                    
                    NSString *eventday = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Traning_Day"]];
                    NSString *eventdate = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Traning_StartDate_Format"]];
                    
                    NSString *eventaddress1 = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Traning_Address1"]];
                    NSString *eventaddress2 = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Traning_Address2"]];
                    NSString *eventcity = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Traning_City"]];
                    NSString *eventpostcode = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Traning_Postcode"]];
                    
                    _daytimeLabel.text = [NSString stringWithFormat:@"%@  %@", eventdate,eventday];
                    
                    _addressLabel.text = [NSString stringWithFormat:@"%@  %@  %@  %@",eventaddress1,eventaddress2,eventcity,eventpostcode];
                    
                    NSString *eventstatus = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Register_Status"]];
                    
                    NSString *eventImage = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Traning_Image"]];
                    
                    [self.trainingImageView sd_setImageWithURL:[NSURL URLWithString:eventImage] placeholderImage:[UIImage imageNamed:@"nullimage.png"]];
                    
                    if ([eventstatus isEqualToString:@"1"]) {
                        [_registerButton setTitle:@"Un Register" forState:UIControlStateNormal];
                     //   _registerButton.userInteractionEnabled = NO;
                     //   _registerButton.hidden = YES;
                    //    _checkimage.hidden = NO;
                    //    [_checkimage setImage:[UIImage imageNamed:@"buttoncheck"]];
                    }
                    else
                    {
                        [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
                   //     _registerButton.userInteractionEnabled = YES;
                    //    _checkimage.hidden = YES;
                    }
                    
                }
                    
                }
                else  if(requestType == RequestTypeUnRegisterTraining)
                {
                    NSLog(@"%@",responseObject);
                 //   NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                    
                    
                    
                    //    NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                    
                    NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                    if([respCode isEqualToString:@"200"])
                    {
                     
                        [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
                        
                        //   _registerButton.hidden = YES;
                        //    _checkimage.hidden = YES;
                        
                        //    [_checkimage setImage:[UIImage imageNamed:@"buttoncheck"]];
                        alert=[UIAlertController
                               
                               alertControllerWithTitle:@"CCG" message:@"Successfully Un Registerd" preferredStyle:UIAlertControllerStyleAlert];
                        
                        yesButton = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         
                                         [GlobalVariables appVars].TrainingRegister = @"TrainingRegister";
                                         
                                         [self.navigationController popViewControllerAnimated:NO];
                                         
                                     }];
                        
                        
                        
                        [alert addAction:yesButton];
                        
                        [self presentViewController:alert animated:YES completion:nil];
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

-(void)showAlertWith:(NSString *)alertString{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"CCG"  message:alertString preferredStyle:UIAlertControllerStyleAlert];
    //  UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action){}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    alertMsg= [NSMutableString stringWithFormat:@""];
    
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
    
    if([buttonStr isEqualToString:@"0"])
    {
        [self unregisterservicecall];
    }
    else
    {
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

}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    if (buttonIndex == 0) {
        NSLog(@"vamsi");
        [alertView close];
    }
    if (buttonIndex == 1) {
        checkButton.selected  = ! checkButton.selected;
         if ( [[checkButton imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"UnCheckMark"]])
        {
            alertMsg= [NSMutableString stringWithFormat:@"Please Agree Terms and Conditions"];
            [self showAlertWith:alertMsg];
        }
        else
        {
              [self servicecall];
            
        }
        [alertView close];
      
    }
    
    
    
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 240)];
    
    [demoView setBackgroundColor:[UIColor lightGrayColor]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, 140)];
  //  [imageView setImage:[UIImage imageNamed:@"Sample"]];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.urlStringtrainingImage] placeholderImage:[UIImage imageNamed:@"NoImage"]];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 270, 20)];
    label.textColor = [UIColor darkGrayColor];
    // [label setFrame:position];
    label.backgroundColor=[UIColor clearColor];
    // label.textColor=[UIColor darkGrayColor];
    [label setLineBreakMode:NSLineBreakByCharWrapping];
    [label setTextAlignment:NSTextAlignmentCenter];
    
    [label setNumberOfLines:2];
    label.userInteractionEnabled=NO;
    label.text= @"Are You sure want to Register?";
    
    
    checkButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 190, 30, 30)];
    
    [checkButton setImage:[UIImage imageNamed:@"UnCheckMark"] forState:UIControlStateNormal];
    
    [checkButton addTarget:self
               action:@selector(check)
          forControlEvents:UIControlEventTouchUpInside];
    
    tcButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 190, 150, 30)];
    
    [tcButton setTitle:@"Agree T&C" forState:UIControlStateNormal];
    
    [tcButton setTintColor:[UIColor blackColor]];
    
    [tcButton addTarget:self
                    action:@selector(TermsandConditions)
          forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(80, 221, 90, 1)];
    [label1 setBackgroundColor:[UIColor blueColor]];
    [demoView addSubview:label1];
    [demoView addSubview:checkButton];
    [demoView addSubview:tcButton];
   
    [demoView addSubview:label];
    
    [demoView addSubview:imageView];
    
    return demoView;
}
-(void)check
{
    if( [[checkButton imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"UnCheckMark"]])
    {
        [checkButton setImage:[UIImage imageNamed:@"CheckMark"] forState:UIControlStateNormal];
    }
    else
    {
        [checkButton setImage:[UIImage imageNamed:@"UnCheckMark"] forState:UIControlStateNormal];
    }
}

-(void)TermsandConditions
{
    
    statusAlert = [[UIAlertView alloc] initWithTitle:@"Training Terms & Conditions"
                                             message:@" Application Form Staff should discuss their development needs and attendance on a course with their line manager.If staff do not have an email address, they should enter their line manager’s email address. Allocation of places Once the individual has been booked on a course a confirmation will be available in my booking section If the course is full, there will be a notification of an alternative date(s) if applicable. Where appropriate, a waiting list of staffs will be maintained. Course attendance Staff are required to attend the full course / Training Staff should not apply for a place on a course if they are unable to attend the full course. Staff should arrive at least 10-15 minutes before the course start time. It is not acceptable to arrive late or leave early. The Training team will report any instances of this to their line manager.It is the responsibility of the individual to ensure that their line manager has given consent for them to attend the full course. Staff should not apply for courses which are for two days or more if they are unable to commit to the days. Late arrivals (without prior notification to the Training team) will not be allowed to join the course and a non-attendance charge will be made. Staff will be required to sign an attendance register when they arrive. To receive Continuous Professional Development (CPD) certificates attendees must ensure they have completed a course evaluation form Course non-attendance Staff are required to contact the Chosen Care Team by phone or sending an email to sangita@chosencaregroup.com,  if they are unable to attend training. Staff are also required to advise their line manager of their non-attendance. *  Non-attendance without prior notification / cancellation - £25  *  Non-attendance because of late arrival - £10  * Places cancelled due to sickness absence that occurs on the day of the course or the day before but has been reported to the Team (via email) on the day of the course or the day before - No charge * Cancellation made less than two working days before the course (and where the place cannot be reallocated) - £20  * Cancellations made more than two working days in advance - No charge Where a member of staff is absent from work through sickness, it is the line managers responsibility to check whether that individual is likely to miss a forthcoming course and advise the Training Team accordingly by email."
                                            delegate:self
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
    
    [statusAlert show];
    
    
//    PopAlertView *cv = [GlobalVariables popupAlert];
//
//    cv.popupTextView.text = @"Application Form Staff should discuss their development needs and attendance on a course with their line manager.If staff do not have an email address, they should enter their line manager’s email address. Allocation of places Once the individual has been booked on a course a confirmation will be available in my booking section If the course is full, there will be a notification of an alternative date(s) if applicable. Where appropriate, a waiting list of staffs will be maintained. Course attendance Staff are required to attend the full course / Training Staff should not apply for a place on a course if they are unable to attend the full course. Staff should arrive at least 10-15 minutes before the course start time. It is not acceptable to arrive late or leave early. The Training team will report any instances of this to their line manager.It is the responsibility of the individual to ensure that their line manager has given consent for them to attend the full course. Staff should not apply for courses which are for two days or more if they are unable to commit to the days. Late arrivals (without prior notification to the Training team) will not be allowed to join the course and a non-attendance charge will be made. Staff will be required to sign an attendance register when they arrive. To receive Continuous Professional Development (CPD) certificates attendees must ensure they have completed a course evaluation form Course non-attendance Staff are required to contact the Chosen Care Team by phone or sending an email to sangita@chosencaregroup.com,  if they are unable to attend training. Staff are also required to advise their line manager of their non-attendance. *  Non-attendance without prior notification / cancellation - £25  *  Non-attendance because of late arrival - £10  * Places cancelled due to sickness absence that occurs on the day of the course or the day before but has been reported to the Team (via email) on the day of the course or the day before - No charge * Cancellation made less than two working days before the course (and where the place cannot be reallocated) - £20  * Cancellations made more than two working days in advance - No charge Where a member of staff is absent from work through sickness, it is the line managers responsibility to check whether that individual is likely to miss a forthcoming course and advise the Training Team accordingly by email.";
//
//    [self.view addSubview:cv];
}


- (IBAction)phoneClick:(id)sender {
   // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_contactPhoneLabel.text]];
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:_contactPhoneLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
- (IBAction)imagePopClick:(id)sender {
    
    TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:self.trainingImageView.image];
    // Don't forget to set ourselves as the transition delegate
    viewController.transitioningDelegate = self;
    
    [self presentViewController:viewController animated:YES completion:nil];
}
@end
