
//  ApiClass.h
//  Services
//
//  Created by IOS Dev on 15/03/17.
//  Copyright © 2017 IOS Dev. All rights reserved.


#import <Foundation/Foundation.h>

typedef enum{
    RequestTypeLogin = 1,
    RequestTypeRegistration,
    RequestTypeForgotPassword,
    RequestTypeFeedback,
    RequestTypeEditProfile,
    RequestTypeGetProfile,
    RequestTypeChangePassword,
    RequestTypeGetBookings,
    RequestTypeGetMessages,
    RequestTypeGetEvents,
    RequestTypeGetEventsById,
    RequestTypeGetTrainingById,
    RequestTypeGetJobsById,
    RequestTypeGetEventsByDate,
    RequestTypeMessageReadUpdate,
    RequestTypecomment,
    RequestTypeGetJobs,
    RequestTypeGetTraining,
    RequestTypeRegisterTraining,
    RequestTypeRegisterJob,
    RequestTypeRegisterEvent,
    RequestTypeChangeAddress,
    RequestTypePhotoOrder,
    RequestTypeShopDetails,
    RequestTypeMenuItems,
    RequestTypePayment
    }RequestType;

@protocol apiRequestProtocol<NSObject>
-(void)responseMethod:(id) responseObject withRequestType:(RequestType) requestType;

@end

@interface ApiClass : NSObject<NSURLSessionDelegate>

@property (strong,nonatomic) id<apiRequestProtocol> apiDelegate;
@property BOOL isInternetConnectionAvailable;

-(void)SendHttpPost:(id)requestData withUrl:(NSString *)requestUrl withrequestType:(RequestType) requestType;
-(void)SendHttpGetwithUrl:(NSString *)requestUrl withrequestType:(RequestType) requestType;

@end
