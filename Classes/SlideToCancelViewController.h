//
//  SlideToCancelViewController.h
//  SlideToCancel
//
//  Created by David Lasker on 9/14/09.
//  Copyright (c) 2009. Altos Design, Inc.  
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, 
//  are permitted provided that the following conditions are met:
//
//  * Redistributions of source code must retain the above copyright notice, 
//    this list of conditions and the following disclaimer.
//
//  * Neither the name of Altos Design, Inc. nor the names of its contributors may be used 
//    to endorse or promote products derived from this software without specific prior 
//    written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
//  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
//  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
//  OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
//  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR 
//  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
//  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <UIKit/UIKit.h>

@protocol SlideToCancelDelegate;

@interface SlideToCancelViewController : UIViewController {
	UIImageView *sliderBackground;
	UISlider *slider;
	UILabel *label;
	NSTimer *animationTimer;
	id<SlideToCancelDelegate> delegate;
	BOOL touchIsDown;
	CGFloat gradientLocations[3];
	int animationTimerCount;
}

// Reset slider to 0 (animated)
- (void) resetSlider;

@property (nonatomic, assign) id<SlideToCancelDelegate> delegate;

// This property is set to NO (disabled) on creation.
// The caller must set it to YES to animate the slider.
// It should be set to NO (disabled) when the view is not visible, in order
// to turn off the timer and conserve CPU resources.
@property (nonatomic) BOOL enabled;

// Access the UILabel, e.g. to change text or color
@property (nonatomic, readonly) UILabel *label;

@end

@protocol SlideToCancelDelegate

@required
- (void) slideTrigger;

@end
