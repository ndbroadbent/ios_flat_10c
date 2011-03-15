//
//  DescribeFlat10C.m
//  Flat 10C 
//
//  Created by Nathan B on 28/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UISpec.h"
#import "UIQuery.h"

@interface DescribeFlat10C: NSObject <UISpec> {
}
@end

@implementation DescribeFlat10C

-(void)itShouldBeAbleToTurnOnHallLight {
    UIQuery *app = [UIQuery withApplication];
    [expectThat([app.find.label text:@"Hall Light"]) should].exist;
	
	UISwitch *light = [app.Switch index:1];
	[expectThat(light.on) should:be(NO)];
	light.touch;
	[expectThat(light.on) should:be(YES)];
	light.touch;
	[expectThat(light.on) should:be(NO)];
}
@end

