//
//  Flat_10C_AppDelegate.h
//  Flat 10C 
//
//  Created by Nathan B on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Flat_10C_ViewController;

@interface Flat_10C_AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Flat_10C_ViewController *viewController;
	IBOutlet UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet Flat_10C_ViewController *viewController;

@end