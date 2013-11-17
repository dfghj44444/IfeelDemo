    //
//  AlertImageView.m
//  LiveByTouch
//
//  Created by hao.li on 11-8-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlertImageView.h"

#import "Global.h"
#import "ImageView.h"
#import <QuartzCore/QuartzCore.h> 
@implementation AlertImageView

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = BLACKBGCOLOR;
}
-(void) setImage:(UIImage *)oj{
	[oj retain];
	[image release];
	image = oj;
	
	btnMark = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	//btnMark.alpha=0.01;
	[btnMark addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btnMark];
	imageView = [[ImageView alloc] initWithImage:image];
	int width = 240;
	int height = width/image.size.width * image.size.height;
	imageView.frame = CGRectMake((320-width)/2, (480-height)/2, width, height);
	[self.view addSubview:imageView];
	imageView.hidden = YES;
	//将图层的边框设置为圆脚 
    imageView.layer.cornerRadius = 8; 
	imageView.layer.masksToBounds = YES; 
    //给图层添加一个有色边框 
	imageView.layer.borderWidth = 8; 
	imageView.layer.borderColor = [[UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:0.5] CGColor]; 
}

-(void) setImageUrl:(NSString*)url{
	if (url) {
		alertProgress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-20)/2, (self.view.frame.size.height-20)/2, 20, 20)];
		alertProgress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
		[self.view addSubview:alertProgress];
		[alertProgress startAnimating];
	}	
	downLoad = [[IconDownloader alloc] init];
	downLoad.delegate = self;
	[downLoad startDownload:url Type:DocumentsReview];
}
#pragma mark IconDownloaderDelegate methods
-(void) appImageDidLoad:(Document)docType{
	[alertProgress stopAnimating];
	[alertProgress removeFromSuperview];
	[self setImage:downLoad.appIcon];
	[self showImage];
	[downLoad release];
	downLoad = nil;
}

-(void)hideView{
	imageView.hidden = YES;
	[imageView removeFromSuperview];
	[self.view removeFromSuperview];
	[self release];
}
-(void) showImage{
	imageView.hidden = NO;
	CAKeyframeAnimation * animation; 
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"]; 
    animation.duration = 0.8; 
    //animation.delegate = self;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
	
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    //[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]]; 
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]]; 
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]]; 
	
    animation.values = values;
	animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [imageView.layer addAnimation:animation forKey:nil];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[btnMark release];
	btnMark = nil;
	[image release];
	image = nil;
	[imageView release];
	imageView = nil;
	
	[alertProgress release];
	alertProgress = nil;
    [super dealloc];
}


@end
