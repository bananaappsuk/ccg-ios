//
//  TrainingDetailViewController.h
//  CCG
//
//  Created by sriram angajala on 05/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainingDetailViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *imagesScrollView,*contentScrollView;
    UIPageControl *pageControl;
}
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIImageView *trainingImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *daytimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactPhoneLabel;
@property (strong, nonatomic) IBOutlet UIButton *phoneButton;
- (IBAction)phoneClick:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UITextView *discriptionTextView;
@property (strong , nonatomic) NSString *urlStringtrainingImage;
@property (strong , nonatomic) NSString *homestr;
@property (strong, nonatomic) IBOutlet UIView *photoView;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
- (IBAction)registerClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *checkimage;

@end
