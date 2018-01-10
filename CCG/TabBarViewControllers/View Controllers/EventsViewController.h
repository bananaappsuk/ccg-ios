//
//  EventsViewController.h
//  CCG
//
//  Created by sriram angajala on 04/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *eventsTableView;
@property (strong, nonatomic) IBOutlet UIButton *calenderButton;

- (IBAction)calenderButtonClick:(id)sender;

@end
