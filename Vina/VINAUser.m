//
//  VINAUser.m
//  Vina
//
//  Created by Yael Rubinstein on 7/18/16.
//  Copyright © 2016 Yael Rubinstein. All rights reserved.
//

#import "VINAUser.h"

@implementation VINAUser

static NSString * const kUserIDKey = @"kUserIDKey";
static NSString * const kUserFirstNameKey = @"kUserFirstNameKey";
static NSString * const kUserLastNameKey = @"kUserLastNameKey";
static NSString * const kUserEmailKey = @"kUserEmailKey";
static NSString * const kUserPhoneKey = @"kUserPhoneKey";
static NSString * const kUserAgeKey = @"kUserAgeKey";
static NSString * const kUserQuizAnswersKey = @"kUserQuizAnswersKey";
static NSString * const kUserWorkPlaceKey = @"kUserWorkPlaceKey";
static NSString * const kUserSchoolKey = @"kUserSchoolKey";
static NSString * const kUserImagesKey = @"kUserImagesKey";
static NSString * const kUserPreferredDistanceUnitKey = @"kUserPreferredDistanceUnitKey";
static NSString * const kUserPreferredDistanceKey = @"kUserPreferredDistanceKey";


#pragma mark - NSCoding

-(instancetype)initWithCoder:(NSCoder *)coder
{
    if(self) {
        _userID = [coder decodeObjectForKey:kUserIDKey];
        _firstName = [coder decodeObjectForKey:kUserFirstNameKey];
        _lastName = [coder decodeObjectForKey:kUserLastNameKey];
        _email = [coder decodeObjectForKey:kUserEmailKey];
        _phone = [coder decodeObjectForKey:kUserPhoneKey];
        _age = [coder decodeObjectForKey:kUserAgeKey];
        _quizAnswers = [coder decodeObjectForKey:kUserQuizAnswersKey];
        _school = [coder decodeObjectForKey:kUserSchoolKey];
        _workPlace = [coder decodeObjectForKey:kUserWorkPlaceKey];
        _images = [coder decodeObjectForKey:kUserImagesKey];
        _preferredDistanceUnit = [coder decodeObjectForKey:kUserPreferredDistanceUnitKey];
        _maxPreferredDistance = [coder decodeObjectForKey:kUserPreferredDistanceKey];

    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_userID forKey:kUserIDKey];
    [coder encodeObject:_firstName forKey:kUserFirstNameKey];
    [coder encodeObject:_lastName forKey:kUserLastNameKey];
    [coder encodeObject:_email forKey:kUserEmailKey];
    [coder encodeObject:_phone forKey:kUserPhoneKey];
    [coder encodeObject:_age forKey:kUserAgeKey];
    [coder encodeObject:_quizAnswers forKey:kUserQuizAnswersKey];
    [coder encodeObject:_school forKey:kUserSchoolKey];
    [coder encodeObject:_workPlace forKey:kUserWorkPlaceKey];
    [coder encodeObject:_images forKey:kUserImagesKey];
    [coder encodeObject:_preferredDistanceUnit forKey:kUserPreferredDistanceUnitKey];
    [coder encodeObject:_maxPreferredDistance forKey:kUserPreferredDistanceKey];
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"user : %@ %@ (%@),email:%@,preferred max distance:%@ distance units:%@", self.firstName, self.lastName, self.userID, self.email,self.maxPreferredDistance, self.preferredDistanceUnit];
}


@end
