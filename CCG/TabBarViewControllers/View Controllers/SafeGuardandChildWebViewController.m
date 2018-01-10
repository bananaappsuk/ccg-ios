//
//  SafeGuardandChildWebViewController.m
//  CCG
//
//  Created by sriram angajala on 15/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "SafeGuardandChildWebViewController.h"
#import "SafeGuardingContactViewController.h"
@interface SafeGuardandChildWebViewController ()

@end

@implementation SafeGuardandChildWebViewController

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
    
  
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    _contactButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    _contactButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_contactButton setTitle: @"Contact\nASAD ABDULLAH" forState: UIControlStateNormal];
    
    
    
    
    
    if ([_safeguarding isEqualToString:@"1"]) {
        [_safeGuardButton setTitleColor:[UIColor colorWithRed:128/255.0f green:0/255.0f blue:128/255.0f alpha:1.0f] forState:UIControlStateNormal];
        _safeguardLable.text = @"Safeguarding Adults";
        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.myguideapps.com/nhs_safeguarding/default/safeguarding_adults/?nocache=0.4674478393244097"]]];
    }
    
    else
    {
        _safeguardLable.text = @"Safeguarding Children and Young People";
        [_childProtectionButton setTitleColor:[UIColor colorWithRed:128/255.0f green:0/255.0f blue:128/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.myguideapps.com/nhs_safeguarding/default/safeguarding_children/?nocache=0.5346279246361767"]]];
    }
    
   
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



- (IBAction)contactClick:(id)sender {
    
    SafeGuardingContactViewController *HomeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SafeGuardingContactViewController"];
       
    [self.navigationController pushViewController:HomeVC animated:YES];
}

- (IBAction)safeGuardButtonClick:(id)sender {
    
  //  _safeGuardButton.titleLabel.textColor = [UIColor blueColor];
    
    [_safeGuardButton setTitleColor:[UIColor colorWithRed:128/255.0f green:0/255.0f blue:128/255.0f alpha:1.0f] forState:UIControlStateNormal];
     [_childProtectionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _safeguardLable.text = @"Safeguarding Adults";
    [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.myguideapps.com/nhs_safeguarding/default/safeguarding_adults/?nocache=0.4674478393244097"]]];
}
- (IBAction)childProtectionButtonClick:(id)sender {
    
     _safeguardLable.text = @"Safeguarding Children and Young People";
     [_childProtectionButton setTitleColor:[UIColor colorWithRed:128/255.0f green:0/255.0f blue:128/255.0f alpha:1.0f] forState:UIControlStateNormal];
     [_safeGuardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.myguideapps.com/nhs_safeguarding/default/safeguarding_children/?nocache=0.5346279246361767"]]];
    
}
@end
