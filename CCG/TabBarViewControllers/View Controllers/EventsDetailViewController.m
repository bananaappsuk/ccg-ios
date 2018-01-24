//
//  EventsDetailViewController.m
//  CCG
//
//  Created by sriram angajala on 04/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "EventsDetailViewController.h"
#import "EventsViewController.h"
#import "CustomIOSAlertView.h"
#import "GlobalVariables.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ApiClass.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "TGRImageViewController.h"
#import "TGRImageZoomAnimationController.h"
#define Device_Width [[UIScreen mainScreen] bounds].size.width
#define Device_Height [[UIScreen mainScreen] bounds].size.height

#define IMAGE_HEIGHT 160
#define NO_Of_Pages 5
#define PAGE_CONTROL_WIDTH 120
#define PAGE_CONTROL_HEIGHT 25
@interface EventsDetailViewController ()<CustomIOSAlertViewDelegate,apiRequestProtocol,UIViewControllerTransitioningDelegate>

@end

@implementation EventsDetailViewController
{
    NSMutableArray *imagesArray;
     NSMutableArray *imgArr;
     UIImageView *image;
    NSMutableDictionary *imageDic;
    NSString *eventid;
    NSString *userid;
    NSString *moduleType;
    NSString *alertMsg, *buttonStr;
    NSString *eventModuleID;
    UIAlertController * alert;
    UIAlertAction* yesButton;
    UIAlertAction* noButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //   [self pageControlInitialisation];
    imagesArray = [NSMutableArray new];
  
 //  imageDic = [GlobalVariables appVars].checkOutItems;
 //   imgArr = [imageDic valueForKey:@"Event_Photo"];
    
//    for (int i=0; i<[GlobalVariables appVars].checkOutItems.count; i++) {
//       // NSString *attri =[enumKeyReferenceArray valueForKey:@"BeltCondition"];
//        imageDic = [[GlobalVariables appVars].checkOutItems valueForKey:@"Event_Photo"];
//    }
//
//    [imagesArray addObject:imageDic];
    userid = [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
    moduleType = @"1";
    
    
//        imagesArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventimageArr"];
//
//
//
//        [self.eventImageView sd_setImageWithURL:[NSURL URLWithString:self.urlStringeventImage] placeholderImage:[UIImage imageNamed:@"nullimage.png"]];
//
//        _registerButton.layer.cornerRadius = 20.0;
//        _registerButton.layer.borderColor=[UIColor whiteColor].CGColor;
//        _registerButton.layer.borderWidth=1.0f;
//
//        NSString *eventdate = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventDate"];
//        NSString *eventday = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventDay"];
//        NSString *eventaddress1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventaddress1"];
//        NSString *eventaddress2 = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventaddress2"];
//        NSString *eventcity = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventcity"];
//        NSString *eventpostcode = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventpostcode"];
//        eventid = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventId"];
//
//
//        NSString *eventstatus = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventstatus"];
//
//        if ([eventstatus isEqualToString:@"1"]) {
//            [_registerButton setTitle:@"Registered" forState:UIControlStateNormal];
//            _registerButton.userInteractionEnabled = NO;
//
//            _registerButton.hidden = YES;
//            _buttonCheckimage.hidden = NO;
//
//            [_buttonCheckimage setImage:[UIImage imageNamed:@"buttoncheck"]];
//        }
//        else
//        {
//            [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
//            _registerButton.userInteractionEnabled = YES;
//            _buttonCheckimage.hidden = YES;
//        }
//
//
//        _eventNameLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"EventName"];
//        _eventdateLabel.text = [NSString stringWithFormat:@"%@  %@", eventdate,eventday];
//        _locationLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventcity"];
//
//        _contactPersonLabel.text =[[NSUserDefaults standardUserDefaults] valueForKey:@"eventperson"];
//        _contactNumberLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventcontact"];
//
//        _descriptionTextView.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventdisc"];
//
//        _eventImageView.image = [[NSUserDefaults standardUserDefaults]valueForKey:@"eventimage"];
//
//        _addressLabel.text = [NSString stringWithFormat:@"%@  %@  %@  %@",eventaddress1,eventaddress2,eventcity,eventpostcode];
//

    
   _buttonCheckimage.hidden = YES;
    
    self.eventImageView.contentMode = UIViewContentModeScaleAspectFill;
   
}
-(void)viewWillAppear:(BOOL)animated
{
    
    
    if ([moduleType isEqualToString:_HomeStr]) {
        
        _registerButton.hidden = YES;
         eventModuleID = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventModuleId"];
       
        [self getEvent];
        
    }
    else
    {
        _registerButton.hidden = NO;
        
        imagesArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventimageArr"];

      //  if ([_urlStringeventImage isEqualToString:@""]) {
      //      [_eventImageView setImage:[UIImage imageNamed:@"Sample"]];
      //  }
     //   else
      //  {
            [self.eventImageView sd_setImageWithURL:[NSURL URLWithString:self.urlStringeventImage] placeholderImage:[UIImage imageNamed:@"NoImage"]];
     //   }

//        UIImage *newImage = [UIImage imageNamed:_urlStringeventImage];
//        [_imagePopButton setImage:newImage forState:UIControlStateHighlighted];
//
      
        
        
        
        
        

        _registerButton.layer.cornerRadius = 20.0;
        _registerButton.layer.borderColor=[UIColor whiteColor].CGColor;
        _registerButton.layer.borderWidth=1.0f;

        NSString *eventdate = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventDate"];
        NSString *eventday = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventDay"];
        NSString *eventaddress1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventaddress1"];
        NSString *eventaddress2 = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventaddress2"];
        NSString *eventcity = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventcity"];
        NSString *eventpostcode = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventpostcode"];
        eventid = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventId"];


        NSString *eventstatus = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventstatus"];

        if ([eventstatus isEqualToString:@"1"]) {
            [_registerButton setTitle:@"Un Register" forState:UIControlStateNormal];
            
            buttonStr = @"0";
          //  _registerButton.userInteractionEnabled = NO;

         //   _registerButton.hidden = YES;
         //   _buttonCheckimage.hidden = NO;

        //    [_buttonCheckimage setImage:[UIImage imageNamed:@"buttoncheck"]];
        }
        else
        {
            [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
           // _registerButton.userInteractionEnabled = YES;
           // _buttonCheckimage.hidden = YES;
        }


        _eventNameLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"EventName"];
        _eventdateLabel.text = [NSString stringWithFormat:@"%@  %@", eventdate,eventday];
        _locationLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventcity"];

        _contactPersonLabel.text =[[NSUserDefaults standardUserDefaults] valueForKey:@"eventperson"];
        _contactNumberLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventcontact"];

        _descriptionTextView.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"eventdisc"];

        _eventImageView.image = [[NSUserDefaults standardUserDefaults]valueForKey:@"eventimage"];

        _addressLabel.text = [NSString stringWithFormat:@"%@  %@  %@  %@",eventaddress1,eventaddress2,eventcity,eventpostcode];
    }

   
    // [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
     [self.eventImageView sd_setImageWithURL:[NSURL URLWithString:self.urlStringeventImage] placeholderImage:[UIImage imageNamed:@"nullimage.png"]];
    
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
//
    
    self.navigationItem.title = @"Choosen Care Group";
}



- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if ([presented isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.eventImageView];
    }
    return nil;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.eventImageView];
    }
    return nil;
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
        
    [image setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]]]];
      //   [image setImage:[UIImage imageNamed: imageStr]];
    
     //   UIImage *btnImage = [UIImage imageNamed:imageStr];
      //  [button setImage:btnImage forState:UIControlStateNormal];
    
        
    //   NSString *attri =[imagesArray[i] valueForKey:@"Event_Photo"];
    //    [image setImage:[UIImage imageNamed: attri]];
        
//          if (imagesArray.count == 0) {
//              [image setImage:[UIImage imageNamed: @"camera.png"]];
//         }
//         else{
//        [image setImage:[imagesArray objectAtIndex:i]];
//          }
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
-(void)getEvent
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        NSString *urlStr = [NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/Events/GetEventbyUserID?UserID=%@&Event_ID=%@",userid,eventModuleID];
        
        [apiRequest SendHttpGetwithUrl:urlStr withrequestType:RequestTypeGetEventsById];
    });
}


-(void)servicecall
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        NSString *strURL=[NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/User/ModuleRegister?EventID=%@&UserID=%@&Module_Type=%@",eventid,userid,moduleType];
        
        NSDictionary *trainningData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       eventid,@"EventID",
                                       userid,@"UserID",
                                       moduleType,@"Module_Type",
                                       nil];
        
        [apiRequest SendHttpPost:trainningData withUrl:strURL withrequestType:RequestTypeRegisterEvent];
        
    });
}
-(void)unregisterservicecall
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        NSString *strURL=[NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/User/Unregistred?UserID=%@&ModuleID=%@",userid,eventid];
        
        NSDictionary *trainningData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       eventid,@"ModuleID",
                                       userid,@"UserID",
                                        nil];
        
        [apiRequest SendHttpPost:trainningData withUrl:strURL withrequestType:RequestTypeUnRegisterEvent];
        
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
            
            
            if(requestType ==RequestTypeRegisterEvent)
            {
                NSLog(@"%@",responseObject);
                //    NSDictionary *responseDict = [responseObject valueForKey:@"OMsg"];
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                    
                    
                   [_registerButton setTitle:@"Un Register" forState:UIControlStateNormal];
                   // _registerButton.hidden = YES;
                   // _buttonCheckimage.hidden = NO;
                    
                  //  [_buttonCheckimage setImage:[UIImage imageNamed:@"buttoncheck"]];
                    alert=[UIAlertController
                           
                           alertControllerWithTitle:@"CCG" message:@"Successfully Registerd" preferredStyle:UIAlertControllerStyleAlert];
                    
                    yesButton = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                    [GlobalVariables appVars].EventRegister = @"RegisterEvent";
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
            
          else if(requestType == RequestTypeGetEventsById)
            {
                    NSLog(@"%@",responseObject);
                    NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                
                
            
                    //    NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseDict valueForKey:@"StatusCode"]];
                    if([respCode isEqualToString:@"200"])
                    {
                        
                       

                        NSString *eventdisc = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Event_Description"]];
                    //    _descriptionTextView.text = [eventArray valueForKey:@"Event_Description"];

                        _eventNameLabel.text = [responseObject valueForKey:@"Event_Title"];
                        _locationLabel.text = [responseObject valueForKey:@"Event_City"];
                        _contactPersonLabel.text = [responseObject valueForKey:@"Event_ContactPersonname"];
                        _contactNumberLabel.text = [responseObject valueForKey:@"Event_ContactPersonnumber"];
                        _descriptionTextView.text = eventdisc;

                        NSString *eventday = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Event_Day"]];
                        NSString *eventdate = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Event_StartDate_Format"]];

                        NSString *eventaddress1 = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Event_Address1"]];
                        NSString *eventaddress2 = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Event_Address2"]];
                        NSString *eventcity = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Event_City"]];
                        NSString *eventpostcode = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Event_Postcode"]];

                        _eventdateLabel.text = [NSString stringWithFormat:@"%@  %@", eventdate,eventday];

                        _addressLabel.text = [NSString stringWithFormat:@"%@  %@  %@  %@",eventaddress1,eventaddress2,eventcity,eventpostcode];

                        NSString *eventstatus = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Register_Status"]];
                        NSString *eventImage = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"Event_Image"]];
                        
                        [self.eventImageView sd_setImageWithURL:[NSURL URLWithString:eventImage] placeholderImage:[UIImage imageNamed:@"nullimage.png"]];
                        
                      imagesArray = [NSMutableArray new];
                        
                        for (NSDictionary *itemDict in [responseObject valueForKey:@"Event_Photos"]) {
                            
                            [imagesArray addObject:[itemDict valueForKey:@"Event_Photo"]];
                            
                        }
                        
                        
                        if ([eventstatus isEqualToString:@"1"]) {
                            [_registerButton setTitle:@"Un Register" forState:UIControlStateNormal];
                        //    _registerButton.userInteractionEnabled = NO;

                         //   _registerButton.hidden = YES;
                         //   _buttonCheckimage.hidden = NO;

                          //  [_buttonCheckimage setImage:[UIImage imageNamed:@"buttoncheck"]];
                        }
                        else
                        {
                            [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
                          //  _registerButton.userInteractionEnabled = YES;
                          //  _buttonCheckimage.hidden = YES;
                        }
                        
                        
                        
                    }
                  
                    else
                    {
                        alertMsg= [responseObject valueForKey:@"Message"];
                        [self showAlertWith:alertMsg];
                    }
            
                }
          else  if(requestType == RequestTypeUnRegisterEvent)
          {
              NSLog(@"%@",responseObject);
              //   NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
              
              
              
              //    NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
              
              NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
              if([respCode isEqualToString:@"200"])
              {
                  
                  [_registerButton setTitle:@"Un Register" forState:UIControlStateNormal];
                  
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
                                   
                                   [GlobalVariables appVars].EventRegister = @"RegisterEvent";
                                   
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
    
    if ([buttonStr isEqualToString:@"0"]) {
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
    }
    if (buttonIndex == 1) {
        [self servicecall];
    }
    
    
    [alertView close];
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    
//    demoView.layer.cornerRadius = 20.0;
//    demoView.layer.borderColor=[UIColor whiteColor].CGColor;
//    demoView.layer.borderWidth=1.0f;
    
    
//    demoView.layer.shadowColor = [UIColor blackColor].CGColor;
//    demoView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
//    demoView.layer.shadowOpacity = 0.9f;
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, 140)];
  //  [imageView setImage:[UIImage imageNamed:@"Sample"]];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.urlStringeventImage] placeholderImage:[UIImage imageNamed:@"nullimage.png"]];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 270, 40)];
    label.textColor = [UIColor darkGrayColor];
   // [label setFrame:position];
    label.backgroundColor=[UIColor clearColor];
   // label.textColor=[UIColor darkGrayColor];
    [label setLineBreakMode:NSLineBreakByCharWrapping];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setNumberOfLines:2];
    label.userInteractionEnabled=NO;
    label.text= @"Are You Sure Register this Event?";
    
   
    [demoView addSubview:label];
    
    [demoView addSubview:imageView];
    
    return demoView;
}
- (IBAction)phoneClick:(id)sender {
  //  NSLog(@"calling ..");
  //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_contactNumberLabel.text]];
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:_contactNumberLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
- (IBAction)imagePopClick:(id)sender {
//
//    TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:[self.imagePopButton imageForState:UIControlStateNormal]];
//    viewController.transitioningDelegate = self;
//
//    [self presentViewController:viewController animated:YES completion:nil];
//
    TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:self.eventImageView.image];
    // Don't forget to set ourselves as the transition delegate
    viewController.transitioningDelegate = self;
    
    [self presentViewController:viewController animated:YES completion:nil];
}
@end
