//
//  MessageVideoDetailViewController.m
//  CCG
//
//  Created by sriram angajala on 07/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "MessageVideoDetailViewController.h"
#import "ApiClass.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <Social/Social.h>
@interface MessageVideoDetailViewController ()<apiRequestProtocol>
@property(strong, nonatomic)AVPlayer *player;
@property(strong, nonatomic)AVPlayerLayer *playerLayer;
@end

@implementation MessageVideoDetailViewController
{
    NSString *videourl;
    AVPlayerViewController *controller;
    NSString *messageid,*alertMsg,*messageStatus,*userId;
    
    UIAlertController * alert;
    UIAlertAction* yesButton;
    UIAlertAction* noButton;
     NSMutableArray *commentlistArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    commentlistArray= [NSMutableArray new];
    _commentTF.hidden =YES;
    _messagebubbleImage.hidden = YES;
    videourl = [[NSUserDefaults standardUserDefaults] valueForKey:@"videostr"];
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL
                          URLWithString:videourl];
    FBSDKShareButton *shareButton = [[FBSDKShareButton alloc] init];
    shareButton.shareContent = content;
    
    shareButton.frame = CGRectMake(self.extraView.frame.origin.x+self.extraView.frame.size.width-80, 30, self.extraView.frame.size.width-20, 40);
    [self.extraView addSubview:shareButton];
    
    _playButton.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    NSURL *fileURL = [NSURL URLWithString:videourl];
    _player = [AVPlayer playerWithURL:fileURL];
    controller = [[AVPlayerViewController alloc] init];
    
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    
    controller.view.frame = CGRectMake(10,175,self.view.frame.size.width,150);
    controller.player = _player;
    controller.showsPlaybackControls = YES;
    _player.closedCaptionDisplayEnabled = NO;
    [_player pause];
    [_player play];
    
    _dateLabel.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"datestr"];
    _titleLabel.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"messagetitle"];
    _nameLabel.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"traininame"];
    _messageTextView.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"messagedisc"];
    messageid = [[NSUserDefaults standardUserDefaults]valueForKey:@"messageId"];
    messageStatus =  [[NSUserDefaults standardUserDefaults] valueForKey:@"statusmessage"];
   
    userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
    
    if ([messageStatus isEqualToString:@"1"]) {
        
    }
    else
    {
        [self serviceCall];
    }
    
    commentlistArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"commentArr"];
    
    _commentTableview.hidden = YES;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    
//    NSURL *fileURL = [NSURL URLWithString:videourl];
//    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:fileURL];
//    _player = [AVPlayer playerWithPlayerItem:item];
//    CALayer *superlayer = self.videoPlayView.layer;
//    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
//    [_playerLayer setFrame:self.videoPlayView.bounds];
//    _playerLayer.videoGravity = AVLayerVideoGravityResize;
//    [superlayer addSublayer:_playerLayer];
//    [_player seekToTime:kCMTimeZero];
//    _player.closedCaptionDisplayEnabled = NO;
//    [_player pause];
//    [_player play];
    
   
   // _player.externalPlaybackActive = YES;

    // [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backItem.title = @" ";
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:120.0f/255.0f green:120.0f/255.0f blue:130.0f/255.0f alpha:1.0f]}];
    
    //    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor]};
    //
    //    self.navigationItem.title = @"Home";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"]style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(HomeView)];
    [backButton setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = backButton;
    
    //    UIImage *image = [UIImage imageNamed:@"LogoIcon"];
    //    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
 
    self.navigationItem.title = @"Choosen Care Group";
}

-(void)HomeView
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)serviceCall
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        NSString *strURL=[NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/User/MessageRead?UserID=%@&MessageID=%@",userId,messageid];
        
        NSDictionary *messageData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     userId,@"UserID",
                                     messageid,@"MessageID",
                                     
                                     nil];
        
        [apiRequest SendHttpPost:messageData withUrl:strURL withrequestType:RequestTypeMessageReadUpdate];
        
    });
}

-(void)commentService
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        NSString *strURL=[NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/User/MessageComments?UserID=%@&MessageID=%@&Comments=%@",userId,messageid,_commentTF.text];
        
        NSDictionary *commentData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     userId,@"UserID",
                                     messageid,@"MessageID",
                                     _commentTF.text,@"Comments",
                                     nil];
        
        [apiRequest SendHttpPost:commentData withUrl:strURL withrequestType:RequestTypecomment];
        
    });
}

-(void)responseMethod:(id) responseObject withRequestType:(RequestType) requestType;
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if([responseObject isKindOfClass:[NSString class]])
        {
            [self showAlertWith:responseObject];
        }
        else{
            
            
            if(requestType ==RequestTypeMessageReadUpdate)
            {
                NSLog(@"%@",responseObject);
                //    NSDictionary *responseDict = [responseObject valueForKey:@"OMsg"];
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                    
                    
                    
                    
                }
                else
                {
                    alertMsg= [responseObject valueForKey:@"Message"];
                    [self showAlertWith:alertMsg];
                }
            }
            else if (requestType == RequestTypecomment)
            {
                NSLog(@"%@",responseObject);
                //    NSDictionary *responseDict = [responseObject valueForKey:@"OMsg"];
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                    
                    alertMsg= [responseObject valueForKey:@"Message"];
                    [self showAlertWith:alertMsg];
                    _commentTF.text = @"";
                    
                }
                else
                {
                    alertMsg= [responseObject valueForKey:@"Message"];
                    [self showAlertWith:alertMsg];
                }
            }
            else{
                
                alertMsg= [NSMutableString stringWithFormat:@"Server not responding Try After Some Time"];
                [self showAlertWith:alertMsg];
                
            }
            
        }
    });
    
}

-(void)showAlertWith:(NSString *)alertString{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"CCG"  message:alertString preferredStyle:UIAlertControllerStyleAlert];
    //  UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action){}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    alertMsg= [NSMutableString stringWithFormat:@""];
    
}

#pragma mark - Keyboard Methods

- (void)keyboardWasShown:(NSNotification*)notification
{
     _commentTF.hidden =NO;
     _messagebubbleImage.hidden = NO;
     controller.view.frame = CGRectMake(10,-75,self.view.frame.size.width,150);
}

- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    controller.view.frame = CGRectMake(10,175,self.view.frame.size.width,150);
    
       
    [self.commentTF resignFirstResponder];
    
    if (_commentTF.text.length == 0) {
        alertMsg = [NSMutableString stringWithFormat:@"write comment"];
        [self showAlertWith:alertMsg];
         _commentTF.hidden =NO;
        _messagebubbleImage.hidden = NO;
    }
    else
    {
        alert=[UIAlertController
               
               alertControllerWithTitle:@"Comment" message:_commentTF.text preferredStyle:UIAlertControllerStyleAlert];
        
        yesButton = [UIAlertAction
                     actionWithTitle:@"OK"
                     style:UIAlertActionStyleDefault
                     handler:^(UIAlertAction * action)
                     {
                         _commentTF.hidden =YES;
                         _messagebubbleImage.hidden = YES;
                         [self commentService];
                         
                     }];
        noButton = [UIAlertAction
                    actionWithTitle:@"Cancel"
                    style:UIAlertActionStyleDefault
                    handler:^(UIAlertAction * action)
                    {
                        _commentTF.hidden =NO;
                        _messagebubbleImage.hidden = NO;
                        
                    }];
        
        
        [alert addAction:yesButton];
        [alert addAction:noButton];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    // [self.passwordTF resignFirstResponder];
    
}

#pragma mark - tableview delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [commentlistArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    //  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //   cell.separatorInset = UIEdgeInsetsZero;
    cell.textLabel.text = [commentlistArray objectAtIndex:indexPath.row];
    
    //    if (indexPath.row == 4) {
    //        NSDictionary* attributes = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]};
    //        NSAttributedString* attributedString = [[NSAttributedString alloc] initWithString:[arrayuniqueFoodTypesWithoutDuplicates objectAtIndex:indexPath.row] attributes:attributes];
    //        cell.textLabel.attributedText = attributedString;
    //    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)playClick:(id)sender {
   
    
}
- (IBAction)commentClick:(id)sender {
    _commentTF.hidden =NO;
    _messagebubbleImage.hidden = NO;
    self.tableConstraint.constant = 80.0;
    _commentTableview.hidden = YES;
}
- (IBAction)FBButtonClick:(id)sender {
}
- (IBAction)messageButtonClick:(id)sender {
    if (commentlistArray.count> 0) {
        _commentTableview.hidden = NO;
        self.tableConstraint.constant = 10.0;
        _commentTF.hidden =YES;
        _messagebubbleImage.hidden = YES;
    }
    else
    {
        alertMsg= [NSMutableString stringWithFormat:@"No comments available"];
        [self showAlertWith:alertMsg];
        
        _commentTableview.hidden = YES;
    }
}
@end
