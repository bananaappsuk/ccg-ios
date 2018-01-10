//
//  JobsViewController.h
//  CCG
//
//  Created by sriram angajala on 05/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *jobsTableView;

@end
