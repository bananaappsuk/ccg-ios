//
//  GlobalVariables.m

//
//  Created by apple on 1/20/17.
//  Copyright © 2017 vamsi. All rights reserved.
//

#import "GlobalVariables.h"

@implementation GlobalVariables

static GlobalVariables* _sharedMySingleton = nil;
@synthesize Price;


+(GlobalVariables *)appVars {
    static dispatch_once_t pred;
    static GlobalVariables *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[GlobalVariables alloc] init];
        
         shared.loginFrom = [[NSString alloc]init];
         shared.Search = [[NSString alloc]init];
         shared.location = [[NSString alloc]init];
         shared.distance = [[NSString alloc]init];
         shared.skip = [[NSString alloc]init];
         shared.photoFrom = [[NSString alloc]init];
         shared.addressChange = [[NSString alloc]init];
         shared.currentAddress = [[NSString alloc]init];
        shared.referenceHomeScreenVC = [[HomeScreenViewController alloc]init];
        
        shared.checkOutItems = [[NSMutableArray alloc]init];
        
        shared.bucketItems = [[NSMutableArray alloc]initWithCapacity:100];
        //        for (int i=0 ; i<100 ; i++) {
        //            [shared.bucketItems addObject:[NSNumber numberWithInt:0]];
        //        }
        shared.bucketItemNames = [[NSMutableArray alloc]initWithCapacity:100];
        //        for (int i=0 ; i<100 ; i++) {
        //            [shared.bucketItemNames addObject:[NSNumber numberWithInt:0]];
        //        }
        shared.cartItems = [[NSMutableArray alloc]init];
        shared.uniqueShopIdentifier = [NSNumber numberWithInt:1000];
        shared.crosscheckShopIdentifier = 0;
        shared.quantity = 0;
        

    });
    return shared;
}


//+(CustomNoItemAlertView *)presentNoSuchItemAlert  {
//    CustomNoItemAlertView *cniav =  [[[NSBundle mainBundle] loadNibNamed:@"CustomNoItemAlertView" owner:self options:nil] objectAtIndex:0];
//    cniav.frame = [[UIScreen mainScreen] applicationFrame];
//    cniav.displayContentView.layer.cornerRadius = 10.0;
//    cniav.displayContentView.clipsToBounds = YES;
//    return cniav;
//}
+(PopAlertView *)popupAlert  {
    PopAlertView *popup =  [[[NSBundle mainBundle] loadNibNamed:@"PopUpAlert" owner:self options:nil] objectAtIndex:0];
    popup.frame = [[UIScreen mainScreen] applicationFrame];

    popup.okButton.layer.cornerRadius = 20.0;
    popup.okButton.layer.borderColor=[UIColor whiteColor].CGColor;
    popup.okButton.layer.borderWidth=1.0f;

    popup.popupAlert.layer.cornerRadius = 10.0;
    popup.popupAlert.clipsToBounds = YES;
    return popup;
}



//+(CustomAlertView *)presentDidWantToContinueAlert {
//    CustomAlertView *cav =  [[[NSBundle mainBundle] loadNibNamed:@"CustomAlertView" owner:self options:nil] objectAtIndex:0];
//    cav.frame = [[[UIApplication sharedApplication] keyWindow] frame];
//    cav.displayContentView.layer.cornerRadius = 10.0;
//    cav.displayContentView.clipsToBounds = YES;
//    cav.leaveAnywayButton.layer.cornerRadius = 25;
//    cav.leaveAnywayButton.layer.borderColor = [[UIColor orangeColor]CGColor];
//    cav.leaveAnywayButton.layer.borderWidth = 1.0;
//    cav.leaveAnywayButton.clipsToBounds = YES;
//    return cav;
//}

@end
