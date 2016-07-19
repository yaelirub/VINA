//
//  VINAUser.h
//  Vina
//
//  Created by Yael Rubinstein on 7/18/16.
//  Copyright © 2016 Yael Rubinstein. All rights reserved.
//

@import Foundation;
@import UIKit;
@import CoreLocation;

typedef NS_ENUM(NSInteger,VINADistanceUnit) {
    kVINADistanceUnitMiles = 0,
    kVINADistanceUnitKilometers = 1
};

@interface VINAUser : NSObject <NSCoding>

@property (atomic, copy) NSString *userID;
@property (atomic, copy) NSString *firstName;
@property (atomic, copy) NSString *lastName;
@property (atomic, copy) NSString *email;
@property (atomic, copy) NSString *phone;
@property (atomic, strong) NSNumber *age;
@property (atomic, copy) NSArray *quizAnswers;
@property (atomic, strong) NSString *workPlace;
@property (atomic, copy) NSString  *school;
@property (atomic, copy) NSArray  *images;
@property (atomic) NSNumber *preferredDistanceUnit;
@property (atomic, copy) NSNumber *maxPreferredDistance;

@end
