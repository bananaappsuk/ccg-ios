//
//  GlobalVariables.h

//
//  Created by apple on 1/20/17.
//  Copyright © 2017 vamsi. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "CustomNoItemAlertView.h"
//#import "CustomAlertView.h"
#import "HomeScreenViewController.h"
#import "PopAlertView.h"


@interface GlobalVariables : NSObject
@property (nonatomic, strong) NSString *totalPrice_Value;

@property (strong , nonatomic) NSString *priceValue;

@property(nonatomic, strong) NSString *selectedQuantity;
@property(nonatomic, strong)  NSString *Price ;


@property(nonatomic, strong)  NSArray *cartItemsArray ;

@property (nonatomic, retain) NSString *loginFrom;
@property (nonatomic, retain) NSString *EventRegister;
@property (nonatomic, retain) NSString *JobRegister;
@property (nonatomic, retain) NSString *TrainingRegister;
@property (nonatomic, retain) NSString *photoFrom;
@property (nonatomic, retain) NSString *Search;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *distance;
@property (nonatomic, retain) NSString *skip;

@property (nonatomic, retain) NSString *addressChange;
@property (nonatomic, retain) NSString *currentAddress;
@property (nonatomic,strong) HomeScreenViewController *referenceHomeScreenVC;

// variables for items in the basket

@property(nonatomic, strong)  NSMutableArray *bucketItems ;
@property(nonatomic, strong)  NSMutableArray *bucketItemNames;
@property(nonatomic, strong)  NSNumber *uniqueShopIdentifier ;
@property(nonatomic, strong)  NSNumber *crosscheckShopIdentifier ;
@property(nonatomic)  int quantity ;

@property(nonatomic, strong)  NSMutableArray *cartItems;

@property(nonatomic, strong)  NSMutableArray *checkOutItems;



@property int itemQuantity;
@property long itemCost;
+(GlobalVariables*) appVars;
//+ (CustomNoItemAlertView *) presentNoSuchItemAlert ;
//+ (CustomAlertView *) presentDidWantToContinueAlert ;
+ (PopAlertView *) popupAlert ;

@end
