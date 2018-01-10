//
//  CalenderViewController.h
//  CCG
//
//  Created by sriram angajala on 06/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)calenderButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *eventsTableView;

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end
