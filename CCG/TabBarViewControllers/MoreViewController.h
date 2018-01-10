//
//  MoreViewController.h
//  CCG
//
//  Created by sriram angajala on 04/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *moreTableView;
@property (strong, nonatomic) IBOutlet UIButton *aboutUsButton;

@property (strong, nonatomic) IBOutlet UIButton *contactUsButton;

@property (strong, nonatomic) IBOutlet UIButton *feedBackButton;
@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
- (IBAction)aboutusClick:(id)sender;

- (IBAction)contactusClick:(id)sender;

- (IBAction)feedbackClick:(id)sender;
- (IBAction)logoutClick:(id)sender;

@end
