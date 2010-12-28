//
//  Flat_10C_ViewController.m
//  Flat 10C 
//
//  Created by Nathan B on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Flat_10C_ViewController.h"
#import "SlideToCancelViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface Flat_10C_ViewController()

- (void) resetView;

@end


@implementation Flat_10C_ViewController

// Synthesize switches
@synthesize hallLightSwitch;
@synthesize fanSwitch;

// Synthesize and configure appSettingsViewController.
@synthesize appSettingsViewController;
- (IASKAppSettingsViewController*)appSettingsViewController {
	if (!appSettingsViewController) {
		appSettingsViewController = [[IASKAppSettingsViewController alloc] initWithNibName:@"IASKAppSettingsView" bundle:nil];
		appSettingsViewController.delegate = self;
	}
	return appSettingsViewController;
}

- (IBAction)showSettingsPush:(id)sender {
	//[viewController setShowCreditsFooter:NO];   // Uncomment to not display InAppSettingsKit credits for creators.
	// But we encourage you no to uncomment. Thank you!
	self.appSettingsViewController.showDoneButton = NO;
	[self.navigationController pushViewController:self.appSettingsViewController animated:YES];
}

- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender {
    [self dismissModalViewControllerAnimated:YES];
	
	// your code here to reconfigure the app for changed settings
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	if (!slideToCancel) {
		// Create the slider
		slideToCancel = [[SlideToCancelViewController alloc] init];
		slideToCancel.delegate = self;
		
		// Position the slider at the bottom of the view.
		CGRect sliderFrame = slideToCancel.view.frame;
		sliderFrame.origin.y = self.view.frame.size.height - slideToCancel.view.bounds.size.height - \
		   self.navigationController.navigationBar.bounds.size.height;
		slideToCancel.view.frame = sliderFrame;
		
		// Add slider to the view
		[self.view addSubview:slideToCancel.view];
	}
	
	// Add spinner to top left of nav controller.
	CGRect frame = CGRectMake(0.0, 0.0, 25.0, 25.0);  	
	UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithFrame:frame];  	
	[loading sizeToFit];
	loading.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);  	
	UIBarButtonItem *statusInd = [[UIBarButtonItem alloc] initWithCustomView:loading];  		
	statusInd.style = UIBarButtonItemStylePlain;
	[self.navigationController.navigationItem setRightBarButtonItem: statusInd animated:YES];
	
	// ------------ Set up the slider -------------
	
	// Start the slider animation
	slideToCancel.enabled = YES;
	
    [super viewDidLoad];
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


// SlideToCancelDelegate method is called when the slider is slid all the way
// to the right
- (void) slideTrigger {
	// Show spinner
	httpLoadingActivity.hidden = NO;
	[httpLoadingActivity startAnimating];
	
	// Fetch user settings.
	NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
	
	NSURL *url = [NSURL URLWithString:[settings stringForKey:@"baseURL"]];
	
	// Send the http form post.
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setPostValue:[settings stringForKey:@"user"] forKey:@"user"];
	[request setPostValue:[settings stringForKey:@"password"] forKey:@"password"];
	[request setPostValue:@"Unlock Door" forKey:@"action"];
	
	[request setDelegate:self];
	[request startAsynchronous];
}

// When hall light switch changes value
- (IBAction)hallLightSwitchDidChange:(id)sender {
	// Show spinner
	httpLoadingActivity.hidden = NO;
	[httpLoadingActivity startAnimating];
	
	// Fetch user settings.
	NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];

	NSURL *url = [NSURL URLWithString:[settings stringForKey:@"baseURL"]];
	
	// Send the http form post.
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setPostValue:[settings stringForKey:@"user"] forKey:@"user"];
	[request setPostValue:[settings stringForKey:@"password"] forKey:@"password"];
	
	if (hallLightSwitch.on) {
		[request setPostValue:@"Turn Hall Light [ON]" forKey:@"action"];
	} else {
		[request setPostValue:@"Turn Hall Light [OFF]" forKey:@"action"];
	}
	
	[request setDelegate:self];
	[request startAsynchronous];
}

// When fan switch changes value
- (IBAction)fanSwitchDidChange:(id)sender {
	// Show spinner
	httpLoadingActivity.hidden = NO;
	[httpLoadingActivity startAnimating];
	
	// Fetch user settings.
	NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
	
	NSURL *url = [NSURL URLWithString:[settings stringForKey:@"baseURL"]];
	
	// Send the http form post.
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setPostValue:[settings stringForKey:@"user"] forKey:@"user"];
	[request setPostValue:[settings stringForKey:@"password"] forKey:@"password"];
	
	if (fanSwitch.on) {
		[request setPostValue:@"Turn Fan [ON]" forKey:@"action"];
	} else {
		[request setPostValue:@"Turn Fan [OFF]" forKey:@"action"];
	}
	
	[request setDelegate:self];
	[request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	httpResultImageView.image = [UIImage imageNamed:@"tick.png"];
	httpResultImageView.alpha = 1.0;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.25];
	[UIView setAnimationDelegate:self];
	httpResultImageView.alpha = 0.0;
	[UIView commitAnimations];
	
	[self resetView];
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
	//NSError *error = [request error];
	httpResultImageView.image = [UIImage imageNamed:@"cross.png"];
	httpResultImageView.alpha = 1.0;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.25];
	[UIView setAnimationDelegate:self];
	httpResultImageView.alpha = 0.0;
	[UIView commitAnimations];
	
	[self resetView];
}

- (void)resetView {
	// Put slider back to start.
	[slideToCancel resetSlider];
	slideToCancel.enabled = YES;
	
	// Hide spinner
	httpLoadingActivity.hidden = YES;
	[httpLoadingActivity stopAnimating];
}

- (void)dealloc {
	[appSettingsViewController release];
	appSettingsViewController = nil;
	[slideToCancel release];
    [super dealloc];
}

@end
