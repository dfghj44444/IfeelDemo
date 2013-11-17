//
//  BubbleView.h
//  Pringles
//
//  Created by hao li on 12-4-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageView.h"
#import "Global.h"

@interface BubbleView : UIView{
    ImageView *bubbleImageView;
    id<ClickedDelegate> viewDelegate;
}
@property(nonatomic,assign) id<ClickedDelegate> viewDelegate;
- (id)initWithFrame1:(CGRect)frame;
- (int) getWidth;
- (int) getHeigth;
- (int) getX;
- (int) getY;
@end
