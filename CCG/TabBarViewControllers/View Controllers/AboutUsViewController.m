//
//  AboutUsViewController.m
//  CCG
//
//  Created by sriram angajala on 11/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    
//    NSString *str = @"\u0916\u0941\u0926\u0930\u093e \u092e\u094b\u092c\u093e\u0908\u0932 \u0935\u093f\u0915\u094d\u0930\u0947\u0924\u093e\u0913 \u0915\u094b \u0906\u092a\u0938\u0940 \u0932\u093e\u092d \u0914\u0930 \u092c\u093e\u095b\u093e\u0930 \u0915\u094b \u0938\u093e\u092b\u093c-\u0938\u0941\u0925\u0930\u093e \u092c\u0928\u093e\u090f \u0930\u0916\u0928\u0947 \u0915\u0947 \u0932\u093f\u090f \u090f\u0915\u091c\u0941\u091f \u0915\u0930\u0928\u093e.";
//
//    self.navigationItem.title = @"Choosen Care Group";
//
//    _aboutusTextView.text = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:str options:NSJSONReadingAllowFragments error:NULL] encoding:NSUTF8StringEncoding];


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
