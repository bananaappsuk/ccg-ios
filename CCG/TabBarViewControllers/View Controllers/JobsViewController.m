//
//  JobsViewController.m
//  CCG
//
//  Created by sriram angajala on 05/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "JobsViewController.h"
#import "JobsTableViewCell.h"
#import "JobsDetailViewController.h"
#import "GlobalVariables.h"
#import "ApiClass.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface JobsViewController ()<apiRequestProtocol>

@end

@implementation JobsViewController
{
    NSMutableArray *DataArray;
    NSString *alertMsg;
    NSString *str1,*userId;
     UIRefreshControl *refreshControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh1:) forControlEvents:UIControlEventValueChanged];
    [_jobsTableView addSubview:refreshControl];
     userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
    
    [self ServiceCall];
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([[GlobalVariables appVars].JobRegister isEqualToString:@"JobRegister"]) {
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
        
        
        NSString *urlStr = [NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/Events/GetjobsbyUserID?UserID=%@",userId];
        
        [apiRequest SendHttpGetwithUrl:urlStr withrequestType:RequestTypeGetJobs];
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
            
            if(requestType == RequestTypeGetJobs)
            {
                NSLog(@"%@",responseObject);
                NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                
                //    NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseDict valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                    [GlobalVariables appVars].JobRegister = @"";
                    
                    DataArray = [[NSMutableArray alloc]init];
                    DataArray = [responseObject valueForKey:@"JobList"];
                    
//                    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Job_StartDate_Format" ascending:YES];
//                    [DataArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
//
                    
                    
                    [_jobsTableView reloadData];
                    
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
    JobsTableViewCell *cell = (JobsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [_jobsTableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    }
    //  cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // NSMutableDictionary *sampleDict = [dignosticsNamesArray objectAtIndex:indexPath.row];
    
    //  NSString *imageStr = [[NSString alloc]init];
    //  imageStr = [sampleDict valueForKey:@"centerimage"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableDictionary *sampleDict = [DataArray objectAtIndex:indexPath.row];
    
    NSString *imageStr = [[NSString alloc]init];
    imageStr = [sampleDict valueForKey:@"Job_Image"];
    
    if([imageStr isEqualToString:@""] || imageStr == nil)
    {
        cell.jobImageView.image = [UIImage imageNamed:@"NoImage"];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.jobImageView.image = [UIImage imageWithData:imageData];
                if (cell.jobImageView.image == nil) {
                    cell.jobImageView.image = [UIImage imageNamed:@"NoImage"];
                }
                
            });
        });
    }
    
//    str1=[[DataArray valueForKey:@"Job_StartDate_Format"]objectAtIndex:indexPath.row];
//    NSArray *tempArray = [str1 componentsSeparatedByString:@"T"];
//    str1 = [tempArray objectAtIndex:0];
    
    NSString *status = [NSString stringWithFormat:@"%@",[[DataArray valueForKey:@"Register_Status"]objectAtIndex:indexPath.row]];
    
    if ([status isEqualToString:@"1"]) {
        cell.appliedImage.hidden =NO;
    }
    else
    {
         cell.appliedImage.hidden =YES;
    }
    
    
    cell.companyNameLabel.text = [[DataArray valueForKey:@"Job_Title"]objectAtIndex:indexPath.row];
    cell.postionaNameLabel.text = [[DataArray valueForKey:@"Job_Category_Name"]objectAtIndex:indexPath.row];
    
    cell.dateLabel.text = [[DataArray valueForKey:@"Job_EndDate_Format"]objectAtIndex:indexPath.row];
    
    cell.dayLabel.text = [[DataArray valueForKey:@"Job_Day"]objectAtIndex:indexPath.row];
    
    cell.locationLabel.text = [[DataArray valueForKey:@"Job_City"]objectAtIndex:indexPath.row];
    
  //  cell.timeLabel.text = [[DataArray valueForKey:@"Job_StartTime_Format"]objectAtIndex:indexPath.row];

    
   
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = @"Cell";
    JobsTableViewCell *cell = (JobsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   // cell.timeLabel.text = [[DataArray valueForKey:@"Job_StartTime_Format"]objectAtIndex:indexPath.row];
    cell.dayLabel.text = [[DataArray valueForKey:@"Job_Day"]objectAtIndex:indexPath.row];
    cell.dateLabel.text = [[DataArray valueForKey:@"Job_EndDate_Format"]objectAtIndex:indexPath.row];
    
    NSDictionary *Dict = [DataArray objectAtIndex:indexPath.row];
    NSString *jobdisc = [Dict valueForKey:@"Job_Description"];
    
    NSString *jobName = [Dict valueForKey:@"Job_Title"];
    
    NSString *jobperson = [Dict valueForKey:@"Job_ContactPersonname"];
    
    NSString *jobcontact = [Dict valueForKey:@"Job_ContactPersonnumber"];
    
    NSString *jobaddress1 = [Dict valueForKey:@"Job_Address1"];
    NSString *jobaddress2 = [Dict valueForKey:@"Job_Address2"];
    NSString *jobcity = [Dict valueForKey:@"Job_City"];
    NSString *jobpostcode = [Dict valueForKey:@"Job_Postcode"];
    NSString *jobId = [NSString stringWithFormat:@"%@",[Dict valueForKey:@"Job_Id"]];
    NSString *jobstatus = [NSString stringWithFormat:@"%@",[Dict valueForKey:@"Register_Status"]];
    
    // docIdStr = [Dict valueForKey:@"Doctor_Id"];
    [[NSUserDefaults standardUserDefaults]setValue:cell.dayLabel.text forKey:@"dayLabel"];
  //  [[NSUserDefaults standardUserDefaults]setValue:cell.timeLabel.text forKey:@"timeLabel"];
    [[NSUserDefaults standardUserDefaults]setValue:cell.dateLabel.text forKey:@"dateLabel"];
    
    [[NSUserDefaults standardUserDefaults]setValue:jobdisc forKey:@"jobdisc"];
    [[NSUserDefaults standardUserDefaults]setValue:jobName forKey:@"jobName"];
    [[NSUserDefaults standardUserDefaults]setValue:jobperson forKey:@"jobperson"];
    [[NSUserDefaults standardUserDefaults]setValue:jobcontact forKey:@"jobcontact"];
    
    [[NSUserDefaults standardUserDefaults]setValue:jobaddress1 forKey:@"jobaddress1"];
    [[NSUserDefaults standardUserDefaults]setValue:jobaddress2 forKey:@"jobaddress2"];
    [[NSUserDefaults standardUserDefaults]setValue:jobcity forKey:@"jobcity"];
    [[NSUserDefaults standardUserDefaults]setValue:jobpostcode forKey:@"jobpostcode"];
    [[NSUserDefaults standardUserDefaults]setValue:jobId forKey:@"jobId"];
    [[NSUserDefaults standardUserDefaults]setValue:jobstatus forKey:@"jobstatus"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    JobsDetailViewController *jobsVC;
    
    jobsVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"JobsDetailViewController"];
    
    jobsVC.urlStringjobImage = [Dict valueForKey:@"Job_Image"];
    
    [self.navigationController pushViewController:jobsVC animated:YES];
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

@end
