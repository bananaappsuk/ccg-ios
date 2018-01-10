//
//  MessageImageViewController.h
//  CCG
//
//  Created by sriram angajala on 12/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageImageViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *extraView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIButton *FBButton;
@property (strong , nonatomic) NSString *urlStringmessageImage;

- (IBAction)FBButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *messgeImageView;
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;
- (IBAction)commentClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *commentTF;
@property (strong, nonatomic) IBOutlet UIImageView *messagebubbleImage;
@property (strong, nonatomic) IBOutlet UIButton *seeallmessagesButton;
- (IBAction)messageButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *commentTableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableContraint;

@end
