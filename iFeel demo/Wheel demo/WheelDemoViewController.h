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
{}


- (IBAction)testClick:(id)sender;
- (IBAction)OnRecordClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblFace;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *pgRecord;
@property (weak,nonatomic) IBOutlet UIImageView *_ImgView;
@end
