//
//  LayerView.m
//  LiveByTouch
//
//  Created by hao.li on 11-10-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LayerView.h"


@implementation LayerView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}


- (void)dealloc {
    [super dealloc];
}


@end
