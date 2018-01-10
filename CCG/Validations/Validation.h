//
//  Validation.h
//  TMS
//
//  Created by IOS Dev on 13/10/16.
//  Copyright © 2016 e-Pragati. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validation : NSObject



-(BOOL)isNameString:(NSString *) name;

-(BOOL)isPanCardString:(NSString *) pancard;

-(BOOL)isPasswordString:(NSString *) password;

-(BOOL)isEmailString:(NSString *) email;

-(BOOL)isAddressstring:(NSString *) address;

-(BOOL)isPlaceString:(NSString *) place;

-(BOOL)isZipCodeString:(NSString *) zipcode;

-(BOOL)isPhoneNumString:(NSString *) phonenum;

-(BOOL)isAmountValueString:(NSString *) amount;

-(BOOL)isDateOfBirthString:(NSString *) dob;

-(BOOL)isAgeString:(NSString *)age;

// -(BOOL)isTextString:(NSString *)text;


@end
