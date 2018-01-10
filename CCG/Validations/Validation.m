//
//  Validation.m
//  TMS
//
//  Created by IOS Dev on 13/10/16.
//  Copyright © 2016 e-Pragati. All rights reserved.
//

#import "Validation.h"

@implementation Validation

-(BOOL)isNameString:(NSString *)name
{
    
    NSString *nameregex=@"[a-zA-Z ]*$";
    NSPredicate *nametest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",nameregex];
    return [nametest evaluateWithObject:name];
}

-(BOOL)isPanCardString:(NSString *)pancard
{
    NSString *usernameregex=@"[A-Z0-9]*$";
    NSPredicate *usernametest=[NSPredicate predicateWithFormat:@"self matches %@",usernameregex];
    return [usernametest evaluateWithObject:pancard];
}

-(BOOL)isPasswordString:(NSString *)password
{
    NSString *passwordregex= @"^(?=.{10,})(?=.*[0-9])(?=.*[a-zA-Z])([@#$%^&=a-zA-Z0-9_-]+)$"; // @"[a-zA-Z0-9]*$";
    NSPredicate *passwordtest=[NSPredicate predicateWithFormat:@"self matches %@",passwordregex];
    return [passwordtest evaluateWithObject:password];
}

-(BOOL)isEmailString:(NSString *)email
{
    NSString *emailregex=@"\\A[A-Za-z0-9]+([-._][a-z0-9]+)*+@[A-Za-z]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailtest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailregex];
    return [emailtest evaluateWithObject:email];
}

-(BOOL)isPhoneNumString:(NSString *)phonenum
{
    NSString *phoneregex=@"[07][0-9]{10}";
    NSPredicate *test=[NSPredicate predicateWithFormat:@"self matches %@",phoneregex];
    return [test evaluateWithObject:phonenum];
}

-(BOOL)isAddressstring:(NSString *)address
{
    NSString *addressregex=@"[A-Za-z0-9._!%@#&*-=$^ ]*$";
    NSPredicate *addresstest=[NSPredicate predicateWithFormat:@"self matches %@",addressregex];
    return [addresstest evaluateWithObject:address];
}

-(BOOL)isPlaceString:(NSString *)place
{
    NSString *placeregex=@"[a-zA-Z]*$";
    NSPredicate *placetest=[NSPredicate predicateWithFormat:@"self matches %@",placeregex];
    return [placetest evaluateWithObject:place];
}

-(BOOL)isZipCodeString:(NSString *)zipcode
{
    
    NSString *zipcoderegex=@"[A-Za-z0-9 ]{6,7}";
    NSPredicate *zipcodetest=[NSPredicate predicateWithFormat:@"self matches %@",zipcoderegex];
    return [zipcodetest evaluateWithObject:zipcode];
}

-(BOOL)isAgeString:(NSString *)age
{
    NSString *ageregex=@"[0-9]{1,3}";
    NSPredicate *agetest=[NSPredicate predicateWithFormat:@"self matches %@",ageregex];
    return [agetest evaluateWithObject:age];
}

-(BOOL)isAmountValueString:(NSString *)amount
{
    
    NSDecimalNumber *decimal =[NSDecimalNumber decimalNumberWithString:amount];
    
    if ([decimal doubleValue] < 1.00) {
        return YES;
    }
    else
    {
        return NO;
    }
    
    
}
-(BOOL)isDateOfBirthString:(NSString *)dob
{
    
    NSString *dateOfBirth = @"22/03/14";
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterShortStyle];
    [format setDateFormat:@"dd/mm/yy"];
    NSDate *validateDOB = [format dateFromString:dateOfBirth];
    if (validateDOB != nil)
        return YES;
    else
        return NO;
}

//-(BOOL)isTextString:(NSString *)text
//{
//    NSString *textregex=@"[a-zA-Z0-9 ]*$";
//    NSPredicate *texttest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",textregex];
//    return [texttest evaluateWithObject:text];
//}


@end
