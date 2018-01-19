//
//  CalenderViewController.m
//  CCG
//
//  Created by sriram angajala on 06/12/2017.
//  Copyright © 2017 sriram angajala. All rights reserved.
//

#import "CalenderViewController.h"
#import "CalenderTableViewCell.h"
#import "EventsDetailViewController.h"
#import "ApiClass.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "FSCalendar.h"

#define Device_Width [[UIScreen mainScreen] bounds].size.width
#define Device_Height [[UIScreen mainScreen] bounds].size.height

typedef NS_ENUM(NSUInteger, SelectionType) {
    SelectionTypeNone,
    SelectionTypeSingle,
    SelectionTypeLeftBorder,
    SelectionTypeMiddle,
    SelectionTypeRightBorder
};

@interface CalenderViewController ()<FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance,apiRequestProtocol>

//@property (strong, nonatomic) IBOutlet FSCalendar *calender;


@property (weak, nonatomic) FSCalendar *calendar;
@property (assign, nonatomic) SelectionType selectionType;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter1;
@property (strong, nonatomic) NSDateFormatter *dateFormatter2;

@property (strong, nonatomic) NSDictionary *fillSelectionColors;
@property (strong, nonatomic) NSDictionary *fillDefaultColors;
@property (strong, nonatomic) NSDictionary *borderDefaultColors;
@property (strong, nonatomic) NSDictionary *borderSelectionColors;

@property (strong, nonatomic) NSArray *datesWithEvent;
@property (strong, nonatomic) NSArray *datesWithMultipleEvents;

@end

@implementation CalenderViewController
{
    NSString *stringFromArray;
    
    NSMutableArray *dataArray;
    UILabel *lbl;
    
    NSString *alertMsg,*userId;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    

  //  NSArray *datesArray = [[NSUserDefaults standardUserDefaults]valueForKey:@"eventDates"];
    userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
    
    
//    NSMutableDictionary* newDict = [NSMutableDictionary dictionary];
//    for (NSDictionary* oldDict in datesArray) {
//        [newDict addEntriesFromDictionary:oldDict];
//    }
//
//

   
    
//   NSMutableDictionary *calendarColorDict = [[NSMutableDictionary alloc]init];
//    [calendarColorDict setObject:[UIColor redColor] forKey:dictionary];
//
//   self.fillDefaultColors = calendarColorDict;
    
  //  self.datesWithEvent = datesArray;
    
   // [self.datesWithEvent arrayByAddingObjectsFromArray:datesArray];
    
   
    stringFromArray = [_datesWithEvent componentsJoinedByString:@" "];
    
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    self.dateFormatter1 = [[NSDateFormatter alloc] init];
    self.dateFormatter1.dateFormat = @"yyyy/MM/dd";
    
    self.dateFormatter2 = [[NSDateFormatter alloc] init];
   // self.dateFormatter2.dateFormat = @"yyyy-MM-dd";
    self.dateFormatter2.dateFormat = @"dd-MM-yyyy";
 //   [self loadView];
    
  //  _eventsTableView.hidden = YES;
    
   
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self calenderService];
    
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:95.0f/255.0f green:40.0f/255.0f blue:98.0f/255.0f alpha:1.0f]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:95.0f/255.0f green:40.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
    
    self.navigationController.navigationBar.backItem.title = @" ";
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    
    //   [self.navigationController.navigationBar setTitleTextAttributes:
    //    @{NSForegroundColorAttributeName:[UIColor colorWithRed:222.0f/255.0f green:105.0f/255.0f blue:8.0f/255.0f alpha:1.0f]}];
   
//    UIImage *image = [UIImage imageNamed:@"LogoIcon"];
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"Events" style:UIBarButtonItemStylePlain target:self action:nil];
    [backButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = backButton;
    
   
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ListView"] style:UIBarButtonItemStylePlain target:self action:@selector(dissmiss)];
    
    
    self.navigationItem.rightBarButtonItem = rightButton;
    [rightButton setTintColor:[UIColor whiteColor]];
}
-(void)dissmiss
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

//- (void)loadView
//{
//    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    self.view = view;
//
//
//  //  CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 250;
//    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 70, self.view.bounds.size.width-16, 250)];
//    calendar.dataSource = self;
//    calendar.delegate = self;
//    calendar.allowsMultipleSelection = NO;
//    calendar.swipeToChooseGesture.enabled = YES;
//  //  calendar.scrollDirection = FSCalendarScrollDirectionVertical;
//    calendar.backgroundColor = [UIColor whiteColor];
//    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
//    [self.view addSubview:calendar];
//    self.calendar = calendar;
//
//  //  [calendar setCurrentPage:[self.dateFormatter1 dateFromString:@"2015/10/03"] animated:NO];
//
//}

- (NSInteger)getNumberOfDaysInMonth:(int)month and:(int)year
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    // Set your year and month here
    [components setYear:year];
    [components setMonth:month];
    
    NSDate *date = [calendar dateFromComponents:components];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return range.length;
}

-(void)refereshCalendear
{
    
    //    FSCalendar  *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(8, 70, self.view.bounds.size.width-16, 230)];
    //    calendar.backgroundColor = [UIColor whiteColor];//[Constants colorFromHexString:@"FEF9EA"];//[UIColor colorWithRed:255
    //    calendar.dataSource = self;
    //    calendar.delegate = self;
    //    calendar.scrollEnabled = YES;
    //    calendar.userInteractionEnabled = YES;
    //    calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    //    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    //    [self.contentView addSubview:calendar];
    //    self.calendar = calendar;
    //    self.calendar.layer.borderWidth = 1.0f;
    
    NSDate *currentMonth = self.calendar.currentPage;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    
    NSString *month = [[formatter stringFromDate:currentMonth]uppercaseString];
    [formatter setDateFormat:@"YYYY"];
    NSString *year = [formatter stringFromDate:currentMonth];
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(0,67, self.view.frame.size.width, 40)];
    lbl.text  = [NSString stringWithFormat:@"%@ %@",month,year];
    lbl.font=[lbl.font fontWithSize:14];
    UIFontDescriptor * fontD = [lbl.font.fontDescriptor
                                fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold
                                | UIFontDescriptorTraitLooseLeading];
    lbl.font = [UIFont fontWithDescriptor:fontD size:0];
    [lbl setTextColor:[UIColor redColor]];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    
    
    UIView *calView = [[UIView alloc]initWithFrame:CGRectMake(8, 0, CGRectGetWidth(self.view.frame)-16, 35)];
    calView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    calView.layer.borderWidth = 1.0f;
    [calView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:calView];
    //  previousButton.frame = CGRectMake(10, 72, 64, 30);
    //  previousButton.backgroundColor = [UIColor clearColor];
    //  previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
    //  [previousButton setImage:[UIImage imageNamed:@"leftArrow.png"] forState:UIControlStateNormal];
    //  [previousButton addTarget:self action:@selector(sevaCalPreviousClicked:) forControlEvents:UIControlEventTouchUpInside];
    //  [self.contentView addSubview:previousButton];
    [self.contentView addSubview:lbl];
    self.calendar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(8, 0, self.view.bounds.size.width-16, 250)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.appearance.headerMinimumDissolvedAlpha = 0;
    calendar.swipeToChooseGesture.enabled = YES;
    calendar.allowsMultipleSelection = NO;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
    [self.contentView addSubview:calendar];
    self.calendar = calendar;
    
    
    
    
    //  nextButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)-86, 72, 64, 30);
    //  nextButton.backgroundColor = [UIColor clearColor];
    //  nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    //   [nextButton setImage:[UIImage imageNamed:@"rightArrow.png"] forState:UIControlStateNormal];
    //   [nextButton addTarget:self action:@selector(sevaCalNextClicked:) forControlEvents:UIControlEventTouchUpInside];
    //   [self.contentView addSubview:nextButton];
    
    
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    previousButton.frame = CGRectMake(16, 80, 40, 30);
    previousButton.backgroundColor = [UIColor whiteColor];
    previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [previousButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:previousButton];
  //  self.previousButton = previousButton;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)-60, 80, 40, 30);
    nextButton.backgroundColor = [UIColor whiteColor];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton setImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:nextButton];
 //   self.nextButton = nextButton;
    
    
}

-(void)calenderService
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = @"Please wait....";
    
    
    
    ApiClass *apiRequest = [[ApiClass alloc] init];
    apiRequest.apiDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        NSString *urlStr = [NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/Events/GetEventsbyUserID?UserID=%@",userId];
        
        [apiRequest SendHttpGetwithUrl:urlStr withrequestType:RequestTypeGetEvents];
    });
}

//-(void)ServiceCall
//{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//
//    hud.label.text = @"Please wait....";
//
//
//
//    ApiClass *apiRequest = [[ApiClass alloc] init];
//    apiRequest.apiDelegate = self;
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//
//        NSString *urlStr = [NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/Events/GetEventsbyDate?Date=%@",userId];
//
//        [apiRequest SendHttpGetwithUrl:urlStr withrequestType:RequestTypeGetEventsByDate];
//    });
//}
-(void)responseMethod:(id) responseObject withRequestType:(RequestType) requestType;
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // NSMutableDictionary *userinfo;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if([responseObject isKindOfClass:[NSString class]])
        {
            [self showAlertWith:responseObject];
        }
        else{
            
            if(requestType == RequestTypeGetEventsByDate)
            {
                NSLog(@"%@",responseObject);
                NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                
                //    NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseDict valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                    
                    
                    dataArray = [[NSMutableArray alloc]init];
                    dataArray = [responseObject valueForKey:@"EventList"];
                    
                   
                    
                    NSString *eventstr = [dataArray valueForKey:@"Event_StartDate_Format"];
                    
                    [[NSUserDefaults standardUserDefaults]setValue:eventstr forKey:@"eventDates"];
                    [[NSUserDefaults standardUserDefaults]synchronize ];
                    
                    [_eventsTableView reloadData];
                    
                }
                else
                {
                    alertMsg= [responseDict valueForKey:@"Message"];
                    [self showAlertWith:alertMsg];
                    
                }
                
            }
         else  if(requestType == RequestTypeGetEvents)
            {
                NSLog(@"%@",responseObject);
                NSDictionary *responseDict = [responseObject valueForKey:@"Msg"];
                
                //    NSString *respCode =[NSString stringWithFormat:@"%@", [responseObject valueForKey:@"StatusCode"]];
                
                
                NSString *respCode =[NSString stringWithFormat:@"%@", [responseDict valueForKey:@"StatusCode"]];
                if([respCode isEqualToString:@"200"])
                {
                   
                    dataArray = [[NSMutableArray alloc]init];
                    dataArray = [responseObject valueForKey:@"EventList"];
                    
//                    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Event_StartDate_Format" ascending:YES];
//                    [dataArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
                    
                   self.datesWithEvent = [dataArray valueForKey:@"Event_StartDate_Format"];
                    
                    [self refereshCalendear];
                    
                    [_eventsTableView reloadData];
                    
                }
                else
                {
                    alertMsg= [responseDict valueForKey:@"Message"];
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
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    alertMsg= [NSMutableString stringWithFormat:@""];
    
}


#pragma mark - tableview delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    CalenderTableViewCell *cell = (CalenderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [_eventsTableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    }
    //  cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // NSMutableDictionary *sampleDict = [dignosticsNamesArray objectAtIndex:indexPath.row];
    
    //  NSString *imageStr = [[NSString alloc]init];
    //  imageStr = [sampleDict valueForKey:@"centerimage"];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableDictionary *sampleDict = [dataArray objectAtIndex:indexPath.row];
    
    NSString *imageStr = [[NSString alloc]init];
    imageStr = [sampleDict valueForKey:@"Event_Image"];
    
    if([imageStr isEqualToString:@""] || imageStr == nil)
    {
        cell.eventImageView.image = [UIImage imageNamed:@"Sample"];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.eventImageView.image = [UIImage imageWithData:imageData];
                if (cell.eventImageView.image == nil) {
                    cell.eventImageView.image = [UIImage imageNamed:@"Sample"];
                }
                
            });
        });
    }
    
    //    str1=[[DataArray valueForKey:@"Event_StartDate_Format"]objectAtIndex:indexPath.row];
    //    NSArray *tempArray = [str1 componentsSeparatedByString:@"T"];
    //    str1 = [tempArray objectAtIndex:0];
    
    NSString *status = [NSString stringWithFormat:@"%@",[[dataArray valueForKey:@"Register_Status"]objectAtIndex:indexPath.row]];
    
    if ([status isEqualToString:@"1"]) {
        cell.statusImage.hidden = NO;
    }
    else
    {
        cell.statusImage.hidden = YES;
    }
    
    
    cell.eventNameLabel.text = [[dataArray valueForKey:@"Event_Title"]objectAtIndex:indexPath.row];
    cell.eventdayLabel.text = [[dataArray valueForKey:@"Event_Day"]objectAtIndex:indexPath.row];
    
    cell.dateLabel.text = [[dataArray valueForKey:@"Event_StartDate_Format"]objectAtIndex:indexPath.row];
    
    cell.eventCategoryLabel.text = [[dataArray valueForKey:@"Category_Name"]objectAtIndex:indexPath.row];
    
    cell.timeLabel.text = [[dataArray valueForKey:@"Event_StartTime_Format"]objectAtIndex:indexPath.row];
    
    cell.locationLabel.text = [[dataArray valueForKey:@"Event_City"]objectAtIndex:indexPath.row];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    CalenderTableViewCell *cell = (CalenderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.eventdayLabel.text = [[dataArray valueForKey:@"Event_Day"]objectAtIndex:indexPath.row];
    cell.timeLabel.text = [[dataArray valueForKey:@"Event_StartTime_Format"]objectAtIndex:indexPath.row];
    cell.dateLabel.text = [[dataArray valueForKey:@"Event_StartDate_Format"]objectAtIndex:indexPath.row];
    
    NSDictionary *Dict = [dataArray objectAtIndex:indexPath.row];
    
    NSMutableArray *sampleArr = [[dataArray valueForKey:@"Event_Photos"]objectAtIndex:indexPath.row];
    
    //  NSDictionary *sampleDict = [sampleArr objectAtIndex:indexPath.row];
    
    NSMutableArray *eventimageArr;
    eventimageArr = [NSMutableArray new];
    
    for (NSDictionary *itemDict in sampleArr) {
        
        [eventimageArr addObject:[itemDict valueForKey:@"Event_Photo"]];
        
    }
    
    NSString *eventdisc = [Dict valueForKey:@"Event_Description"];
    
    NSString *EventName = [Dict valueForKey:@"Event_Title"];
    
    NSString *eventperson = [Dict valueForKey:@"Event_ContactPersonname"];
    
    NSString *eventcontact = [Dict valueForKey:@"Event_ContactPersonnumber"];
    
    NSString *eventaddress1 = [Dict valueForKey:@"Event_Address1"];
    
    NSString *eventaddress2 = [Dict valueForKey:@"Event_Address2"];
    
    NSString *eventcity = [Dict valueForKey:@"Event_City"];
    
    NSString *eventpostcode = [Dict valueForKey:@"Event_Postcode"];
    NSString *eventId = [NSString stringWithFormat:@"%@",[Dict valueForKey:@"Event_Id"]];
    
    NSString *eventstatus = [NSString stringWithFormat:@"%@",[Dict valueForKey:@"Register_Status"]];
    
    // docIdStr = [Dict valueForKey:@"Doctor_Id"];
    [[NSUserDefaults standardUserDefaults]setValue:cell.dateLabel.text forKey:@"eventDate"];
    [[NSUserDefaults standardUserDefaults]setValue:cell.timeLabel.text forKey:@"eventTime"];
    [[NSUserDefaults standardUserDefaults]setValue:cell.eventdayLabel.text forKey:@"eventDay"];
    
    [[NSUserDefaults standardUserDefaults]setValue:eventdisc forKey:@"eventdisc"];
    [[NSUserDefaults standardUserDefaults]setValue:EventName forKey:@"EventName"];
    [[NSUserDefaults standardUserDefaults]setValue:eventperson forKey:@"eventperson"];
    [[NSUserDefaults standardUserDefaults]setValue:eventcontact forKey:@"eventcontact"];
    
    [[NSUserDefaults standardUserDefaults]setValue:eventaddress1 forKey:@"eventaddress1"];
    [[NSUserDefaults standardUserDefaults]setValue:eventaddress2 forKey:@"eventaddress2"];
    [[NSUserDefaults standardUserDefaults]setValue:eventcity forKey:@"eventcity"];
    [[NSUserDefaults standardUserDefaults]setValue:eventpostcode forKey:@"eventpostcode"];
    [[NSUserDefaults standardUserDefaults]setValue:eventimageArr forKey:@"eventimageArr"];
    [[NSUserDefaults standardUserDefaults]setValue:eventId forKey:@"eventId"];
    [[NSUserDefaults standardUserDefaults]setValue:eventstatus forKey:@"eventstatus"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    EventsDetailViewController *eventVC;
    
    
    eventVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"EventsDetailViewController"];
    
    eventVC.urlStringeventImage = [Dict valueForKey:@"Event_Image"];
    
    [self.navigationController pushViewController:eventVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    // This will create a "invisible" footer
    return 0.01f;
}



#pragma mark - <FSCalendarDataSource>

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    NSString *dateString = [self.dateFormatter2 stringFromDate:date];
    if ([_datesWithEvent containsObject:dateString]) {
        return 1;
    }
    if ([_datesWithMultipleEvents containsObject:dateString]) {
        return 3;
    }
    return 0;
}

#pragma mark - <FSCalendarDelegateAppearance>

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    NSDate *date =
    [[ NSDate alloc ] initWithTimeIntervalSinceNow: (NSTimeInterval) 2 ];
    NSDate *minimumDate =
    [[ NSDate alloc ] initWithTimeIntervalSinceNow: (NSTimeInterval) 0 ];


    return minimumDate;
}

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"should select date %@",[self.dateFormatter2 stringFromDate:date]);
    
    
    NSString *dateString = [self.dateFormatter2 stringFromDate:date];
  if ([_datesWithEvent containsObject:dateString])
   {
       
       MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       
       hud.label.text = @"Please wait....";
       
       ApiClass *apiRequest = [[ApiClass alloc] init];
       apiRequest.apiDelegate = self;
       
       dispatch_async(dispatch_get_main_queue(), ^{
           
           NSString *urlStr = [NSString stringWithFormat:@"http://ccg.bananaappscenter.com/api/Events/GetEventsbyDate?Date=%@&UserID=%@",dateString,userId];
            [apiRequest SendHttpGetwithUrl:urlStr withrequestType:RequestTypeGetEventsByDate];
       });
       
       _eventsTableView.hidden = NO;
       
       return true;
   }
  else
   {
       return false;
   }
    
    return YES;
}
- (void)setSelectionType:(SelectionType)selectionType
{
    if (_selectionType != selectionType) {
        _selectionType = selectionType;
        // [self setNeedsLayout];
    }
}


- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventColorForDate:(NSDate *)date
{
    NSString *dateString = [self.dateFormatter2 stringFromDate:date];
    if ([_datesWithEvent containsObject:dateString]) {
        return [UIColor redColor];
    }
    
    return nil;
}

- (NSArray *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
{
    NSString *dateString = [self.dateFormatter2 stringFromDate:date];
    if ([_datesWithMultipleEvents containsObject:dateString]) {
        return @[[UIColor magentaColor],appearance.eventDefaultColor,[UIColor blackColor]];
    }
    else if ([_datesWithEvent containsObject:dateString])
    {
        return @[[UIColor darkGrayColor]];
    }
    
    return nil;
}

//- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillSelectionColorForDate:(NSDate *)date
//{
//    NSString *key = [self.dateFormatter1 stringFromDate:date];
//    if ([_fillSelectionColors.allKeys containsObject:key]) {
//        return _fillSelectionColors[key];
//    }
//    return appearance.selectionColor;
//}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date
{
    NSString *key = [self.dateFormatter2 stringFromDate:date];
    if ([_fillDefaultColors.allKeys containsObject:key]) {
        return _fillDefaultColors[key];
    }
    else if ([_datesWithEvent containsObject:key])
    {
        return [UIColor purpleColor];
    }
    return nil;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderDefaultColorForDate:(NSDate *)date
{
    NSString *key = [self.dateFormatter1 stringFromDate:date];
    if ([_borderDefaultColors.allKeys containsObject:key]) {
        return _borderDefaultColors[key];
    }
    return appearance.borderDefaultColor;
}

-(UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date
{
    NSString *dateString = [self.dateFormatter2 stringFromDate:date];
    if ([_datesWithMultipleEvents containsObject:dateString]) {
        return [UIColor magentaColor];
    }
    else if ([_datesWithEvent containsObject:dateString])
    {
        return [UIColor whiteColor];
    }

    return nil;
}

//- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderSelectionColorForDate:(NSDate *)date
//{
//    NSString *key = [self.dateFormatter1 stringFromDate:date];
//    if ([_borderSelectionColors.allKeys containsObject:key]) {
//        return _borderSelectionColors[key];
//    }
//    return appearance.borderSelectionColor;
//}

- (CGFloat)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderRadiusForDate:(nonnull NSDate *)date
{
    if ([@[] containsObject:@([self.gregorian component:NSCalendarUnitDay fromDate:date])]) {
        return 0.0;
    }
    return 1.0;
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

- (IBAction)calenderButtonClick:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
