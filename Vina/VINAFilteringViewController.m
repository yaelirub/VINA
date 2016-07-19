//
//  FirstViewController.m
//  Vina
//
//  Created by Yael Rubinstein on 7/18/16.
//  Copyright © 2016 Yael Rubinstein. All rights reserved.
//

#import "VINAFilteringViewController.h"
#import "VINARangeSelectionView.h"
#import "UIFont+VINASettings.h"
#import "UIColor+VINASettings.h"

@interface VINAFilteringViewController ()

@property (nonatomic, weak) IBOutlet UIButton *doneButton;
@property (nonatomic, weak) IBOutlet UIButton *kilometerButton;
@property (nonatomic, weak) IBOutlet UIButton *milesButton;
@property (nonatomic, weak) IBOutlet UIView *milesCheck;
@property (nonatomic, weak) IBOutlet UIView *kilometersCheck;
@property (nonatomic, weak) IBOutlet UILabel *showDistanceInLabel;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) IBOutlet VINARangeSelectionView *rangeSelectionView;

@end

@implementation VINAFilteringViewController

#pragma mark - setup
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupFontsForTitles];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUIForButtons];
    
}

-(void)setupFontsForTitles
{
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor darkGrayColor],
       NSFontAttributeName:[UIFont vinaFontWithSize:24.0]}];
    self.title = NSLocalizedString(@"FILTER", @"Filters navigation title");
    
    self.showDistanceInLabel.font = [UIFont vinaFontWithSize:22.0];
    self.distanceLabel.font = [UIFont vinaFontWithSize:22.0];
    [self.rangeSelectionView bringSubviewToFront:self.distanceLabel];
}

-(void)setupUIForButtons
{
    self.doneButton.layer.borderColor = [UIColor vinaColor].CGColor;
    self.doneButton.layer.borderWidth = 2.0;
    self.milesButton.tag = kVINADistanceUnitMiles;
    self.kilometerButton.tag = kVINADistanceUnitKilometers;
    //TODO: default state. Real state will be from user if set.
    self.kilometersCheck.alpha = 0.0;
    
}

-(void)setUser:(VINAUser *)user
{
    _user = user;
    
    
    //TODO : 1. check if user and user has already set distance preferences
    //       2. update UI if needed
}

#pragma mark - buttons actions

-(IBAction)doneButtonClicked:(id)sender
{
    
}

-(IBAction)distanceUnitClicked:(id)sender
{
    UIView *kilometerCheck = self.kilometersCheck;
    UIView *milesCheck = self.milesCheck;
    switch ([sender tag]) {
        case kVINADistanceUnitMiles:
        {
            [UIView animateWithDuration:0.2 animations:^{
                kilometerCheck.alpha = 0.0;
                milesCheck.alpha = 1.0;
            }];
        }
            break;
        case kVINADistanceUnitKilometers:
        {
            [UIView animateWithDuration:0.3 animations:^{
                milesCheck.alpha = 0.0;
                kilometerCheck.alpha = 1.0;
            }];
            
            
        }
            break;
        default:
            break;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
