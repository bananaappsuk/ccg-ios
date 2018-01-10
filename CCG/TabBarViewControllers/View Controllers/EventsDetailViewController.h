//
//  EventsDetailViewController.h
//  CCG
//
//  Created by sriram angajala on 04/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsDetailViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *imagesScrollView,*contentScrollView;
    UIPageControl *pageControl;
}
@property (strong, nonatomic) IBOutlet UIImageView *eventImageView;


@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventdateLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactPersonLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactNumberLabel;
@property (strong, nonatomic) IBOutlet UIButton *phoneButton;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (strong , nonatomic) NSString *urlStringeventImage;

@property (strong , nonatomic) NSString *HomeStr;

- (IBAction)phoneClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *buttonCheckimage;


@property (strong, nonatomic) IBOutlet UIView *photoView;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
- (IBAction)registerClick:(id)sender;

@end
