//
//  CustomImageView.m
//  LiveByTouch
//
//  Created by hao.li on 11-10-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomImageView.h"
#import "AlertImageView.h"
#import "BaseCellView.h"
#import "BaseCell.h"

@interface CustomImageView ()

-(void) showImage;

@end


static CGRect myframe;

@implementation CustomImageView
@synthesize image;
@synthesize object;
@synthesize tag;
@synthesize imageUrl;
@synthesize imgDelegate;
@synthesize baseEntity;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame :(Document)docType {
    
    self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = [UIColor clearColor];
		type = docType;
    }
    return self;
}

-(void) setFrame:(CGRect)frame{
    [super setFrame:frame];
    myframe = frame;
}

-(void) setImgDelegate:(id <ClickedDelegate>)value{
	super.userInteractionEnabled = YES;
	imgDelegate = value;
}

-(void) setImage:(UIImage *)value{
	if (image!=value) {
		[image release];
		image = [value retain];
		//image = [[Global resizeImage:image toWidth:image.size.width height:image.size.height] retain];
	}
	//[self setNeedsDisplay];
    [self showImage];
}

-(void) setImageUrl:(NSString *)value{
	if (imageUrl != value) {
		[imageUrl release];
		imageUrl = value;//[[BASE stringByAppendingFormat:@"%@",value] copy];
        NSLog(@"-------------------------------------%@",imageUrl);
	}
	
	if (progress != nil) {
		return;
	}
	if (imageUrl) {
		progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.frame.size.width-20)/2, (self.frame.size.height-20)/2, 20, 20)];
		progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
		[self addSubview:progress];
		[progress startAnimating];
	}
	
	downLoad = [[IconDownloader alloc] init];
	downLoad.delegate = self;
	UIImage *img = [[Global GetInstance] getDiskImage:imageUrl Type:type];
	if (img) {
		[downLoad startDownload:imageUrl Type:type];
	}
	else {
		BaseCellView *pt = (BaseCellView*)super.superview;
		if ([pt isKindOfClass:[BaseCellView class]]) {
			[downLoad startDownload:imageUrl Type:type Row:pt.row];
		}
		else {
			[downLoad startDownload:imageUrl Type:type];
		}
	}
}
-(void) setBaseEntity:(BaseEntity *)value{
	baseEntity = value;
}

#pragma mark IconDownloaderDelegate methods
- (void)appImageDidLoad:(Document)docType{
	[progress stopAnimating];
	[progress removeFromSuperview];
	progress = nil;
	
	[image release];
	image = [downLoad.appIcon retain];
	//image = [[Global resizeImage:image toWidth:image.size.width height:image.size.height] retain];
	[downLoad release];
	downLoad = nil;
	
	//[self setNeedsDisplay];
    [self showImage];
}

- (void)appImageDidLoad:(Document)docType :(int)row{
	[progress stopAnimating];
	[progress removeFromSuperview];
	progress = nil;
	
	[image release];
	image = [downLoad.appIcon retain];
	//image = [[Global resizeImage:image toWidth:image.size.width height:image.size.height] retain];
	[downLoad release];
	downLoad = nil;
	
	
	BOOL con = NO;
	if ([self.superview isKindOfClass:[BaseCellView class]]) {
		
		BaseCellView *pt = (BaseCellView*)super.superview;
		NSArray *visiblePaths = [[pt.target getTableView] indexPathsForVisibleRows];
		for (NSIndexPath *indexPath in visiblePaths)
		{
			if (indexPath.row == row) {
				con = YES;
				break;
			}
		}
	}
	if ([imageUrl isEqualToString:@""]||imageUrl==nil) {
		con = YES;
	}
	if (!con) {
		return;
	}
	//[self setNeedsDisplay];
    [self showImage];
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

- (void) setPosition:(CGPoint)point{
	self.frame = CGRectMake(point.x, point.y, [self getWidth], [self getHeigth]);
}

-(void) showImage{
    
//    self.contentMode=UIViewContentModeScaleAspectFit;
//    super.image = image;
//    return;
    
//    CGRect frame = CGRectZero;
//    
//    CGRect rect = CGRectZero;
//    if (type == DocumentsUser) {
//        rect = CGRectMake(0, 0, 50, 50);
//    }
//    if (type == DocumentsShanghu || type == DocumentsActive || type == DocumentsTyz) {
//        rect = CGRectMake(0, 0, 80, 60);
//    }
//    if (type == DocumentsReview) {
//        rect = CGRectMake(0, 0, 96, 76);
//    }
//    
//    
//	if (!isBg) {
//		frame.size.height = rect.size.height - 4;
//		frame.size.width = rect.size.width - 4;
//		frame.origin.x = myframe.origin.x + 2;
//		frame.origin.y = myframe.origin.y + 2;
//	}
//    else{
//        frame = myframe;
//    }
//	else {
//        //		if (type == DocumentsReview) {
//        //			frame.size.height = image.size.height;
//        //			frame.size.width = image.size.width;
//        //			frame.origin.x = (rect.size.width - image.size.width)/2;
//        //			frame.origin.y = (rect.size.height - image.size.height)/2;
//        //		}
//        //		else {
//        frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
//        //		}
//	}
//	
//	if (rect.size.width == 96 && rect.size.height == 76) {
//		//宽度不够 高度太高
//		rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width-4, rect.size.height-4);
//		if (rect.size.width/rect.size.height>image.size.width/image.size.height) {
//			frame.size.height = rect.size.height;//那就以高度为主
//			frame.size.width = (rect.size.height*image.size.width)/image.size.height;//那就压缩宽度吧
//		}
//		//宽度太宽 高度不够
//		else if (rect.size.width/rect.size.height<image.size.width/image.size.height) {
//			frame.size.width = rect.size.width;//宽度为主
//			frame.size.height = (rect.size.width*image.size.height)/image.size.width;//压缩宽度
//		}else {
//			frame.size.width = rect.size.width;
//			frame.size.height = rect.size.height;
//		}
//		frame.origin.x = (rect.size.width+4 - frame.size.width)/2;
//		frame.origin.y = (rect.size.height+4 - frame.size.height)/2;
//	}
//	if (rect.size.width == 80 && rect.size.height == 60) {
//		if (!isBg) {
//			//宽度不够 高度太高
//			rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width-4, rect.size.height-4);
//			if (rect.size.width/rect.size.height>image.size.width/image.size.height) {
//				frame.size.height = rect.size.height;//那就以高度为主
//				frame.size.width = (rect.size.height*image.size.width)/image.size.height;//那就压缩宽度吧
//			}
//			//宽度太宽 高度不够
//			else if (rect.size.width/rect.size.height<image.size.width/image.size.height) {
//				frame.size.width = rect.size.width;//宽度为主
//				frame.size.height = (rect.size.width*image.size.height)/image.size.width;//压缩宽度
//			}else {
//				frame.size.width = rect.size.width;
//				frame.size.height = rect.size.height;
//			}
//			frame.origin.x = (rect.size.width+4 - frame.size.width)/2;
//			frame.origin.y = (rect.size.height+4 - frame.size.height)/2;
//		}
//	}
    
    //这里一定要是super
//    super.frame = frame;
    
    self.contentMode=UIViewContentModeScaleAspectFit;
    super.image = image;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	CGRect frame = CGRectZero;
//	if (!isBg) {
//		frame.size.height = rect.size.height - 4;
//		frame.size.width = rect.size.width - 4;
//		frame.origin.x = (rect.size.width - frame.size.width)/2;
//		frame.origin.y = (rect.size.height - frame.size.height)/2;
//	}
//	else {
////		if (type == DocumentsReview) {
////			frame.size.height = image.size.height;
////			frame.size.width = image.size.width;
////			frame.origin.x = (rect.size.width - image.size.width)/2;
////			frame.origin.y = (rect.size.height - image.size.height)/2;
////		}
////		else {
//			frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
////		}
//	}
//	
//	if (rect.size.width == 96 && rect.size.height == 76) {
//		//宽度不够 高度太高
//		rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width-4, rect.size.height-4);
//		if (rect.size.width/rect.size.height>image.size.width/image.size.height) {
//			frame.size.height = rect.size.height;//那就以高度为主
//			frame.size.width = (rect.size.height*image.size.width)/image.size.height;//那就压缩宽度吧
//		}
//		//宽度太宽 高度不够
//		else if (rect.size.width/rect.size.height<image.size.width/image.size.height) {
//			frame.size.width = rect.size.width;//宽度为主
//			frame.size.height = (rect.size.width*image.size.height)/image.size.width;//压缩宽度
//		}else {
//			frame.size.width = rect.size.width;
//			frame.size.height = rect.size.height;
//		}
//		frame.origin.x = (rect.size.width+4 - frame.size.width)/2;
//		frame.origin.y = (rect.size.height+4 - frame.size.height)/2;
//	}
//	if (rect.size.width == 80 && rect.size.height == 60) {
//		if (!isBg) {
//			//宽度不够 高度太高
//			rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width-4, rect.size.height-4);
//			if (rect.size.width/rect.size.height>image.size.width/image.size.height) {
//				frame.size.height = rect.size.height;//那就以高度为主
//				frame.size.width = (rect.size.height*image.size.width)/image.size.height;//那就压缩宽度吧
//			}
//			//宽度太宽 高度不够
//			else if (rect.size.width/rect.size.height<image.size.width/image.size.height) {
//				frame.size.width = rect.size.width;//宽度为主
//				frame.size.height = (rect.size.width*image.size.height)/image.size.width;//压缩宽度
//			}else {
//				frame.size.width = rect.size.width;
//				frame.size.height = rect.size.height;
//			}
//			frame.origin.x = (rect.size.width+4 - frame.size.width)/2;
//			frame.origin.y = (rect.size.height+4 - frame.size.height)/2;
//		}
//	}
	
	[image drawInRect:frame];
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
		CGPoint touchPoint = [theTouch locationInView:self];	
		//点击父容器放大
		if (touchPoint.x>0&&touchPoint.y>0&&self.tag == 9000) {
			AlertImageView *alert = [[AlertImageView alloc] init];
			//ImageView *iv = [[temp subviews] objectAtIndex:0];
			//[alert setImage:iv.image];
			[alert setImageUrl:self.object];
			[[Global GetInstance].mainViewController.view addSubview:alert.view];
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

- (void)dealloc {
	[downLoad cancleDownload];
	[downLoad release];
	downLoad = nil;
	[imageUrl release];
	imageUrl = nil;
	[image release];
	image = nil;
	baseEntity = nil;
    [super dealloc];
}


@end
