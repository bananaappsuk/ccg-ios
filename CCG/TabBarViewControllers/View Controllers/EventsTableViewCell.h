//
//  EventsTableViewCell.h
//  CCG
//
//  Created by sriram angajala on 04/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *eventsImageView;
@property (strong, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventCategoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventDayLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventPlaceLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventDateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *registerImage;

@end
