//
//  MessageBoardViewController.m
//  CCG
//
//  Created by sriram angajala on 07/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "MessageBoardViewController.h"
#import "MessageBoardTableViewCell.h"
#import "MessageDetailViewController.h"
#import "MessageVideoDetailViewController.h"
#import "MessageImageViewController.h"
#import "GlobalVariables.h"
#import "ApiClass.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface MessageBoardViewController ()<apiRequestProtocol>

@end

@implementation MessageBoardViewController
{
     NSMutableArray *DataArray;
    NSString *alertMsg,*userId;
    UIRefreshControl *refreshControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh1:) forControlEvents:UIControlEventValueChanged];
    [_messageBoardTableView addSubview:refreshControl];
     userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
    
    [self ServiceCall];
   
}
-(void)viewWillAppear:(BOOL)animated
{
    
    
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
//
    
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
        
        
        NSString *urlStr = [NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/Message/GetMessagesbyUserID?UserID=%@",userId];
        
        [apiRequest SendHttpGetwithUrl:urlStr withrequestType:RequestTypeGetMessages];
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
            
            if(requestType == RequestTypeGetMessages)
            {
                NSLog(@"%@",responseObject);
                NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                
                //    NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseDict valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                    
                    
                    DataArray = [[NSMutableArray alloc]init];
                    DataArray = [responseObject valueForKey:@"Messages"];
                    
//                    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Message_Post_DateTime_Format" ascending:YES];
//                    [DataArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
                    
                    [_messageBoardTableView reloadData];
                    
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
    MessageBoardTableViewCell *cell = (MessageBoardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [_messageBoardTableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    }
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableDictionary *sampleDict = [DataArray objectAtIndex:indexPath.row];
    
//    NSString *imageStr = [[NSString alloc]init];
//    imageStr = [sampleDict valueForKey:@"Message_URL"];
//
//    if([imageStr isEqualToString:@""] || imageStr == nil)
//    {
//        cell.messageImageView.image = [UIImage imageNamed:@"Sample"];
//    }
//    else
//    {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                cell.messageImageView.image = [UIImage imageWithData:imageData];
//                if (cell.messageImageView.image == nil) {
//                    cell.messageImageView.image = [UIImage imageNamed:@"Sample"];
//                }
//
//            });
//        });
//    }
    
    NSString *str = [NSString stringWithFormat:@"%@",[sampleDict valueForKey:@"Message_Type"]];
    
     if ([str isEqualToString:@"1"]) {
          cell.messageImageView.image = [UIImage imageNamed:@"imageMessage"];
     }
    else
    {
         cell.messageImageView.image = [UIImage imageNamed:@"videoMessage"];
    }
    
    
    NSString *readstatus = [NSString stringWithFormat:@"%@",[[DataArray valueForKey:@"Message_Read_Status"]objectAtIndex:indexPath.row]];
    
    if ([readstatus isEqualToString:@"1"]) {
        [cell.messageDetailLabel setFont:[UIFont systemFontOfSize:20]];
    }
    else
    {
        [cell.messageDetailLabel setFont:[UIFont systemFontOfSize:16]];
    }

    
    
  //  cell.messageDetailLabel.hidden = YES;
    cell.messageDetailLabel.text = [[DataArray valueForKey:@"Message_Description"]objectAtIndex:indexPath.row];
    
    //     cell.DoctorImageView.image = [UIImage imageNamed:imagesArray [indexPath.row]];
    
    cell.messageTitleLabel.text = [[DataArray valueForKey:@"Message_Title"]objectAtIndex:indexPath.row];
    
    
    cell.messageDateLabel.text = [[DataArray valueForKey:@"Message_Post_DateTime_Format"]objectAtIndex:indexPath.row];
    
    cell.messageCategoryLabel.text = [[DataArray valueForKey:@"Content_Type"]objectAtIndex:indexPath.row];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic = [DataArray objectAtIndex:indexPath.row];
      NSMutableArray *sampleArr = [[DataArray valueForKey:@"MessageComments"]objectAtIndex:indexPath.row];
    NSMutableArray *commentArr;
    commentArr = [NSMutableArray new];
    
    
    for (NSDictionary *itemDict in sampleArr) {
        
        [commentArr addObject:[itemDict valueForKey:@"Comment"]];
        
    }
    
    
    NSString *str = [NSString stringWithFormat:@"%@",[dic valueForKey:@"Message_Type"]];
    
    NSString *videostr = [NSString stringWithFormat:@"%@",[dic valueForKey:@"Message_URL"]];
    
    NSString *messageId = [NSString stringWithFormat:@"%@",[dic valueForKey:@"Message_Id"]];
    
    NSString *status = [NSString stringWithFormat:@"%@",[dic valueForKey:@"Message_Read_Status"]];
   
    NSString *messagedisc = [dic valueForKey:@"Message_Description"];
    NSString *traininame = [dic valueForKey:@"Trainee_Name"];
    
     NSString *datestr = [NSString stringWithFormat:@"%@",[dic valueForKey:@"Message_Post_DateTime_Format"]];
    NSString *messagetitle = [NSString stringWithFormat:@"%@",[dic valueForKey:@"Message_Title"]];
    
    if ([str isEqualToString:@"1"]) {
        
        MessageImageViewController *eventVC;
        
        eventVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MessageImageViewController"];
        
        eventVC.urlStringmessageImage = [NSString stringWithFormat:@"%@",[dic valueForKey:@"Message_URL"]];
        
        [[NSUserDefaults standardUserDefaults]setValue:messagedisc forKey:@"messagedisc"];
        [[NSUserDefaults standardUserDefaults]setValue:traininame forKey:@"traininame"];
        [[NSUserDefaults standardUserDefaults]setValue:datestr forKey:@"datestr"];
        [[NSUserDefaults standardUserDefaults]setValue:messagetitle forKey:@"messagetitle"];
        [[NSUserDefaults standardUserDefaults]setValue:messageId forKey:@"messageId"];
        [[NSUserDefaults standardUserDefaults]setValue:status forKey:@"statusmessage"];
        
         [[NSUserDefaults standardUserDefaults]setValue:commentArr forKey:@"commentArr"];
         [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [self.navigationController pushViewController:eventVC animated:YES];
    }
    else
    {
        MessageVideoDetailViewController *eventVC;
        
        eventVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MessageVideoDetailViewController"];
        [[NSUserDefaults standardUserDefaults]setValue:messagedisc forKey:@"messagedisc"];
        [[NSUserDefaults standardUserDefaults]setValue:traininame forKey:@"traininame"];
        [[NSUserDefaults standardUserDefaults]setValue:datestr forKey:@"datestr"];
        [[NSUserDefaults standardUserDefaults]setValue:messagetitle forKey:@"messagetitle"];
        [[NSUserDefaults standardUserDefaults]setValue:messageId forKey:@"messageId"];
        [[NSUserDefaults standardUserDefaults]setValue:status forKey:@"statusmessage"];
        
        [[NSUserDefaults standardUserDefaults]setValue:videostr forKey:@"videostr"];
        [[NSUserDefaults standardUserDefaults]setValue:commentArr forKey:@"commentArr"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self.navigationController pushViewController:eventVC animated:YES];
    }
   
   
    
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
