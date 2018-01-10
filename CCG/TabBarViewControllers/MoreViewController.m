//
//  MoreViewController.m
//  CCG
//
//  Created by sriram angajala on 04/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "MoreViewController.h"
#import "ContactUsViewController.h"
#import "AboutUsViewController.h"
#import "GlobalVariables.h"
#import "LoginViewController.h"
#import "FeedBackViewController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController
{
    NSMutableArray *optionsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    optionsArray = [[NSMutableArray alloc]initWithObjects:@"About Us",@"Contact Us",@"Faq's", nil ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableview delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [optionsArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
       cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    cell.separatorInset = UIEdgeInsetsZero;
    
    
    // NSMutableDictionary *sampleDict = [dataArray objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = [optionsArray objectAtIndex:indexPath.row];
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    // This will create a "invisible" footer
    return 0.01f;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)aboutusClick:(id)sender {
    
    AboutUsViewController *aboutVC;
    aboutVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
    
    // hospVC.urlStringdignosticImage = [Dict valueForKey:@"centerimage"];
    
    [self.navigationController pushViewController:aboutVC animated:YES];
    
}

- (IBAction)contactusClick:(id)sender {
    ContactUsViewController *contactVC;
    contactVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ContactUsViewController"];
    
    // hospVC.urlStringdignosticImage = [Dict valueForKey:@"centerimage"];
    
    [self.navigationController pushViewController:contactVC animated:YES];
}

- (IBAction)feedbackClick:(id)sender {
    
    FeedBackViewController *aboutVC;
    aboutVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"FeedBackViewController"];
    
    // hospVC.urlStringdignosticImage = [Dict valueForKey:@"centerimage"];
    
    [self.navigationController pushViewController:aboutVC animated:YES];
}

- (IBAction)logoutClick:(id)sender {
    
  //   [GlobalVariables appVars].loginFrom = @"";
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginMessage"];
    // [self.navigationController popToRootViewControllerAnimated:NO];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    window.rootViewController = navigationController;
}
@end
