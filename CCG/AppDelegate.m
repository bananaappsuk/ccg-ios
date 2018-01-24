//
//  AppDelegate.m
//  CCG
//
//  Created by sriram angajala on 04/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HomeScreenViewController.h"
#import "GlobalVariables.h"


@import FirebaseCore;
@import FirebaseInstanceID;
@import FirebaseMessaging;
@import UserNotifications;
@interface AppDelegate ()<FIRMessagingDelegate,UNUserNotificationCenterDelegate,UIApplicationDelegate>

@end

@implementation AppDelegate
{
     NSString *trainingCount,*messageCount,*jobCount,*eventCount,*alertMsg;
}

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
   
    if( SYSTEM_VERSION_LESS_THAN( @"10.0" ) )
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound |    UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];

        if( optind != nil )
        {
            NSLog( @"registerForPushWithOptions:" );
        }
    }
    else
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error)
         {
             if( !error )
             {
                 [[UIApplication sharedApplication] registerForRemoteNotifications];  // required to get the app to do anything at all about push notifications
                 NSLog( @"Push registration success." );

                // print("DEVICE TOKEN = \(deviceToken)")

                 NSLog(@"Device Token");
             }
             else
             {
                 NSLog( @"Push registration FAILED" );
                 NSLog( @"ERROR: %@ - %@", error.localizedFailureReason, error.localizedDescription );
                 NSLog( @"SUGGESTIONS: %@ - %@", error.localizedRecoveryOptions, error.localizedRecoverySuggestion );
             }
         }];
    }
    
    
    

    [FIRApp configure];
    
    _UserLogin =[[NSUserDefaults standardUserDefaults]valueForKey:@"LoginMessage"];
    _UserName = [[NSUserDefaults standardUserDefaults]valueForKey:@"userName"];
    _UserPasswword = [[NSUserDefaults standardUserDefaults]valueForKey:@"userPassword"];
    
    if ([_UserLogin isEqualToString:@"Login successfully completed."] ) {
        [self goToHomePage];
    }
    else
    {
        [self goToLoginPage];
    }
    
    return YES;
}
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"deviceToken: %@", deviceToken);
    NSString * token = [NSString stringWithFormat:@"%@", deviceToken];
    //Format token as you need:
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [self application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:^(UIBackgroundFetchResult result) {
        
        [UIApplication sharedApplication].applicationIconBadgeNumber += [[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] integerValue];
    }];
    
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:123];
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification  withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog( @"for handling push in foreground" );
    // Your code
    NSLog(@"%@", notification.request.content.userInfo); //for getting response payload data
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response  withCompletionHandler:(void (^)())completionHandler   {
    NSLog( @"for handling push in background" );
    // Your code
    NSLog(@"%@", response.notification.request.content.userInfo); //for getting response payload data

}

-(void)goToHomePage
{
   // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //   self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
 //   HomeScreenViewController *secondViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeScreenViewController"];
    // then set your root view controller
  //  self.window.rootViewController = secondViewController;
   
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeScreenViewController"];
    
    
       UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HomeScreenViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeScreenViewController"];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
        window.rootViewController = navigationController;

}
-(void)goToLoginPage
{
//   UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
//
//
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//
//    window.rootViewController = navigationController;
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
// //   self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
//
//    LoginViewController *secondViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
//    // then set your root view controller
//    self.window.rootViewController = secondViewController;
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *homeViewController = [[LoginViewController alloc]init];
    homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    //  if ([[GlobalVariables appVars].logincrdentials isEqualToString:@"Login"]) {
    
    
    
    homeViewController.userNameTF.text = _UserName;
    homeViewController.passwordTF.text = _UserPasswword;
    //   }
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    window.rootViewController = navigationController;
    
}






- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
