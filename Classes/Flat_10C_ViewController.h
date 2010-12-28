//
//  Flat_10C_ViewController.h
//  Flat 10C 
//
//  Created by Nathan B on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SlideToCancelViewController.h"
#import "IASKAppSettingsViewController.h"

@interface Flat_10C_ViewController : UIViewController<SlideToCancelDelegate, IASKSettingsDelegate> {
	SlideToCancelViewController *slideToCancel;
	IASKAppSettingsViewController *appSettingsViewController;
	IBOutlet UIActivityIndicatorView *httpLoadingActivity;
	IBOutlet UIImageView *httpResultImageView;
	IBOutlet UISwitch *hallLightSwitch;
	IBOutlet UISwitch *fanSwitch;
}

@property (nonatomic, retain) UISwitch *hallLightSwitch;  
@property (nonatomic, retain) UISwitch *fanSwitch;  

@property (nonatomic, retain) IASKAppSettingsViewController *appSettingsViewController;

- (IBAction)showSettingsPush:(id)sender;
- (IBAction)hallLightSwitchDidChange:(id)sender;
- (IBAction)fanSwitchDidChange:(id)sender;

@end
