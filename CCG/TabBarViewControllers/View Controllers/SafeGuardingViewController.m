//
//  SafeGuardingViewController.m
//  CCG
//
//  Created by sriram angajala on 11/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "SafeGuardingViewController.h"

@interface SafeGuardingViewController ()

@end

@implementation SafeGuardingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _safeGuardTextView.layer.shadowColor = [UIColor blackColor].CGColor;
    _safeGuardTextView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _safeGuardTextView.layer.shadowOpacity = 0.9f;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    
    
    
    [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.myguideapps.com/nhs_safeguarding/default/safeguarding_adults/?nocache=0.4674478393244097"]]];
    
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
}
@end
