//
//  ViewController.h
//  Child
//
//  Created by Steven Shatz on 10/29/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationTracker.h"
#import "Constants.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *childUserIDTextField;

@property (weak, nonatomic) IBOutlet UILabel *childLatitudeLabel;

@property (weak, nonatomic) IBOutlet UILabel *childLongitudeLabel;

@property (strong, nonatomic) LocationTracker *myLocationTracker;

@end

