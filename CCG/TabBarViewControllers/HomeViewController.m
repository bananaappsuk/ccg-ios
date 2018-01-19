//
//  HomeViewController.m
//  CCG
//
//  Created by sriram angajala on 04/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "HomeViewController.h"
#import "HomePageCollectionViewCell.h"
#import "MessageBoardViewController.h"
#import "EventsViewController.h"
#import "JobsViewController.h"
#import "TrainingViewController.h"
#import "HomeTableViewCell.h"
#import "SafeGuardingViewController.h"
#import "ChildProtectionViewController.h"
#import "SafeguardingandchildprotectionViewController.h"
#import "ApiClass.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "EventsDetailViewController.h"
#import "JobsDetailViewController.h"
#import "TrainingDetailViewController.h"
@interface HomeViewController ()<apiRequestProtocol>

@end

@implementation HomeViewController
{
    NSArray *serviceImagesArray,*serviceNamesArray;
    NSString *nameStr,*alertMsg,*userId;
    NSMutableArray *dataArray;
    NSString *trainingCount,*messageCount,*jobCount,*eventCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    _extraView.layer.shadowColor = [UIColor blackColor].CGColor;
    _extraView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _extraView.layer.shadowOpacity = 0.9f;
   
    serviceImagesArray = [[NSArray alloc]initWithObjects:@"Messages",@"Training",@"Jobs",@"Events", nil];
    serviceNamesArray = [[NSArray alloc]initWithObjects:@"Message Board",@"Training",@"Jobs",@"Events", nil];
    
      userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
//    if (@available(iOS 10.0, *)) {
//        self.homeCollectionView.prefetchingEnabled = NO;
//    } else {
//        // Fallback on earlier versions
//    }
    
   
    
}
-(void)viewWillAppear:(BOOL)animated
{
      [self ServiceCall];
   
     nameStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"Name"];
    _nameLabel.text =[NSString stringWithFormat:@"%@  %@",@"Hi",nameStr];
    
     // [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    
    self.navigationController.navigationBar.backItem.title = @" ";
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    
    //   [self.navigationController.navigationBar setTitleTextAttributes:
    //    @{NSForegroundColorAttributeName:[UIColor colorWithRed:222.0f/255.0f green:105.0f/255.0f blue:8.0f/255.0f alpha:1.0f]}];
    
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor]};
//
//    self.navigationItem.title = @"CCG";
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
   
}

-(void)refreshData
{
    [self ServiceCall];
}

-(void)ServiceCall
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        NSString *urlStr = [NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/User/Bookings?UserID=%@",userId];
        
        [apiRequest SendHttpGetwithUrl:urlStr withrequestType:RequestTypeGetBookings];
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
            
            if(requestType == RequestTypeGetBookings)
            {
                NSLog(@"%@",responseObject);
                NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                
                //    NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseDict valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                    NSMutableArray *serviceArray;
                    NSMutableArray *sampleArray;
                    serviceArray = [NSMutableArray new];
                    sampleArray = [NSMutableArray new];
                    
                    messageCount = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"MessageCount"]];
                    jobCount = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"JobCount"]];
                    eventCount = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"EventCount"]];
                    trainingCount = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"TraningCount"]];
                    
              //     [self.homeCollectionView reloadItemsAtIndexPaths: serviceNamesArray];
                    
                 //   [_homeCollectionView reloadData];
                   [self.homeCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
                  
                    dataArray = [[NSMutableArray alloc]init];
                    serviceArray = [responseObject valueForKey:@"MyBookings"];
                    
                  //  sampleArray = [serviceArray valueForKey:@"MyBookings"];


                    for (NSDictionary *serviceDic in serviceArray) {

                        [sampleArray addObject:serviceDic];
                        
                    }
                    for (NSArray *serviceDic in [sampleArray valueForKey:@"MyBookings"]) {
                        
                        [dataArray addObjectsFromArray:serviceDic];
                    }
                   
                  
                    [_bookingTableview reloadData];
                    
                    if (dataArray.count>0) {
                        //  _bookingLabel.hidden = NO;
                        _bookingLabel.text = @"My Activities";
                        
                       
                        
                    }
                    else
                    {
                         _bookingLabel.hidden = YES;
                       // _bookingLabel.text = @"No Activities Found";
                    }
                    
                }
                else
                {
                     _bookingLabel.hidden = YES;
                    alertMsg= [responseObject valueForKey:@"Message"];
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
                
                alertMsg= [NSMutableString stringWithFormat:@"Server Not Responding Try After Some Time"];
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
    return [dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    HomeTableViewCell *cell = (HomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [_bookingTableview dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    }
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // NSMutableDictionary *sampleDict = [dignosticsNamesArray objectAtIndex:indexPath.row];
    
    //  NSString *imageStr = [[NSString alloc]init];
    //  imageStr = [sampleDict valueForKey:@"centerimage"];
    
  //  NSMutableDictionary *sampleDict= [dataArray objectAtIndex:indexPath.row];
    
//    NSMutableArray *sampleArray;
//    sampleArray = [NSMutableArray new];
//
//    for (NSMutableDictionary *sampleDict in [dataArray objectAtIndex:indexPath.row]) {
//
//        [sampleArray addObject:sampleDict];
//
//    }
    
    

    
    
    NSString *strattimeStr = [[dataArray valueForKey:@"Module_Start_Time"]objectAtIndex:indexPath.row];
     NSString *endtimeStr = [[dataArray valueForKey:@"Module_End_Time"]objectAtIndex:indexPath.row];
    
     NSString *modulestr = [NSString stringWithFormat:@"%@",[[dataArray valueForKey:@"Module_Type"]objectAtIndex:indexPath.row]];

    NSString *startdate;

        startdate=[[dataArray valueForKey:@"Module_Start_Date"]objectAtIndex:indexPath.row];
        NSArray *tempArray = [startdate componentsSeparatedByString:@"-"];
        startdate = [tempArray objectAtIndex:0];
   
    cell.nameLabel.text = [[dataArray valueForKey:@"Module_Title"]objectAtIndex:indexPath.row];
    
    //     cell.DoctorImageView.image = [UIImage imageNamed:imagesArray [indexPath.row]];
    
    if ([modulestr isEqualToString:@"1"]) {
        cell.categoryLabel.text = @"Event";
    }
    else if ([modulestr isEqualToString:@"2"])
    {
    cell.categoryLabel.text = @"Job";
    }
    else
    {
         cell.categoryLabel.text = @"Training";
    }
    
  //  cell.categoryLabel.hidden = YES;
//    
    cell.locationLabel.text = [[dataArray valueForKey:@"Module_City"]objectAtIndex:indexPath.row];
    
    cell.dayLabel.text = [[dataArray valueForKey:@"Module_Start_Day"]objectAtIndex:indexPath.row];
    
    cell.dateLabel.text = [NSString stringWithFormat:@"%@",startdate];
    
    cell.timeLabel.text = [NSString stringWithFormat:@"%@ %@ %@",strattimeStr, @"-",  endtimeStr];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSDictionary *Dict = [dataArray objectAtIndex:indexPath.row];
    
    NSString *moduleType = [NSString stringWithFormat:@"%@",[Dict valueForKey:@"Module_Type"]];
     NSString *moduleID = [NSString stringWithFormat:@"%@",[Dict valueForKey:@"Module_ID"]];
    
    if ([moduleType isEqualToString:@"3"]) {
        
        TrainingDetailViewController *trainingVC;
        
        trainingVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"TrainingDetailViewController"];
        
        [[NSUserDefaults standardUserDefaults]setValue:moduleID forKey:@"trainingModuleId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
         trainingVC.homestr = moduleType;
        // hospVC.urlStringdignosticImage = [Dict valueForKey:@"centerimage"];
        
        [self.navigationController pushViewController:trainingVC animated:YES];
        
    }
    else if ([moduleType isEqualToString:@"2"])
    
    {
        JobsDetailViewController *trainingVC;
        trainingVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"JobsDetailViewController"];
        [[NSUserDefaults standardUserDefaults]setValue:moduleID forKey:@"jobModuleId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        trainingVC.homeStr = moduleType;
        // hospVC.urlStringdignosticImage = [Dict valueForKey:@"centerimage"];
       [self.navigationController pushViewController:trainingVC animated:YES];
        
    }
    else
    {
        
        EventsDetailViewController *trainingVC;
        trainingVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"EventsDetailViewController"];
        [[NSUserDefaults standardUserDefaults]setValue:moduleID forKey:@"eventModuleId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        trainingVC.HomeStr = moduleType;
        [self.navigationController pushViewController:trainingVC animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    // This will create a "invisible" footer
    return 0.01f;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [serviceImagesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"Cell";
    HomePageCollectionViewCell *cell = (HomePageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
   
    
    
    cell.countLabel.layer.masksToBounds = YES;
    cell.countLabel.layer.cornerRadius = 10.0;
 
    
    
    [cell.nameLabel setTextAlignment:NSTextAlignmentCenter];
   
  
    cell.nameLabel.text = [serviceNamesArray objectAtIndex:indexPath.row];
    
    [cell.nameLabel sizeToFit];
   
        cell.HomeImageView.image  = [UIImage imageNamed:[serviceImagesArray objectAtIndex:indexPath.row]];
        //  [cell.serviceImageView sizeToFit];
   
    if ([cell.nameLabel.text isEqualToString:@"Message Board"]) {
        
        if ([messageCount isEqualToString:@"0"]) {
            cell.countLabel.hidden = YES;
        }
        else
        {
            cell.countLabel.hidden = NO;
            cell.countLabel.text = [NSString stringWithFormat:@"%@",messageCount];
        }
    }
    else if ([cell.nameLabel.text isEqualToString:@"Training"])
    {
        if ([trainingCount isEqualToString:@"0"]) {
            cell.countLabel.hidden = YES;
        }
        else
        {
             cell.countLabel.hidden = NO;
             cell.countLabel.text = [NSString stringWithFormat:@"%@",trainingCount];
        }
        
       
    }
    else if ([cell.nameLabel.text isEqualToString:@"Jobs"])
    {
        if ([jobCount isEqualToString:@"0"]) {
            cell.countLabel.hidden = YES;
        }
        else
        {
            cell.countLabel.hidden = NO;
            cell.countLabel.text = [NSString stringWithFormat:@"%@", jobCount];
        }
    }
    else
    {
        if ([eventCount isEqualToString:@"0"]) {
            cell.countLabel.hidden = YES;
        }
        else
        {
            cell.countLabel.hidden = NO;
            cell.countLabel.text = [NSString stringWithFormat:@"%@",eventCount];
        }
        
    }
    
    [cell.HomeImageView sizeToFit];
    
    [cell.contentView sizeToFit];
    cell.autoresizesSubviews = YES;
    
    return cell;
}
#pragma mark Collection view layout things
// Layout: Set cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // CGSize mElementSize = CGSizeMake(self.view.frame.size.width/3-10, self.view.frame.size.width/3-10);
  //  if ([[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPhone) {
        return CGSizeMake((collectionView.frame.size.width/4)-2, ((collectionView.frame.size.width/4)-2) );
  //  }
//    else
//    {
//        return CGSizeMake((collectionView.frame.size.width/2)-2, ((collectionView.frame.size.width/3)-2) );
//    }
    // return mElementSize;
    
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,0,0,0);  // top, left, bottom, right
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            MessageBoardViewController *trainingVC;
            
            
            trainingVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MessageBoardViewController"];
            
            // hospVC.urlStringdignosticImage = [Dict valueForKey:@"centerimage"];
            
            [self.navigationController pushViewController:trainingVC animated:YES];
        }
            break;
        case 1:
        {
            
            TrainingViewController *trainingVC;
            
            
            trainingVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"TrainingViewController"];
            
            // hospVC.urlStringdignosticImage = [Dict valueForKey:@"centerimage"];
            
            [self.navigationController pushViewController:trainingVC animated:YES];
     
            
        }
            break;
        case 2:
        {
            JobsViewController *jobsVC;
            
            
            jobsVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"JobsViewController"];
            
            // hospVC.urlStringdignosticImage = [Dict valueForKey:@"centerimage"];
            
            [self.navigationController pushViewController:jobsVC animated:YES];
        }
            break;
        case 3:
        {
            
            EventsViewController *eventVC;
            
            
            eventVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"EventsViewController"];
            // hospVC.urlStringdignosticImage = [Dict valueForKey:@"centerimage"];
            [self.navigationController pushViewController:eventVC animated:YES];
            
            
        }
            break;
        case 4:
        {
          
        }
            break;
        case 5:
        {
            
           
        }
            break;
        default:
            break;
    }
    
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

- (IBAction)safeGuardButtonClick:(id)sender {
    SafeguardingandchildprotectionViewController *safeVC;
    
    
    safeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SafeguardingandchildprotectionViewController"];
    
    // hospVC.urlStringdignosticImage = [Dict valueForKey:@"centerimage"];
    
    [self.navigationController pushViewController:safeVC animated:YES];
    
}

- (IBAction)childProtectionButtonClick:(id)sender {
    
    SafeguardingandchildprotectionViewController *childVC;
    
    
    childVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SafeguardingandchildprotectionViewController"];
    
    // hospVC.urlStringdignosticImage = [Dict valueForKey:@"centerimage"];
    
    [self.navigationController pushViewController:childVC animated:YES];
    
}

- (IBAction)jobsClick:(id)sender {
}

- (IBAction)eventsClick:(id)sender {
}
@end
