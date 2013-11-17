//
//  BaseLayer.m
//  LiveByTouch
//
//  Created by hao.li on 11-10-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseLayer.h"


@implementation BaseLayer
@synthesize object;
@synthesize tag;

+ (id)layer{
	
    self = [super layer];
	return self;
}

/* The designated initializer. */

- (id)init{
	
    if (self = [super init]) {
		
    }
	return self;
}

/* This initializer is used by CoreAnimation to create shadow copies of
 * layers, e.g. for use as presentation layers. Subclasses can override
 * this method to copy their instance variables into the presentation
 * layer (subclasses should call the superclass afterwards). Calling this
 * method in any other situation will result in undefined behavior. */

- (id)initWithLayer:(id)layer{
	
    if (self = [super initWithLayer:layer]) {
		
    }
	return self;
}

- (int) getWidth{
	return self.frame.size.width;
}
- (int) getHeigth{
	return self.frame.size.height;
}
- (int) getX{
	return self.frame.origin.x;
}
- (int) getY{
	return self.frame.origin.y;
}
@end
