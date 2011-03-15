//
//  main.m
//  Flat 10C 
//
//  Created by Nathan B on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifdef RUN_SPECS
#import "UISpec.h"
#endif

int main(int argc, char *argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	#ifdef RUN_SPECS
		[UISpec runSpecsAfterDelay:3];
	#endif
	
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
