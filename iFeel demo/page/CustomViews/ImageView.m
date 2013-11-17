//
//  ImageView.m
//  LiveByTouch
//
//  Created by hao.li on 11-7-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ImageView.h"
#import "AlertImageView.h"
#import "Global.h"


//static CGRect imageRect = {{0, 0}, {80, 60}};
//static const CGPoint imagePoint = {0, 0};

@implementation ImageView
@dynamic  imgDelegate;
@synthesize record,object,recordId;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
	
    return self;
}

- (id)initWithImage:(UIImage *)image ImageType:(ImageType)tp{
	self = [super initWithImage:image];
	if (self) {
		if (tp == ImageDefault) {
			
		}
		if (tp == ImageCorner) {
//			self.layer.cornerRadius = 5;
//			self.layer.masksToBounds = YES;
//			self.opaque = NO;
		}
		if (tp == ImageShadow) {
//			self.layer.shadowColor = [UIColor blackColor].CGColor;
//			self.layer.shadowOffset = CGSizeMake(1, 1);
//			self.layer.shadowOpacity = 0.5; 
//			self.layer.shadowRadius = 1.0;
		}
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame Path:(NSString*)imagepath ImageType:(ImageType)tp
{
	UIImage *img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imagepath ofType:nil]];
	//self = [super initWithImage:img];
	self = [self initWithImage:img ImageType:tp];
    if (self) {
        // Initialization code.
		if(img)
		{
			if (frame.size.width == 0) {
				frame.size.width = img.size.width;
			}
			if (frame.size.height == 0) {
				frame.size.height = img.size.height;
			}
			self.frame = frame;
		}
    }
	//imageRect.size = CGSizeMake(img.size.width, img.size.height);
	return self;
}
- (id)initWithPath:(NSString*)imagepath ImageType:(ImageType)tp
{
	UIImage *img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imagepath ofType:nil]];
	//self = [super initWithImage:img];
	self = [self initWithImage:img ImageType:tp];
    if (self) {
        // Initialization code.
		if(img)
		{
			CGRect frame = CGRectMake(0, 0, img.size.width, img.size.height);
			self.frame = frame;
		}
    }
	//imageRect.size = CGSizeMake(img.size.width, img.size.height);
	return self;
}


-(void) setParentView:(UIView *)view{
	[view retain];
	[parentView release];
	parentView = view;
}

//显示image在view上
- (void) displayImage:(UIView*)v IconURL:(NSString*)url ImageType:(ImageType)tp CacheTp:(CacheType)cp SaveType:(Document)docType{
	
	//NSLog(@"路径：%@",url);
	if (url==nil||[url isEqualToString:@""]==YES) {
		return;
	}
	[v retain];
	[temp release];
	temp = v;
	
	if (url) {
		progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((temp.frame.size.width-20)/2, (temp.frame.size.height-20)/2, 20, 20)];
		progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
		[temp addSubview:progress];
		[progress startAnimating];
	}
	
//	//如果该图片存在缓存里面 直接显示出来
//	if([[NSFileManager defaultManager] fileExistsAtPath:[CACHES stringByAppendingPathComponent:[[Global GetInstance] getSubFilePath:url]]])
//	{
//		UIImage *img = [[Global GetInstance] getDiskImage:url];
//		UIImageView *vv = [[UIImageView alloc] initWithImage:img];
//	}
//	//这是永远不变的数据
//	if (cp == CacheForever&&[[NSFileManager defaultManager] fileExistsAtPath:[CACHES stringByAppendingPathComponent:[[Global GetInstance] getSubFilePath:url]]]) {
//		return;
//	}
//	//这是改变的数据 需要重新加载
//	if (cp == CacheChange) {
//		
//	}
	
	[imageUrl release];
	[url retain];
	imageUrl = url;
	[v retain];
	[temp release];
	temp = v;
	imageType = tp;
	downLoad = [[IconDownloader alloc] init];
	downLoad.delegate = self;
	
//	if (docType == DocumentsUser) {
//		imageRect.size = CGSizeMake(50, 50);
//	}
//	if (docType == DocumentsTyz) {
//		imageRect.size = CGSizeMake(80, 60);
//	}
//	if (docType == DocumentsShanghu) {
//		imageRect.size = CGSizeMake(80, 60);
//	}
//	if (docType == DocumentsReview) {
//		imageRect.size = CGSizeMake(80, 60);
//	}
//	if (docType == DocumentsActive) {
//		imageRect.size = CGSizeMake(80, 60);
//	}
	
	[downLoad startDownload:url Type:docType];
}

#pragma mark IconDownloaderDelegate methods
- (void)appImageDidLoad:(Document)docType{
	[progress stopAnimating];
	[progress removeFromSuperview];
	NSArray *subviews = [[NSArray alloc] initWithArray:temp.subviews];
	for (UIView *subview in subviews) {
		[subview removeFromSuperview];
	}
	[subviews release];
	
	
	CALayer *vv = [CALayer layer];
	vv.contentsGravity = kCAGravityResizeAspect;
	vv.contents = (id)downLoad.appIcon.CGImage;
	
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
		vv.contentsScale = [[UIScreen mainScreen] scale];
	}
#endif
	
	//UIImageView *vv = [[[UIImageView alloc] initWithImage:downLoad.appIcon] autorelease];
	CGSize imageSize = downLoad.appIcon.size;
	
	CGRect frame = temp.frame;
//	if (temp.tag == 9000) {
//		float width = imageSize.width * temp.frame.size.height/temp.frame.size.width;
//		float height = imageSize.height * temp.frame.size.width/temp.frame.size.height;
//		frame.size.width = width;
//		frame.size.height = height;
//		temp.frame = frame;
//	}
	//大的图集图片
	if (imageType == ImageSizeFirst) {
		frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
		UIImageView *pview = (UIImageView*)temp;
		pview.image = nil;
		temp.frame = CGRectMake((320-imageSize.width)/2, (460-imageSize.height)/2, imageSize.width, imageSize.height);
		vv.frame = frame;
	}
	
	//压缩图片
	else {
		if (docType == DocumentsUser) {
			vv.frame =CGRectMake(0, 0, frame.size.width, frame.size.height);
		}
		else if (docType == DocumentsTyz) {
			vv.frame =CGRectMake(0, 0, frame.size.width, frame.size.height);
		}

		else {
			
			//vv.contentMode=UIViewContentModeScaleAspectFit;
			
			frame.origin.x = 0;
			frame.origin.y = 0;
			//宽度不够 高度太高
			if (temp.frame.size.width/temp.frame.size.height>imageSize.width/imageSize.height) {
				frame.size.height = temp.frame.size.height;//那就以高度为主
				frame.size.width = (temp.frame.size.height*imageSize.width)/imageSize.height;//那就压缩宽度吧
			}
			//宽度太宽 高度不够
			else if (temp.frame.size.width/temp.frame.size.height<imageSize.width/imageSize.height) {
				frame.size.width = temp.frame.size.width;//宽度为主
				frame.size.height = (temp.frame.size.width*imageSize.height)/imageSize.width;//压缩宽度
			}else {
				frame.size.width = temp.frame.size.width;
				frame.size.height = temp.frame.size.height;
			}
			vv.frame = frame;
		}
	}

	
	if (imageType == ImageDefault) {
		
	}
	if (imageType == ImageCorner) {
//		vv.layer.cornerRadius = 5;
//		vv.layer.masksToBounds = YES;
//		vv.opaque = NO;
	}
	if (imageType == ImageShadow) {
//		vv.layer.shadowColor = [UIColor blackColor].CGColor;
//		vv.layer.shadowOffset = CGSizeMake(1, 1);
//		vv.layer.shadowOpacity = 0.5; 
//		vv.layer.shadowRadius = 1.0;

		//不用剪掉边
		if (docType == DocumentsUser) {
			frame.size.height = frame.size.height - 4;
			frame.size.width = frame.size.width - 4;
			frame.origin.x = (temp.frame.size.width - frame.size.width)/2;
			frame.origin.y = (temp.frame.size.height - frame.size.height)/2;
			
			vv.frame = frame;
		}
		else {
			frame.size.height = frame.size.height - 4;
			frame.size.width = frame.size.width - 4;
			frame.origin.x = (temp.frame.size.width - frame.size.width)/2;
			frame.origin.y = (temp.frame.size.height - frame.size.height)/2;
			
			vv.frame = frame;
		}

		NSString *path = @"";
		if (temp.frame.size.width<60) {
			path = @"cell_image_background50_50.png";
		}
		else {
			path = @"cell_image_background.png";//80*60
		}
		
		UIImage *img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:nil]];
		ImageView *tp = (ImageView*)temp;
		tp.image = img;
		
	}
	if (imageType == ImageCustomBg1) {
//		frame.origin.x = 3;
//		frame.origin.y = 3;
		frame.size.height = frame.size.height - 4;
		frame.size.width = frame.size.width - 4;
		frame.origin.x = (temp.frame.size.width - frame.size.width)/2;
		frame.origin.y = (temp.frame.size.height - frame.size.height)/2;
		vv.frame = frame;
		UIImage *img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"timeLine_pic_mask.png" ofType:nil]];
		ImageView *tp = (ImageView*)temp;
		tp.image = img;
		[temp setUserInteractionEnabled:YES];
	}

	[[temp layer] addSublayer:vv];
	[downLoad release];
	downLoad = nil;
}

-(void) setImgDelegate:(id <ClickedDelegate>)delegate{
	super.userInteractionEnabled = YES;
	imgDelegate = delegate;
}

-(void) setRecord:(NSString *)sid{
	if (record != sid) {
		[sid retain];
		[record release];
		record = sid;
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *aTouch = [touches anyObject];
	
	if (aTouch.tapCount == 1) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];		
		
    }
	
} 


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *theTouch = [touches anyObject];
	
	if(theTouch.tapCount == 1 || theTouch.tapCount==0) //主界面只接受单击
	{
		[NSObject cancelPreviousPerformRequestsWithTarget:self];
		
		CGPoint touchPoint = [theTouch locationInView:temp];	
		//点击父容器放大
		if (touchPoint.x>0&&touchPoint.y>0&&temp.tag == 9000) {
			AlertImageView *alert = [[AlertImageView alloc] init];
			//ImageView *iv = [[temp subviews] objectAtIndex:0];
			//[alert setImage:iv.image];
			ImageView *iv = (ImageView*)temp;
			[alert setImageUrl:iv.record];
			[parentView addSubview:alert.view];
			[alert showImage];
		}
		//抛出单击事件
		else {
			touchPoint = [theTouch locationInView:self];
			if (touchPoint.x>0&&touchPoint.y>0) {
				[imgDelegate someLikeButton:self];
			}
		}
	}
}

#pragma mark IconDownloaderDelegate end

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
- (void) setPosition:(CGPoint)point{
	self.frame = CGRectMake(point.x, point.y, [self getWidth], [self getHeigth]);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	
	[parentView release];
	parentView = nil;
	[temp release];
	temp = nil;
	[progress release];
	progress = nil;
	[imageUrl release];
	imageUrl = nil;
	[record release];
	record = nil;
	
    [super dealloc];
}


@end
