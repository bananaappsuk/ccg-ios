//
//  EventsViewController.m
//  CCG
//
//  Created by sriram angajala on 04/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "EventsViewController.h"
#import "EventsTableViewCell.h"
#import "EventsDetailViewController.h"
#import "CalenderViewController.h"
#import "ApiClass.h"
#import "GlobalVariables.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface EventsViewController ()<apiRequestProtocol>

@end

@implementation EventsViewController
{
    NSMutableArray *imagesArray;
    NSMutableArray *DataArray;
    NSString *alertMsg;
    NSString *str1;
    UIRefreshControl *refreshControl;
    
    NSString *userId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _calenderButton.hidden = NO;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh1:) forControlEvents:UIControlEventValueChanged];
    [_eventsTableView addSubview:refreshControl];
    
    userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
    
    [self ServiceCall];
}
-(void)viewWillAppear:(BOOL)animated
{
   
    
    if ([[GlobalVariables appVars].EventRegister isEqualToString:@"RegisterEvent"]) {
         [self ServiceCall];
    }
    else
    {
        //
    }
    
    
    // [self.navigationController setNavigationBarHidden:YES animated:NO];
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
    
    self.navigationItem.title = @"Choosen Care Group";

}
-(void)HomeView
{
    
   
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (void)refresh1:(UIRefreshControl *)refreshControl
{
    
    [self ServiceCall];
    
    [refreshControl endRefreshing];
}

-(void)ServiceCall
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        NSString *urlStr = [NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/Events/GetEventsbyUserID?UserID=%@",userId];
        
        [apiRequest SendHttpGetwithUrl:urlStr withrequestType:RequestTypeGetEvents];
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
            
            if(requestType == RequestTypeGetEvents)
            {
                NSLog(@"%@",responseObject);
                NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                
                //    NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseDict valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                    [GlobalVariables appVars].EventRegister = @"";
                    
                    DataArray = [[NSMutableArray alloc]init];
                    DataArray = [responseObject valueForKey:@"EventList"];
                    
                    
//                    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Event_StartDate_Format" ascending:YES];
//                    [DataArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];

                    
                   
                    
                    NSString *eventstr = [DataArray valueForKey:@"Event_StartDate_Format"];
                    
                    [[NSUserDefaults standardUserDefaults]setValue:eventstr forKey:@"eventDates"];
                    [[NSUserDefaults standardUserDefaults]synchronize ];
                    
                    [_eventsTableView reloadData];
                    
                }
                else
                {
                    alertMsg= [responseDict valueForKey:@"Message"];
                    [self showAlertWith:alertMsg];
                    
                }
                
            }
            //            else if(requestType == RequestTypeDeleteAppointments)
            //            {
            //                NSLog(@"%@",responseObject);
            //                NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
            //
            //                //    NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
            //
            //
            //                NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
            //                if([respCode isEqualToString:@"200"])
            //                {
            //
            //                    alertMsg= [responseObject valueForKey:@"Message"];
            //                    [self showAlertWith:alertMsg];
            //
            //                    _popupView.hidden = YES;
            //
            //
            //                    [_appoinmentTableView reloadData];
            //
            //                }
            //                else if([respCode isEqualToString:@"406"])
            //                {
            //                    alertMsg= [responseObject valueForKey:@"Message"];
            //                    [self showAlertWith:alertMsg];
            //                    [_appoinmentTableView reloadData];
            //
            //                }
            //
            //                else
            //                {
            //                    alertMsg= [responseObject valueForKey:@"Message"];
            //                    [self showAlertWith:alertMsg];
            //
            //                }
            //
            //            }
            
            
            
            else{
                
                alertMsg= [NSMutableString stringWithFormat:@"Server Not Responding"];
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

#pragma mark - tableview delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    EventsTableViewCell *cell = (EventsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [_eventsTableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    }
  //  cell.selectionStyle = UITableViewCellSelectionStyleNone;
   // NSMutableDictionary *sampleDict = [dignosticsNamesArray objectAtIndex:indexPath.row];
    
  //  NSString *imageStr = [[NSString alloc]init];
  //  imageStr = [sampleDict valueForKey:@"centerimage"];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableDictionary *sampleDict = [DataArray objectAtIndex:indexPath.row];

    NSString *imageStr = [[NSString alloc]init];
    imageStr = [sampleDict valueForKey:@"Event_Image"];

    if([imageStr isEqualToString:@""] || imageStr == nil)
    {
        cell.eventsImageView.image = [UIImage imageNamed:@"NoImage"];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.eventsImageView.image = [UIImage imageWithData:imageData];
                if (cell.eventsImageView.image == nil) {
                    cell.eventsImageView.image = [UIImage imageNamed:@"NoImage"];
                }

            });
        });
    }

//    str1=[[DataArray valueForKey:@"Event_StartDate_Format"]objectAtIndex:indexPath.row];
//    NSArray *tempArray = [str1 componentsSeparatedByString:@"T"];
//    str1 = [tempArray objectAtIndex:0];

    NSString *status = [NSString stringWithFormat:@"%@",[[DataArray valueForKey:@"Register_Status"]objectAtIndex:indexPath.row]];
    
    if ([status isEqualToString:@"1"]) {
        cell.registerImage.hidden = NO;
    }
    else
    {
         cell.registerImage.hidden = YES;
    }


    cell.eventNameLabel.text = [[DataArray valueForKey:@"Event_Title"]objectAtIndex:indexPath.row];
    cell.eventDayLabel.text = [[DataArray valueForKey:@"Event_Day"]objectAtIndex:indexPath.row];

    cell.eventDateLabel.text = [[DataArray valueForKey:@"Event_StartDate_Format"]objectAtIndex:indexPath.row];;

    cell.eventCategoryLabel.text = [[DataArray valueForKey:@"Category_Name"]objectAtIndex:indexPath.row];

    cell.eventTimeLabel.text = [[DataArray valueForKey:@"Event_StartTime_Format"]objectAtIndex:indexPath.row];
    
    cell.eventPlaceLabel.text = [[DataArray valueForKey:@"Event_City"]objectAtIndex:indexPath.row];

 
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    EventsTableViewCell *cell = (EventsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.eventDayLabel.text =[[DataArray valueForKey:@"Event_Day"]objectAtIndex:indexPath.row];
 
    
    cell.eventDateLabel.text = [[DataArray valueForKey:@"Event_StartDate_Format"]objectAtIndex:indexPath.row];
   
    NSDictionary *Dict = [DataArray objectAtIndex:indexPath.row];
    
    NSMutableArray *sampleArr = [[DataArray valueForKey:@"Event_Photos"]objectAtIndex:indexPath.row];
    
  //  NSDictionary *sampleDict = [sampleArr objectAtIndex:indexPath.row];
    
    NSMutableArray *eventimageArr;
    eventimageArr = [NSMutableArray new];
    
    for (NSDictionary *itemDict in sampleArr) {
        
        [eventimageArr addObject:[itemDict valueForKey:@"Event_Photo"]];
        
    }
    
    NSString *eventdisc = [Dict valueForKey:@"Event_Description"];
    
    NSString *EventName = [Dict valueForKey:@"Event_Title"];
    
    NSString *eventperson = [Dict valueForKey:@"Event_ContactPersonname"];
    
    NSString *eventcontact = [Dict valueForKey:@"Event_ContactPersonnumber"];
    
    NSString *eventaddress1 = [Dict valueForKey:@"Event_Address1"];
    
    NSString *eventaddress2 = [Dict valueForKey:@"Event_Address2"];
    
    NSString *eventcity = [Dict valueForKey:@"Event_City"];
    
    NSString *eventpostcode = [Dict valueForKey:@"Event_Postcode"];
    NSString *eventId = [NSString stringWithFormat:@"%@",[Dict valueForKey:@"Event_Id"]];
    
    NSString *eventstatus = [NSString stringWithFormat:@"%@",[Dict valueForKey:@"Register_Status"]];
    
   // docIdStr = [Dict valueForKey:@"Doctor_Id"];
    [[NSUserDefaults standardUserDefaults]setValue:cell.eventDateLabel.text forKey:@"eventDate"];
    [[NSUserDefaults standardUserDefaults]setValue:cell.eventTimeLabel.text forKey:@"eventTime"];
     [[NSUserDefaults standardUserDefaults]setValue:cell.eventDayLabel.text forKey:@"eventDay"];

    [[NSUserDefaults standardUserDefaults]setValue:eventdisc forKey:@"eventdisc"];
    [[NSUserDefaults standardUserDefaults]setValue:EventName forKey:@"EventName"];
    [[NSUserDefaults standardUserDefaults]setValue:eventperson forKey:@"eventperson"];
    [[NSUserDefaults standardUserDefaults]setValue:eventcontact forKey:@"eventcontact"];
    
    [[NSUserDefaults standardUserDefaults]setValue:eventaddress1 forKey:@"eventaddress1"];
    [[NSUserDefaults standardUserDefaults]setValue:eventaddress2 forKey:@"eventaddress2"];
    [[NSUserDefaults standardUserDefaults]setValue:eventcity forKey:@"eventcity"];
    [[NSUserDefaults standardUserDefaults]setValue:eventpostcode forKey:@"eventpostcode"];
    [[NSUserDefaults standardUserDefaults]setValue:eventimageArr forKey:@"eventimageArr"];
    [[NSUserDefaults standardUserDefaults]setValue:eventId forKey:@"eventId"];
    [[NSUserDefaults standardUserDefaults]setValue:eventstatus forKey:@"eventstatus"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    EventsDetailViewController *eventVC;
    
    
    eventVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"EventsDetailViewController"];
    
     eventVC.urlStringeventImage = [Dict valueForKey:@"Event_Image"];
    
    [self.navigationController pushViewController:eventVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    // This will create a "invisible" footer
    return 0.01f;
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

- (IBAction)calenderButtonClick:(id)sender {
//    CalenderViewController *calenderVC;
//
//
//    calenderVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CalenderViewController"];
//
//
//
//    [self.navigationController pushViewController:calenderVC animated:YES];
//  //   [self presentViewController:calenderVC animated:YES completion:nil];
//
//    CalenderViewController *vc = [self.storyboard
//                                  instantiateViewControllerWithIdentifier:@"CalenderViewController"];
    
    CalenderViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CalenderViewController"];

    UINavigationController *objNav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:objNav animated:YES completion:nil];
  
    
}
@end
