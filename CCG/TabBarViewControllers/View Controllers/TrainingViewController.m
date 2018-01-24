//
//  TrainingViewController.m
//  CCG
//
//  Created by sriram angajala on 05/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "TrainingViewController.h"
#import "TrainingTableViewCell.h"
#import "TrainingDetailViewController.h"
#import "GlobalVariables.h"
#import "ApiClass.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface TrainingViewController ()<apiRequestProtocol>

@end

@implementation TrainingViewController
{
    NSMutableArray *DataArray;
    NSString *alertMsg,*userId;
    NSString *str1;
    UIRefreshControl *refreshControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh1:) forControlEvents:UIControlEventValueChanged];
    [_trainingTableView addSubview:refreshControl];
    
     userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
    
    [self ServiceCall];
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([[GlobalVariables appVars].TrainingRegister isEqualToString:@"TrainingRegister"])
    {
        [self ServiceCall];
    }
    else
    {
        
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
        
        
        NSString *urlStr = [NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/Events/GetTraningsbyUserID?UserID=%@",userId];
        
        [apiRequest SendHttpGetwithUrl:urlStr withrequestType:RequestTypeGetTraining];
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
            
            if(requestType == RequestTypeGetTraining)
            {
                NSLog(@"%@",responseObject);
                NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                
                //    NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseDict valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                    
                    [GlobalVariables appVars].TrainingRegister = @"";
                    DataArray = [[NSMutableArray alloc]init];
                    DataArray = [responseObject valueForKey:@"TraningList"];
                    
//                    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Traning_StartDate_Format" ascending:YES];
//                    [DataArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
//                   
                    [_trainingTableView reloadData];
                    
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
    TrainingTableViewCell *cell = (TrainingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [_trainingTableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableDictionary *sampleDict = [DataArray objectAtIndex:indexPath.row];
    
    NSString *imageStr = [[NSString alloc]init];
    imageStr = [sampleDict valueForKey:@"Traning_Image"];
    
    if([imageStr isEqualToString:@""] || imageStr == nil)
    {
        cell.trainingImageView.image = [UIImage imageNamed:@"NoImage"];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.trainingImageView.image = [UIImage imageWithData:imageData];
                if (cell.trainingImageView.image == nil) {
                    cell.trainingImageView.image = [UIImage imageNamed:@"NoImage"];
                }
                
            });
        });
    }
    
//    str1=[[DataArray valueForKey:@"Traning_StartDate_Format"]objectAtIndex:indexPath.row];
//    NSArray *tempArray = [str1 componentsSeparatedByString:@"T"];
//    str1 = [tempArray objectAtIndex:0];
    
    NSString *status = [NSString stringWithFormat:@"%@",[[DataArray valueForKey:@"Register_Status"]objectAtIndex:indexPath.row]];
    
    if ([status isEqualToString:@"1"]) {
         cell.registerImage.hidden =NO;
    }
    else
    {
         cell.registerImage.hidden =YES;
    }
    
    
    cell.trainingNameLabel.text = [[DataArray valueForKey:@"Traning_Title"]objectAtIndex:indexPath.row];
    cell.dayLabel.text = [[DataArray valueForKey:@"Traning_Day"]objectAtIndex:indexPath.row];
    
    cell.dateLabel.text = [[DataArray valueForKey:@"Traning_StartDate_Format"]objectAtIndex:indexPath.row];
    
    cell.trainingCategoryLabel.text = [[DataArray valueForKey:@"Traning_Category_Name"]objectAtIndex:indexPath.row];
    
    cell.timeLabel.text = [[DataArray valueForKey:@"Traning_StartTime_Format"]objectAtIndex:indexPath.row];
    
    cell.locationLabel.text = [[DataArray valueForKey:@"Traning_City"]objectAtIndex:indexPath.row];

    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = @"Cell";
    TrainingTableViewCell *cell = (TrainingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.timeLabel.text = [[DataArray valueForKey:@"Traning_StartTime_Format"]objectAtIndex:indexPath.row];
    cell.dayLabel.text = [[DataArray valueForKey:@"Traning_Day"]objectAtIndex:indexPath.row];
    cell.dateLabel.text = [[DataArray valueForKey:@"Traning_StartDate_Format"]objectAtIndex:indexPath.row];
    
    NSDictionary *Dict = [DataArray objectAtIndex:indexPath.row];
    
    NSMutableArray *sampleArr = [[DataArray valueForKey:@"Traning_Photos"]objectAtIndex:indexPath.row];
    
    //  NSDictionary *sampleDict = [sampleArr objectAtIndex:indexPath.row];
    
    NSMutableArray *trainingimageArr;
    trainingimageArr = [NSMutableArray new];
    
    for (NSDictionary *itemDict in sampleArr) {
        
        [trainingimageArr addObject:[itemDict valueForKey:@"Traning_Photo"]];
        
    }
    
    
    NSString *trainingdisc = [Dict valueForKey:@"Traning_Description"];
    
    NSString *trainingName = [Dict valueForKey:@"Traning_Title"];
    
    NSString *trainingperson = [Dict valueForKey:@"Traning_ContactPersonname"];
    
    NSString *trainingcontact = [Dict valueForKey:@"Traning_ContactPersonnumber"];
    
    NSString *trainingaddress1 = [Dict valueForKey:@"Traning_Address1"];
    
    NSString *trainingaddress2 = [Dict valueForKey:@"Traning_Address2"];
    
    NSString *trainingcity = [Dict valueForKey:@"Traning_City"];
    
    NSString *trainingpostcode = [Dict valueForKey:@"Traning_Postcode"];
    
    NSString *trainingId = [NSString stringWithFormat:@"%@",[Dict valueForKey:@"Traning_Id"]];
    NSString *trainingStatus = [NSString stringWithFormat:@"%@",[Dict valueForKey:@"Register_Status"]];
    
    
    // docIdStr = [Dict valueForKey:@"Doctor_Id"];
    [[NSUserDefaults standardUserDefaults]setValue:cell.dayLabel.text forKey:@"traningdayLabel"];
    [[NSUserDefaults standardUserDefaults]setValue:cell.timeLabel.text forKey:@"traningtimeLabel"];
    [[NSUserDefaults standardUserDefaults]setValue:cell.dateLabel.text forKey:@"traningdateLabel"];
    
    [[NSUserDefaults standardUserDefaults]setValue:trainingdisc forKey:@"traningdisc"];
    [[NSUserDefaults standardUserDefaults]setValue:trainingName forKey:@"traningName"];
    [[NSUserDefaults standardUserDefaults]setValue:trainingperson forKey:@"traningperson"];
    [[NSUserDefaults standardUserDefaults]setValue:trainingcontact forKey:@"traningcontact"];
    
    [[NSUserDefaults standardUserDefaults]setValue:trainingaddress1 forKey:@"traningaddress1"];
    [[NSUserDefaults standardUserDefaults]setValue:trainingaddress2 forKey:@"traningaddress2"];
    [[NSUserDefaults standardUserDefaults]setValue:trainingcity forKey:@"traningcity"];
    [[NSUserDefaults standardUserDefaults]setValue:trainingpostcode forKey:@"traningpostcode"];
    [[NSUserDefaults standardUserDefaults]setValue:trainingimageArr forKey:@"trainingimageArr"];
    
     [[NSUserDefaults standardUserDefaults]setValue:trainingId forKey:@"trainingId"];
     [[NSUserDefaults standardUserDefaults]setValue:trainingStatus forKey:@"trainingStatus"];
     [[NSUserDefaults standardUserDefaults]synchronize];
  
    TrainingDetailViewController *trainingVC;
       trainingVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"TrainingDetailViewController"];
    
     trainingVC.urlStringtrainingImage = [Dict valueForKey:@"Traning_Image"];
    
    [self.navigationController pushViewController:trainingVC animated:YES];
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
