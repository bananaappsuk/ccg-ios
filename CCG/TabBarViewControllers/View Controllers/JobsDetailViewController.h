//
//  JobsDetailViewController.h
//  CCG
//
//  Created by sriram angajala on 05/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobsDetailViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *imagesScrollView,*contentScrollView;
    UIPageControl *pageControl;
}
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UIView *extraView;

@property (strong, nonatomic) IBOutlet UIImageView *jobImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactPhoneLabel;
@property (strong, nonatomic) IBOutlet UIButton *phoneButton;
- (IBAction)phoneClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@property (strong, nonatomic) IBOutlet UIView *photoView;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;

@property (strong , nonatomic) NSString *urlStringjobImage;
@property (strong , nonatomic) NSString *homeStr;
@property (strong , nonatomic) NSString *pageStr;
@property (strong, nonatomic) IBOutlet UIImageView *buttonCheckImage;

- (IBAction)registerClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *imagePopButton;
- (IBAction)imagePopClick:(id)sender;

@end
