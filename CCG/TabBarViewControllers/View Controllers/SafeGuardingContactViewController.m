//
//  SafeGuardingContactViewController.m
//  CCG
//
//  Created by sriram angajala on 19/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "SafeGuardingContactViewController.h"

@interface SafeGuardingContactViewController ()

@end

@implementation SafeGuardingContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backItem.title = @" ";
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:120.0f/255.0f green:120.0f/255.0f blue:130.0f/255.0f alpha:1.0f]}];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"]style:UIBarButtonItemStylePlain target:self action:@selector(HomeView)];
    [backButton setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title = @"Choosen Care Group";
}

-(void)HomeView
{
    [self.navigationController popViewControllerAnimated:NO];
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
