//
//  MessageVideoDetailViewController.h
//  CCG
//
//  Created by sriram angajala on 07/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageVideoDetailViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *extraView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIView *videoPlayView;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
- (IBAction)playClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;
- (IBAction)commentClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *commentTF;
@property (strong, nonatomic) IBOutlet UIImageView *messagebubbleImage;
@property (strong, nonatomic) IBOutlet UIButton *FBButton;
- (IBAction)FBButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *messagesButton;
- (IBAction)messageButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *commentTableview;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableConstraint;

@end
