
//  HomeScreenViewController.m
//  CCG
//
//  Created by sriram angajala on 04/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "ProfileViewController.h"

@interface HomeScreenViewController ()

@end

@implementation HomeScreenViewController
{
    UIImage* profileImage;
    UIBarButtonItem *rightButton;
    UIButton *profileButton;
    UIImageView *tileImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.hidesBackButton = YES;
    
    
 //   [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
    if (@available(iOS 10.0, *)) {
        [[UITabBar appearance] setUnselectedItemTintColor:[UIColor blackColor]];
    } else {
        // Fallback on earlier versions
    }
    
 //   [[UITabBar appearance] setTintColor:[UIColor colorWithRed:222.0f/255.0f green:105.0f/255.0f blue:8.0f/255.0f alpha:1.0f]];
    
//    tileImageView = [[UIImageView alloc]init];
//    tileImageView.frame = CGRectMake(self.view.frame.origin.x+self.view.frame.size.width-50, 10, 30, 30);
//
//    tileImageView.layer.cornerRadius = 30/2.0f;
//    tileImageView.clipsToBounds = YES;
    
    profileButton = [[UIButton alloc]init ];
    profileButton.frame = CGRectMake(self.view.frame.origin.x+self.view.frame.size.width-50, 10, 30, 30);
    
    profileButton.layer.cornerRadius = 30/2.0f;
    profileButton.clipsToBounds = YES;
    
    [profileButton addTarget:self action:@selector(profileClick)
     forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:profileButton];
 //   [self.navigationController.navigationBar addSubview:tileImageView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
     [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    
    
    self.navigationController.navigationBar.backItem.title = @" ";
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    
       [self.navigationController.navigationBar setTitleTextAttributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithRed:120.0f/255.0f green:120.0f/255.0f blue:130.0f/255.0f alpha:1.0f]}];
    
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor]};
//
    self.navigationItem.title = @"Choosen Care Group";
    
   // UIImage *image = [UIImage imageNamed:@"LogoIcon"];
   // self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
   

    
//    UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 66)];
//    [self.view addSubview:navbar];

   

     NSString *imageStr = [[NSUserDefaults standardUserDefaults]valueForKey:@"User_Pic"];

    if([imageStr isEqualToString:@""])
    {
      //  [tileImageView setImage: [UIImage imageNamed:@"userPlaceHolder"]];
        
        [profileButton setImage:[UIImage imageNamed:@"userPlaceHolder"] forState:UIControlStateNormal];
        
       // [profileImage setImage:[UIImage imageNamed:@"Sample"]];
    }
    else
    {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            //                            NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[textLine stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            NSData *data = [[NSData alloc] initWithBase64EncodedString:imageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
            dispatch_async(dispatch_get_main_queue(), ^{

              
             //   profileImage = [UIImage imageWithData:data];
                
            //    [tileImageView setImage: [UIImage imageWithData:data]];
                
                [profileButton setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
                
               // [navbar addSubview:tileImageView];
            
//                rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithData:data] style:UIBarButtonItemStylePlain target:self action:nil];
//                [rightButton setTintColor:[UIColor blackColor]];
//                self.navigationItem.rightBarButtonItem = rightButton;

            });
        });



       
    }
   
    
    
 //   rightButton = [[UIBarButtonItem alloc]initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:nil ];
    
    

   
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:profileImage]];
//    self.navigationItem.rightBarButtonItem = item;
//
    
}
- (NSString *)encodeToBase64String:(UIImage *)givenImage {
    return [UIImagePNGRepresentation(givenImage) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

-(void)profileClick
{
    ProfileViewController *profileVC;
    profileVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    
    // hospVC.urlStringdignosticImage = [Dict valueForKey:@"centerimage"];
    
    [self.navigationController pushViewController:profileVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if([item.title  isEqualToString: @"Home"])
    {
       // tileImageView.hidden = NO;
         profileButton.hidden = NO;
        NSString *imageStr = [[NSUserDefaults standardUserDefaults]valueForKey:@"User_Pic"];
        
        if([imageStr isEqualToString:@""])
        {
          //  [tileImageView setImage: [UIImage imageNamed:@"userPlaceHolder"]];
             [profileButton setImage:[UIImage imageNamed:@"userPlaceHolder"] forState:UIControlStateNormal];
            // [profileImage setImage:[UIImage imageNamed:@"Sample"]];
        }
        else
        {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                //                            NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[textLine stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                NSData *data = [[NSData alloc] initWithBase64EncodedString:imageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    //   profileImage = [UIImage imageWithData:data];
                    
                  //  [tileImageView setImage: [UIImage imageWithData:data]];
                    
                     [profileButton setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
                    // [navbar addSubview:tileImageView];
                    
                    //                rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithData:data] style:UIBarButtonItemStylePlain target:self action:nil];
                    //                [rightButton setTintColor:[UIColor blackColor]];
                    //                self.navigationItem.rightBarButtonItem = rightButton;
                    
                });
            });
     
        }
  
    }
    else if([item.title  isEqualToString: @"Profile"])
    {
      //  tileImageView.hidden = YES;
        profileButton.hidden = YES;
        // self.navigationItem.title = @"Profile";
    }
    else if([item.title  isEqualToString: @"Notifications"])
    {
        // self.navigationItem.title = @"Notifications";
     //   tileImageView.hidden = YES;
         profileButton.hidden = YES;
    }
  
    else if([item.title  isEqualToString: @"More"]) {
      //   tileImageView.hidden = YES;
         profileButton.hidden = YES;
    }
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
