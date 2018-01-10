//
//  TrainingTableViewCell.h
//  CCG
//
//  Created by sriram angajala on 05/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainingTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *trainingImageView;
@property (strong, nonatomic) IBOutlet UILabel *trainingNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *trainingCategoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayLabel;

@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *registerImage;


@end
