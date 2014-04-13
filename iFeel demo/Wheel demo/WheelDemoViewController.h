//
//  WheelDemoViewController.h
//  Wheel demo
//
//  Created by Wojciech Czekalski on 01.05.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDCircle.h"
#import "WrtingViewController.h"
#import "FeedBackViewController.h"
@interface WheelDemoViewController : UIViewController <CDCircleDelegate, CDCircleDataSource>
{
    int _curSegment;
}

+ (void)AddRecord: (int)nSegment withString: (NSString*)strContent;

- (IBAction)OnRecordClick:(id)sender;

//@property (weak, nonatomic) IBOutlet UILabel *_lblFace2;
@property (weak, nonatomic) IBOutlet UILabel *_lblFace3;
@property (weak, nonatomic) IBOutlet UIImageView *_ImgView3;

//@property (weak,nonatomic) IBOutlet UIImageView *_ImgView2;
@end
