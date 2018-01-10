//
//  HomeViewController.h
//  CCG
//
//  Created by sriram angajala on 04/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsViewController.h"

@protocol RefreshHomeScreenDelegate <NSObject>
@required
-(void) refreshData ;
@end
@interface HomeViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) id <RefreshHomeScreenDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UICollectionView *homeCollectionView;
@property (strong, nonatomic) IBOutlet UIView *extraView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *bookingLabel;

@property (strong, nonatomic) IBOutlet UITableView *bookingTableview;
@property (strong, nonatomic) IBOutlet UIButton *safeGuardButton;
@property (strong, nonatomic) IBOutlet UIButton *childProtectionButton;
@property (strong, nonatomic) IBOutlet UIButton *jobsButton;
@property (strong, nonatomic) IBOutlet UIButton *eventsButton;
- (IBAction)safeGuardButtonClick:(id)sender;
- (IBAction)childProtectionButtonClick:(id)sender;
- (IBAction)jobsClick:(id)sender;
- (IBAction)eventsClick:(id)sender;



@end
