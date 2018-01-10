//
//  MessageBoardTableViewCell.h
//  CCG
//
//  Created by sriram angajala on 07/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageBoardTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *messageImageView;
@property (strong, nonatomic) IBOutlet UILabel *messageTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageCategoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageDateLabel;

@end
