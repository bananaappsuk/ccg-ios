//
//  SafeguardingandchildprotectionViewController.h
//  CCG
//
//  Created by sriram angajala on 15/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SafeguardingandchildprotectionViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *safeguardingadultsguideButton;

- (IBAction)safeguardingadultsguideButtonClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *contactsView;

@property (strong, nonatomic) IBOutlet UIButton *safeguardingchildrenandyoungpeopleguideButton;
- (IBAction)safeguardingchildrenandyoungpeopleguideButtonClick:(id)sender;


@end
