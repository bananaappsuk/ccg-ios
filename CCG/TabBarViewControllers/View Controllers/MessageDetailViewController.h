//
//  MessageDetailViewController.h
//  CCG
//
//  Created by sriram angajala on 07/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *extraView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;
@property (strong, nonatomic) IBOutlet UITextField *commentTF;
@property (strong, nonatomic) IBOutlet UIButton *FBButton;
- (IBAction)commentClick:(id)sender;
- (IBAction)FBClick:(id)sender;
@end
