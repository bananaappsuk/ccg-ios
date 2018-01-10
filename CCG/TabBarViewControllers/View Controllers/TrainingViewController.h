//
//  TrainingViewController.h
//  CCG
//
//  Created by sriram angajala on 05/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *trainingTableView;

@end
