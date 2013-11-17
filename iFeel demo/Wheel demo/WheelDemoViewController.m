//
//  WheelDemoViewController.m
//  Wheel demo
//
//  Created by Wojciech Czekalski on 01.05.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WheelDemoViewController.h"
#import "CDCircleOverlayView.h"
#import "WrtingViewController.h"
#import "RecordViewController.h"
#import "FeedBackViewController.h"
#import "BrowseViewController.h"
@interface WheelDemoViewController ()

@end

@implementation WheelDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CDCircle *circle = [[CDCircle alloc] initWithFrame:CGRectMake(10 , 90, 300, 300) numberOfSegments:10 ringWidth:80.f];
    circle.dataSource = self;
    circle.delegate = self;
    CDCircleOverlayView *overlay = [[CDCircleOverlayView alloc] initWithCircle:circle];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect imageRect = (CGRect){105, 170, 110, 110};
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageRect] ;

 
    UILongPressGestureRecognizer *longGnizer=[[UILongPressGestureRecognizer alloc]initWithTarget:self
                                                            action:@selector(longGo:)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:longGnizer];
    [self.view addSubview:circle];
    //Overlay cannot be subview of a circle because then it would turn around with the circle
    [self.view addSubview:overlay];
    [self.view addSubview:imageView];
    self._ImgView = imageView;
    
    //添加左右按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(testClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"历史" style:UIBarButtonItemStyleBordered target:self action:@selector(OnRecordClick:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.navigationItem setTitle:@"Ifeel 0.12"];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Circle delegate & data source

-(void) circle:(CDCircle *)circle didMoveToSegment:(NSInteger)segment thumb:(CDCircleThumb *)thumb {
    UIImage *image = [UIImage imageNamed: @"xiaochunjie.png"];
    [self._ImgView setImage: image];
    
    NSArray* array = [NSArray arrayWithObjects: @"开心",  @"难过",@"纠结",@"悲伤",@"不忿",@"大怒",@"惊诧",@"忧伤",@"怅然",@"顿悟",nil];
    [self.lblFace setText:[NSString stringWithFormat:@"表情: %i%@", segment, [array objectAtIndex:segment]]];
    
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User did select item" message:[NSString stringWithFormat:@"Segment's tag: %i", segment] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //[alert show];

}

-(UIImage *) circle:(CDCircle *)circle iconForThumbAtRow:(NSInteger)row {
    NSString *fileString = [[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:nil] lastObject];
    
    return [UIImage imageWithContentsOfFile:fileString];
    
}

-(void)longGo:(UILongPressGestureRecognizer *)aGer{
    if (aGer.state==UIGestureRecognizerStateBegan) {
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入你现在的心情"  message:@"wangwang" delegate:nil //cancelButtonTitle:@"OK" otherButtonTitles: nil];
        //[alert show];
        WritingViewController *aViewController = [[WritingViewController alloc] initWithNibName:@"WritingView"   bundle:nil];
        if(self.navigationController == nil)
        {
            NSLog(@"nil");
            //[self presentModalViewController:aViewController animated:TRUE];
        }
        else
        {
            NSLog(@"not nil");
            [[self navigationController]  pushViewController:aViewController animated:true];
        }
    }
}


- (IBAction)testClick:(id)sender {
    FeedBackViewController *aViewController = [[FeedBackViewController alloc] init];
    if(self.navigationController == nil)
    {
        NSLog(@"nil");
        //[self presentModalViewController:aViewController animated:TRUE];
    }
    else
    {
        NSLog(@"not nil");
        [[self navigationController]  pushViewController:aViewController animated:true];
    }
 }

- (IBAction)OnRecordClick:(id)sender {
    BrowseViewController *aViewController = [[BrowseViewController alloc] init];
    //self.feedVc = aViewController;

    if(self.navigationController == nil)
    {
        NSLog(@"nil");
    }
    else
    {
        NSLog(@"not nil");
         [[self navigationController]  pushViewController:aViewController animated:true];
    }
}
@end
