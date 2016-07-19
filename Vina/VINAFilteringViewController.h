//
//  FirstViewController.h
//  Vina
//
//  Created by Yael Rubinstein on 7/18/16.
//  Copyright © 2016 Yael Rubinstein. All rights reserved.
//

@import UIKit;
#import "VINAUser.h"

@interface VINAFilteringViewController : UIViewController

@property (nonatomic, strong) VINAUser *user;
-(void)setUser:(VINAUser *)user;


@end

