//
//  ApiClass.m
//  Services
//
//  Created by IOS Dev on 15/03/17.
//  Copyright © 2017 IOS Dev. All rights reserved.
//

#import "ApiClass.h"
#import <Reachability/Reachability.h>
#import <MBProgressHUD/MBProgressHUD.h>


@implementation ApiClass
@synthesize apiDelegate = _delegate;
#pragma mark
#pragma mark -- checkNetworkStatus

#pragma mark
#pragma mark -- checkNetworkStatus
-(void)checkNetworkStatus{
    Reachability* internetAvailable = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [internetAvailable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:{
            // NSLog(@"The internet is down.");
            _isInternetConnectionAvailable = NO;
            // [self showMessage:@"There is no internet connection for this device"
            //         withTitle:@"Error"];
            break;
        }
        case ReachableViaWiFi:{
            _isInternetConnectionAvailable = YES;
            // NSLog(@"The internet is working via WIFI.");
            break;
        }
        case ReachableViaWWAN:{
            _isInternetConnectionAvailable = YES;
            //NSLog(@"The internet is working via WWAN.");
            break;
        }
    }
}


-(void)SendHttpPost:(id)requestData withUrl:(NSString *)requestUrl withrequestType:(RequestType)requestType
{
    NSError *error;
    
    
    NSString *rechabilityMsg = [[NSString alloc]init];
    
    // Checking network reachability before sending the request.
    
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)
    {
        
        rechabilityMsg = @"There is no internet connection for this device";
        
        [_delegate responseMethod:rechabilityMsg withRequestType:requestType];
    }
    else
    {
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        NSURL *url = [NSURL URLWithString:requestUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:30.0];
        
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [request setHTTPMethod:@"POST"];
        
        NSData *postData = [NSJSONSerialization dataWithJSONObject:requestData options:0 error:&error];
        [request setHTTPBody:postData];
        
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if(error == nil)
            {
                
                if(data == nil)
                {
                    
                }
                else
                {
                    id responceDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                    
                    if ([responceDict isKindOfClass:[NSArray class]])
                    {
                        NSMutableArray *sampleArray = [[NSMutableArray alloc]init];
                        for(NSMutableDictionary *dict in responceDict)
                        {
                            NSDictionary *dictionaryWithOutNull = [self recursiveNullRemove:dict];
                            [sampleArray addObject:dictionaryWithOutNull];
                        }
                        [_delegate responseMethod:sampleArray withRequestType:requestType];
                        
                    }
                    else if ([responceDict isKindOfClass:[NSDictionary class]])
                    {
                        NSMutableDictionary *dict = [responceDict mutableCopy];
                        NSDictionary *dictionaryWithOutNull = [self recursiveNullRemove:dict];
                        [_delegate responseMethod:dictionaryWithOutNull withRequestType:requestType];
                    }
                }
            }
            else
            {
                [_delegate responseMethod:error.localizedDescription withRequestType:requestType];
            }
            
            //wait
            
        }];
        
        [postDataTask resume];
    }
}
-(void)SendHttpGetwithUrl:(NSString *)requestUrl withrequestType:(RequestType)requestType
{
    
    NSString *rechabilityMsg = [[NSString alloc]init];
    [self checkNetworkStatus];
    if (_isInternetConnectionAvailable == NO)
    {
        rechabilityMsg = @"There is no internet connection for this device";
        [_delegate responseMethod:rechabilityMsg withRequestType:requestType];
    }
    
    
    else
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        NSURL *url = [NSURL URLWithString:requestUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:30.0];
        
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        //  [request addValue:@"application/json" forHTTPHeaderField:@""];
        
        [request setHTTPMethod:@"GET"];
        
        
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if(error == nil)
            {
                
                if(data == nil)
                {
                    [_delegate responseMethod:@"No data found" withRequestType:requestType];
                }
                else
                {
                    id responceDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                    
                    if ([responceDict isKindOfClass:[NSArray class]])
                    {
                        NSMutableArray *sampleArray = [[NSMutableArray alloc]init];
                        for(NSMutableDictionary *dict in responceDict)
                        {
                            NSDictionary *dictionaryWithOutNull = [self recursiveNullRemove:dict];
                            [sampleArray addObject:dictionaryWithOutNull];
                        }
                        [_delegate responseMethod:sampleArray withRequestType:requestType];
                        
                    }
                    else if ([responceDict isKindOfClass:[NSDictionary class]])
                    {
                        NSMutableDictionary *dict = [responceDict mutableCopy];
                        NSDictionary *dictionaryWithOutNull = [self recursiveNullRemove:dict];
                        [_delegate responseMethod:dictionaryWithOutNull withRequestType:requestType];
                    }
                }
            }
            else
            {
                [_delegate responseMethod:error.localizedDescription withRequestType:requestType];
            }
            
            
            
        }];
        
        [postDataTask resume];
    }
}
- (NSMutableDictionary *)recursiveNullRemove:(NSMutableDictionary *)dictionaryResponse
{
    NSMutableDictionary *dictionary = [dictionaryResponse mutableCopy];
    NSString *emptyString = @"";
    for (NSString *key in [dictionary allKeys])
    {
        id value = dictionary[key];
        
        if ([value isKindOfClass:[NSDictionary class]])
        {
            dictionary[key] = [self recursiveNullRemove:(NSMutableDictionary*)value];
        }
        else if([value isKindOfClass:[NSArray class]])
        {
            NSMutableArray *valueArray = [value mutableCopy];
            for (int i = 0; i < [value count]; ++i)
            {
                id valueForKey = [value objectAtIndex:i];
                
                if ([valueForKey isKindOfClass:[NSDictionary class]])
                {
                    valueArray[i] = [self recursiveNullRemove:(NSMutableDictionary*)valueForKey];
                }
                else if ([valueForKey isKindOfClass:[NSNull class]])
                {
                    valueArray[i] = emptyString;
                }
            }
            dictionary[key] = valueArray;
        }
        else if ([value isKindOfClass:[NSNull class]])
        {
            dictionary[key] = emptyString;
        }
    }
    return dictionary;
}


@end
