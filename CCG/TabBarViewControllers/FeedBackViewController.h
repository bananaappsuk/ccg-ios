//
//  FeedBackViewController.h
//  CCG
//
//  Created by sriram angajala on 09/01/2018.
//  Copyright © 2018 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedBackViewController : UIViewController<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *feedBackTextView;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)submitClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *feedBackTF;

@end
