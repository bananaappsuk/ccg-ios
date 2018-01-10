//
//  PopAlertView.h
//  CCG
//
//  Created by sriram angajala on 02/01/2018.
//  Copyright © 2018 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopAlertView : UIView
@property (strong, nonatomic) IBOutlet UIView *popupAlert;
@property (strong, nonatomic) IBOutlet UILabel *headingLabel;
@property (strong, nonatomic) IBOutlet UITextView *popupTextView;
@property (strong, nonatomic) IBOutlet UIButton *okButton;
- (IBAction)okButtonClick:(id)sender;

@end
