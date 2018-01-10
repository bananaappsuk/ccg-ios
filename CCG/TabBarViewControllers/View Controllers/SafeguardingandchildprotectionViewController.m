//
//  SafeguardingandchildprotectionViewController.m
//  CCG
//
//  Created by sriram angajala on 15/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "SafeguardingandchildprotectionViewController.h"
#import "SafeGuardandChildWebViewController.h"
@interface SafeguardingandchildprotectionViewController ()

@end

@implementation SafeguardingandchildprotectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    _safeguardingchildrenandyoungpeopleguideButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    _safeguardingchildrenandyoungpeopleguideButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_safeguardingchildrenandyoungpeopleguideButton setTitle: @"Safe Guarding Children and Young Persons Guide" forState: UIControlStateNormal];

    CALayer *layer = self.contactsView.layer;
    layer.shadowOffset = CGSizeMake(1, 0);
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowRadius = 3.0f;
    layer.shadowOpacity = 0.70f;
    layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
    
    _safeguardingchildrenandyoungpeopleguideButton.layer.shadowColor = [UIColor blackColor].CGColor;
   _safeguardingchildrenandyoungpeopleguideButton.layer.shadowOffset = CGSizeMake(15.0f,15.0f);
    _safeguardingchildrenandyoungpeopleguideButton.clipsToBounds = NO;
    _safeguardingchildrenandyoungpeopleguideButton.layer.shadowRadius = 5.0f;
    
    // Do any additional setup after loading the view.
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

- (IBAction)safeguardingadultsguideButtonClick:(id)sender {
      SafeGuardandChildWebViewController *HomeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SafeGuardandChildWebViewController"];
    HomeVC.safeguarding = @"1";
    
     [self.navigationController pushViewController:HomeVC animated:YES];
}
- (IBAction)safeguardingchildrenandyoungpeopleguideButtonClick:(id)sender {
    
    SafeGuardandChildWebViewController *HomeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SafeGuardandChildWebViewController"];
    HomeVC.childProtection = @"2";
    [self.navigationController pushViewController:HomeVC animated:YES];
    
}
@end
