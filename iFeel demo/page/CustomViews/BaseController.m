    //
//  BaseController.m
//  LiveByTouch
//
//  Created by hao.li on 11-7-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/**
 画圆角资料
 //指付通帐号 点评收益 关注 粉丝
 UIView *v = [[UIView alloc] initWithFrame:CGRectMake(10, tvUserInfo.frame.origin.y + tvUserInfo.frame.size.height + 20 , 300, 50)];
 v.backgroundColor = [UIColor whiteColor];
 v.layer.cornerRadius = 5;
 v.layer.masksToBounds = YES;
 v.opaque = NO;
 */


#import "BaseController.h"
#import "Global.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "Config.h"
#import "UIDeviceHelp.h"
#import "BaseCell.h"

@implementation BaseController

@synthesize scrollView,tabBar,tabBarHeight;


- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

/**
 get请求 解析json数据
 异步请求
 */
-(void) getPaserHelper:(NSString*)url :(int)processType
{
//	if ([Global GetInstance].hasNetwork == NO) {
//		[Global messagebox:@"当前网络连接失败！"];
//		return;
//	}
	NSLog(@"memory 开始请求=%f mb",[[UIDevice currentDevice] availableMemory]);
	if ([LoginResult GetInstance].isLogin == NO) {
		url = [url stringByAppendingFormat:@"&apptype=iphone&pg.pageSize=20&appuuid=%@",[Global encodedUrlString:[Config GetInstance].firstTime]];
	}
	else {
		url = [url stringByAppendingFormat:@"&webname=%@&token=%@&apptype=iphone&pg.pageSize=20&appuuid=%@",[LoginResult GetInstance].webname,[LoginResult GetInstance].token,[Global encodedUrlString:[Config GetInstance].firstTime]];
	}

	//NSLog(@"---%@",url);
	[_request cancel];
	[_request release];
	_request = nil;
	_request = [[ASIHTTPRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
	_request.processType = processType;
	[_request setDelegate:self];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	//创建活动图标
	progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.navigationItem.titleView.frame.size.width-30)/2, (self.navigationItem.titleView.frame.size.height-60)/2, 20, 20)];
	progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
	[self.navigationItem.titleView addSubview:progress];
	[self _requestStart:processType];
	[_request setTimeOutSeconds:10*60];
	[_request startAsynchronous];
}

/**
 post请求 解析json数据
 */
-(void) postPaserHelper :(NSString*)url :(NSArray*)params :(ProcessType)processType{
	//NSLog(@"%@",url);
	ASIFormDataRequest *myRequest = [[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]] autorelease];	
	myRequest.processType = processType;
	//[myRequest addRequestHeader:@"Accept" value:@"application/xml"];//add header	
	[myRequest addRequestHeader:@"Content-Type" value:@"application/xml;charset=UTF-8;"];
	myRequest.delegate = self;
//	[myRequest setDidStartSelector:@selector(requestDidStart:)];
//	[myRequest setDidFailSelector:@selector(requestDidFailed:)];
//	[myRequest setDidFinishSelector:@selector(requestDidSuccess:)];
	[myRequest setTimeOutSeconds:1*60];
	[myRequest setPostFormat:ASIMultipartFormDataPostFormat];
	
	for (int i=0; i<[params count]; i++) {
		NSDictionary *dir = [params objectAtIndex:i];
		if (dir!=nil) {
			NSString *value = [dir objectForKey:@"value"];
			NSString *key = [dir objectForKey:@"key"];
			if (value&&key) {
				[myRequest setPostValue:value forKey:key];
			}
		}
	}
	//[myRequest setPostValue:[LoginResult GetInstance].webname forKey:@"webname"];
	//[myRequest setPostValue:[LoginResult GetInstance].token forKey:@"token"];
	//[myRequest setPostValue:@"iphone" forKey:@"apptype"];
	//[myRequest setPostValue:[Global encodedUrlString:[Config GetInstance].firstTime] forKey:@"appuuid"];
	
	[myRequest startAsynchronous];
	//如果发生错误，返回nil
//	if ([myRequest error]) 
//	{	
//		return nil;
//	}
	//编码转换 gb2313 to UTF
//	NSData * myResponseData = [myRequest responseData];
//	//	NSLog
//	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);//kCFStringEncodingGB_18030_2000
//	NSString * myResponseStr = [[NSString alloc] initWithData:myResponseData encoding:enc];
//	//NSLog(@"%@",myResponseStr);
//    NSDictionary *dir = [myResponseStr JSONValue];
//	[myResponseStr release];
//	BOOL con = [[dir objectForKey:@"success"] boolValue];
//	if (!con) {
//		[Global messagebox:@"服务端返回数据出错了！"];
//	}
//	return dir;
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	//编码转换 gb2313 to UTF
	NSData * myResponseData = [request responseData];
	[self _requestSuccess:request.processType];
	//	NSLog
	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);//kCFStringEncodingUTF8
	NSString * myResponseStr = [[NSString alloc] initWithData:myResponseData encoding:enc];
	
    //JsonResult *result = nil;
    NSDictionary *dic = [myResponseStr JSONValue];
    if ([dic objectForKey:@"uid"]!=nil && ![[dic objectForKey:@"uid"] isEqualToString:@""]) {
        [UserInfo GetInstance].uid = [[dic objectForKey:@"uid"] intValue];
    }
    else {
        //result = [[JsonResult alloc] initWithJSONStr:myResponseStr];
    }
    NSLog(@"返回结果：%@",myResponseStr);
  

    //NSLog(@"jsonResult=%@",[result toJson]);
	//[self getTableView].pg = result.pg;
	
//	BOOL con = NO;
//	//提示用户需要登录
//	if ([result.suggestAction isEqualToString:@"openLoginDlg"]) {
//		result.isneedLogin = YES;
//		con = YES;
////		MyTouchController *touch = [[MyTouchController alloc] init];
////		touch.breakDelegate = self;
////		[touch setBreakPage:BreakNeedLogin];
////		[self PushToTop:touch];
////		[touch release];
//	}
//	//弹出信息
//	else if ([result.suggestAction isEqualToString:@"alert"]){
//		[Global messagebox:result.msg];
//		con = YES;
//	}
//	else if([result.suggestAction isEqualToString:@"toast"]){
//		[Global messagetoast:result.msg target:self.view parent:self];
//		con = YES;
//	}
//	//服务端返回异常
//	if (con == NO && !result.success) {
//		//[Global messagebox:@"服务端异常！"];
//		[Global messagetoast:@"服务端异常" target:self.view parent:self];
//		NSError *error = [request error];
//		NSLog(@"请求时报错情况requestFailed:－－－%@",error);
//		NSLog(@"服务端返回的数据：%@",myResponseStr);
//	}
//	[myResponseStr release];
//    //NSLog(@"memory 请求完成=%f mb",[[UIDevice currentDevice] availableMemory]);
//    if (con) {
//        [self responseReturnSuccess:result];
//        return;
//    }
    //[self responseDataSuccess:result];
    [self responseReturnSuccess:myResponseStr];
  [myResponseStr release];
	//NSLog(@"memory 加载数据结束=%f mb",[[UIDevice currentDevice] availableMemory]);
}

-(void) breakDone:(BreakType)breakType{

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSError *error = [request error];
	[self _requestFailed:request.processType];
	NSLog(@"请求时报错情况requestFailed:－－－%@",error);
//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错了" message:@"已经取消了网络请求！" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
//	[alert show];
//	[alert release];
}

//-(void) responseDataSuccess:(JsonResult*)json{
//    
//	
//	if ([self getTableView].currentPage == 0) {
//        
//		[[self getTableView].tableArray removeAllObjects];
//	}
//}


-(void) responseReturnSuccess:(NSString*)json{
	if ([self getTableView].currentPage == 0) {
		[[self getTableView].tableArray removeAllObjects];
	}
}

-(void) StartAnimation:(int)type
{
//	CATransition *animation = [CATransition animation];
//    //animation.delegate = self;
//    animation.duration = 0.5f;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//	animation.fillMode = kCAFillModeForwards;
//	//animation.removedOnCompletion = NO;
//	
//	//UIButton *theButton = (UIButton *)sender;
//	/*
//	 kCATransitionFade;
//	 kCATransitionMoveIn;
//	 kCATransitionPush;
//	 kCATransitionReveal;
//	 */
//	/*
//	 kCATransitionFromRight;
//	 kCATransitionFromLeft;
//	 kCATransitionFromTop;
//	 kCATransitionFromBottom;
//	 */
//	switch (type) {
//		case 0:
//			animation.type = kCATransitionPush;
//			animation.subtype = kCATransitionFromTop;
//			break;
//		case 1:
//			animation.type = kCATransitionMoveIn;
//			animation.subtype = kCATransitionFromTop;
//			break;
//		case 2:
//			animation.type = kCATransitionReveal;
//			animation.subtype = kCATransitionFromTop;
//			break;
//		case 3:
//			animation.type = kCATransitionFade;
//			animation.subtype = kCATransitionFromTop;
//			break;
//		default:
//			break;
//	}
//	
//	[self.view.layer addAnimation:animation forKey:@"animation"];

		//return;
		// First create a CATransition object to describe the transition
		CATransition *transition = [CATransition animation];
		// Animate over 3/4 of a second
		transition.duration = 0.9f;
		// using the ease in/out timing function
		transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
		
		// Now to set the type of transition. Since we need to choose at random, we'll setup a couple of arrays to help us.
		//	NSString *types[4] = {kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};
		//pageCurl: 舊版面像一頁書那樣被揭開, 顯示下面的新版面.
		//- pageUnCurl: 新版面像一頁書被翻過來覆蓋舊版面.
		//- suckEffect: 舊版面在螢幕下方中間位置被吸走, 顯示出下面的新版面.
		//- spewEffect: 	
		NSString *types[4] = {@"pageCurl",@"pageUnCurl",kCATransitionPush,kCATransitionPush};
		NSString *subtypes[4] = {kCATransitionFromLeft, kCATransitionFromBottom, kCATransitionFromRight, kCATransitionFromLeft};
		//	[transition setType: effects[@"pageCurl"]];
		transition.type = types[type];
		transition.subtype = subtypes[type];
		
		// Finally, to avoid overlapping transitions we assign ourselves as the delegate for the animation and wait for the
		// -animationDidStop:finished: message. When it comes in, we will flag that we are no longer transitioning.
		//	transitioning = YES;
		transition.delegate = self;
		
		// Next add it to the containerView's layer. This will perform the transition based on how we change its contents.
		[self.view.layer addAnimation:transition forKey:nil];
	
}
/**
 从下向上推入导航
 */
-(void) PushToTop:(UIViewController*)subView
{
	CATransition *transition = [CATransition animation];
	transition.duration = 0.5;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; 
	transition.type = kCATransitionMoveIn; 
	transition.subtype = kCATransitionFromTop;
	transition.delegate = self; 
	[self.navigationController.view.layer addAnimation:transition forKey:nil];
	//self.navigationController.navigationBarHidden = NO; 
	[self.navigationController pushViewController:subView animated:NO];
}
/**
 从下向上返回主页
 */
-(void) PopToParent
{
	CATransition *transition = [CATransition animation];
	transition.duration = 0.5;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; 
	transition.type = kCATransitionReveal; 
	transition.subtype = kCATransitionFromBottom;
	transition.delegate = self; 
	[self.navigationController.view.layer addAnimation:transition forKey:nil];
	//self.navigationController.navigationBarHidden = NO; 
	[self.navigationController popViewControllerAnimated:NO];
	
	
}

-(void) BackToMain{
	UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowParent:)];
	backItem.tag = 1;
	self.navigationItem.leftBarButtonItem = backItem; 
    [backItem release];
}

-(void) RightToMain{
	UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithTitle:@"主页" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowParent:)];
	backItem.tag = 2;
	self.navigationItem.rightBarButtonItem = backItem;
    [backItem release];
}

-(void) LeftToMain{
	//从左边返回到主页
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowParent:)];
	backItem.tag = 2;
	self.navigationItem.leftBarButtonItem = backItem;
    [backItem release];
}

-(void) RightLoginOut{
	UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowParent:)];
	backItem.tag = 3;
	self.navigationItem.rightBarButtonItem = backItem;
    [backItem release];
}

-(void) RightToMap{
	UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithTitle:@"地图" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowParent:)];
	backItem.tag = 4;
	self.navigationItem.rightBarButtonItem = backItem;
    [backItem release];
}
-(void) RightToMapList{
	UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithTitle:@"地图列表" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowParent:)];
	backItem.tag = 4;
	self.navigationItem.rightBarButtonItem = backItem;
    [backItem release];
}

-(void) RightToMapPath{
	UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithTitle:@"地图路线" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowParent:)];
	backItem.tag = 5;
	self.navigationItem.rightBarButtonItem = backItem;
    [backItem release];
}

-(void) LeftChooseCity{
	UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithTitle:@"切换城市" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowParent:)];
	backItem.tag = 6;
	self.navigationItem.leftBarButtonItem = backItem;
    [backItem release];
}

-(void) RightRefresh{
	UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowParent:)];
	backItem.tag = 7;
	self.navigationItem.rightBarButtonItem = backItem;
    [backItem release];

}


-(void) ShowParent:(id)sender
{
	//	CABasicAnimation *zoomAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
	//	CATransform3D  transform = CATransform3DMakeScale(0.1f, 0.1f, 1.0f);
	//	
	//	[zoomAnimation setToValue:[NSValue valueWithCATransform3D:transform]];
	//	CATransform3D transform1 = CATransform3DMakeScale(1.0f, 1.0f, 1.0f);
	//	
	//	[zoomAnimation setFromValue:[NSValue valueWithCATransform3D:transform1]];
	//	
	//	zoomAnimation.removedOnCompletion = YES;
	//	zoomAnimation.duration = 0.5;
	//	//zoomAnimation.repeatCount = 1e100;
	//	[self.navigationController.view.layer addAnimation:zoomAnimation forKey:@"transform"];
	//跳转到上一个页面
	
	//返回的时候取消请求
	[_request cancel];
	TableView *tb = [self getTableView];
	if (tb) {
		[tb scrollViewDidEndDragging:scrollView];
	}
	if ([sender tag]==1) {
		[self.navigationController popViewControllerAnimated:YES];
	}
	//跳转到根目录
	else if([sender tag]==2)
	{
		[self.navigationController popToRootViewControllerAnimated:YES];
	}
	//注销
	else if([sender tag] == 3) {
		[UserInfo ClearnUserInfo];
		[self.navigationController popToRootViewControllerAnimated:YES];
	}
	//地图
	else if([sender tag] == 4){

	}


}

/**
 alpha 从0到1
 */
-(void) AlphaToOne:(UIView*)targetView
{
	targetView.hidden = NO;
	CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	fadeInAnimation.duration = 0.5f;
	fadeInAnimation.removedOnCompletion = NO;
	fadeInAnimation.fillMode = kCAFillModeForwards;
	fadeInAnimation.fromValue = [NSNumber numberWithFloat:0.1f];
	fadeInAnimation.toValue = [NSNumber numberWithFloat:0.9f];
	fadeInAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	[targetView.layer addAnimation:fadeInAnimation forKey:@"animateOpacity"];
	
}

/**
 alpha 从1到0
 */
-(void) AlphaToZero:(UIView*)targetView
{
	animationView=targetView;
	CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	fadeOutAnimation.delegate = self;
	fadeOutAnimation.duration = 0.5f;
	fadeOutAnimation.removedOnCompletion = NO;
	fadeOutAnimation.fillMode = kCAFillModeForwards;
	fadeOutAnimation.fromValue = [NSNumber numberWithFloat:0.9f];
	fadeOutAnimation.toValue = [NSNumber numberWithFloat:0.0f];
	fadeOutAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	[targetView.layer addAnimation:fadeOutAnimation forKey:@"animateOpacity"];
}

//移动Y
-(void) moveYTarget:(UIView*)v FromValue:(int)fromValue ToValue:(int)toValue Duration:(float)duration{
	CABasicAnimation *theAnimation;
	theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
	//theAnimation.delegate = self;
	theAnimation.duration = duration;
	theAnimation.repeatCount = 1;
	theAnimation.removedOnCompletion = FALSE;
	//theAnimation.fillMode = kCAFillModeForwards;
	theAnimation.autoreverses = NO;
//	theAnimation.fromValue = [NSNumber numberWithFloat:fromValue];
//	theAnimation.toValue = [NSNumber numberWithFloat:toValue];
	theAnimation.toValue=[NSNumber numberWithInt:toValue];
	theAnimation.fromValue=[NSNumber numberWithInt:fromValue];

	theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	[[v layer] addAnimation:theAnimation forKey:@"animateLayer"]; 
	

}

-(void) startmove:(int)type target:(UIView*)tg
{
	tg.hidden = NO;
	//return;
	// First create a CATransition object to describe the transition
	CATransition *transition = [CATransition animation];
	// Animate over 3/4 of a second
	transition.duration = 0.5f;
	// using the ease in/out timing function
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	// Now to set the type of transition. Since we need to choose at random, we'll setup a couple of arrays to help us.
	//	NSString *types[4] = {kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};
	//pageCurl: 舊版面像一頁書那樣被揭開, 顯示下面的新版面.
	//- pageUnCurl: 新版面像一頁書被翻過來覆蓋舊版面.
	//- suckEffect: 舊版面在螢幕下方中間位置被吸走, 顯示出下面的新版面.
	//- spewEffect: 	
	NSString *types[4] = {@"pageCurl",@"pageUnCurl",kCATransitionPush,kCATransitionPush};
	NSString *subtypes[4] = {kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};
	//	[transition setType: effects[@"pageCurl"]];
	
	transition.type = types[type];
	transition.subtype = subtypes[type];
	
	// Finally, to avoid overlapping transitions we assign ourselves as the delegate for the animation and wait for the
	// -animationDidStop:finished: message. When it comes in, we will flag that we are no longer transitioning.
	//	transitioning = YES;
	transition.delegate = self;
	
	// Next add it to the containerView's layer. This will perform the transition based on how we change its contents.
	[tg.layer addAnimation:transition forKey:nil];
	
	//	[CATransaction begin];
	//	[CATransaction setValue:[NSNumber numberWithFloat:1.0] forKey:kCATransactionAnimationDuration];
	//	CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"transtorm.rotaion.y"];
	//	move.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	//	move.toValue = [NSNumber numberWithFloat:100];
	//	move.duration =1;
	//	move.fillMode = kCAFillModeForwards;
	//	move.removedOnCompletion = NO;
	//	[more.layer addAnimation:move forKey:@"move"];
	//	[CATransaction commit];
}

#pragma mark CABasicAnimation delegate methods
- (void)animationDidStart:(CAAnimation *)anim{

}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
	animationView.hidden = YES;
}
#pragma mark CABasicAnimation delegate methods end

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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView {
//	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [Global GetInstance].ScreenWidth, [Global GetInstance].ScreenHeight)];
//}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[Global GetInstance].ScreenHeight = 480 - self.navigationController.navigationBar.frame.size.height - 20 - tabBarHeight;
	//UIImage *image = [UIImage imageNamed: @"switchCitySelected.png"]; 
	//背景图
	UIImage *img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BG2@2x.jpg" ofType:nil]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:img];
	
//	ImageView *img = [[ImageView alloc] initWithPath:@"NoticeBgPressed.png" ImageType:ImageDefault];
//	img.alpha = 0.1;
//	self.view.backgroundColor = [UIColor colorWithPatternImage:img.image];
//	[img release];

	scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0, [Global GetInstance].ScreenWidth, [Global GetInstance].ScreenHeight)];
	scrollView.scrollDelegate = self;
	[self.view addSubview:scrollView];
	[self initview];
	self.navigationController.navigationBar.barStyle =UIBarStyleBlackOpaque;// UIStatusBarStyleBlackOpaque;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
}

-(void) initview
{
    
}

#pragma mark UIResponder methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
}

#pragma mark scrollDelegate methods 
-(void) scrollTouchBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view{

}
-(void) scrollTouchEnd:(UIView *)view{

}
-(void) scrollTouchEnded:(NSSet *)touches withEvent:(UIEvent *)event{

}

-(TableView*) getTableView{
	return nil;
}

//开始移动
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)sv{
	TableView *tb = [self getTableView];
	if (tb) {
		[tb scrollViewWillBeginDecelerating:sv];
	}
}

//下拉table
- (void)scrollViewDidScroll:(UIScrollView *)sv{	
	TableView *tb = [self getTableView];
	if (tb) {
		[tb scrollViewDidScroll:sv];
	}
}

//刷新table  当scrollView 停止滚动拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)sv willDecelerate:(BOOL)decelerate{
	TableView *tb = [self getTableView];
	
//	if (![self isKindOfClass:[ReviewsListController class]]) {
//		if ([tb.tableArray count]>0) {
//			NSArray *visiblePaths = [tb indexPathsForVisibleRows];
//			for (NSIndexPath *indexPath in visiblePaths)
//			{
//				BaseCell * cell= (BaseCell*)[tb cellForRowAtIndexPath:indexPath];
//				BaseEntity *baseEntity = [tb.tableArray objectAtIndex:indexPath.row];
//				if ([cell isKindOfClass:[BaseCell class]]) {
//					[cell setRow:indexPath.row];
//					[cell setBaseEntity:baseEntity];
//				}
//			}
//		}
//	}
	
	if (tb) {
		[tb scrollViewDidEndDragging:sv];
	}
}


#pragma mark Deferred image loading (UIScrollViewDelegate)
//当滚动条停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//	if (![self isKindOfClass:[ReviewsListController class]]) {
//		TableView *tb = [self getTableView];
//		if ([tb.tableArray count]>0) {
//			NSArray *visiblePaths = [tb indexPathsForVisibleRows];
//			for (NSIndexPath *indexPath in visiblePaths)
//			{
//				BaseCell * cell= (BaseCell*)[tb cellForRowAtIndexPath:indexPath];
//				BaseEntity *baseEntity = [tb.tableArray objectAtIndex:indexPath.row];
//				if ([cell isKindOfClass:[BaseCell class]]) {
//					[cell setRow:indexPath.row];
//					[cell setBaseEntity:baseEntity];
//				}
//			}
//		}
//	}

}

#pragma mark scrollDelegate methods end



#pragma mark GlobalDelegate methods

-(void) _requestFailed:(int)processType{

	if (processType == ProcessDefault) {
		if (bvProgress!=nil) {
			[progress stopAnimating];
			[progress removeFromSuperview];
			[progress release];
			progress = nil;
			[bvProgress removeFromSuperview];
			[bvProgress release];
			bvProgress = nil;
		}
		
	}
	if (processType == ProcessSimple) {
		if (progress != nil) {
			[progress stopAnimating];
			[progress removeFromSuperview];
			[progress release];
			progress = nil;
		}
	}
	NSLog(@"请求时报错情况_requestFailed:－－－%@",@"这个网络请求连接失败");
//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错了" message:@"网络连接失败, 请稍后重试！" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
//	[alert show];
//	[alert release];
}
-(void) _requestSuccess:(int)processType{
	//无加载提示
	if (processType == ProcessNone) {
		return;
	}
	//有黑色的背景
	if (processType == ProcessDefault) {
		if (bvProgress != nil) {
			[progress stopAnimating];
			[progress removeFromSuperview];
			[progress release];
			progress = nil;
			[bvProgress removeFromSuperview];
			[bvProgress release];
			bvProgress = nil;
		}
	}
	//只有转圈
	if (processType == ProcessSimple) {
		if (progress != nil) {
			[progress stopAnimating];
			[progress removeFromSuperview];
			[progress release];
			progress = nil;
		}
	}
}
-(void) _requestStart:(int)processType{
	//无加载提示
	if (processType == ProcessNone) {
		return;
	}
	if (processType == ProcessDefault) {//有黑色的背景
		if (bvProgress == nil) {
			bvProgress = [[ButtonView alloc] initWithName:nil :@"加载中⋯⋯"];
			[bvProgress.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];   
			[bvProgress setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
			
			bvProgress.frame = CGRectMake(0, 0, [Global GetInstance].ScreenWidth, 480 - tabBarHeight);
			bvProgress.backgroundColor=BLACKBGCOLOR;
			//bvProgress.backgroundColor = [UIColor clearColor];
			progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((bvProgress.frame.size.width-30)/2, (bvProgress.frame.size.height-60)/2, 20, 20)];
			progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
			[bvProgress addSubview:progress];
			[progress startAnimating];
			[self.parentViewController.view addSubview:bvProgress];
		}
	}
	if (processType == ProcessSimple) {//一般的显示效果  只有转圈
		progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((320-30)/2, (460-44-tabBarHeight)/2, 20, 20)];
		progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
		[self.view addSubview:progress];
		[progress startAnimating];
	}
}

#pragma mark GlobalDelegate methods

#pragma mark UITableViewRefresh
-(void) reloadRefreshDataSource:(int) pageIndex{
	//[[self getTableView].cells removeAllObjects];
}
#pragma mark UITableViewRefresh end
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)viewWillAppear:(BOOL)animated
{
	//取消选中行
	if (oldCell) {
		[oldCell setSelected:NO animated:YES];
		oldCell = nil;
	}
}
- (void)viewDidAppear:(BOOL)animated{
	//取消选中行
	if (oldCell) {
		[oldCell setSelected:NO animated:YES];
		oldCell = nil;
	}
}
- (void)viewWillDisappear:(BOOL)animated{
	
	self.navigationController.navigationBar.translucent = NO;
}


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
	[Global GetInstance].targetView = nil;
	[scrollView release];
	scrollView = nil;
//	[oldCell release];
//	oldCell = nil;
	[_request cancel];
	[_request release];
	_request = nil;
	[tabBar release];
	tabBar = nil;
	[super dealloc];
	NSLog(@"memory 退出该页=%f mb",[[UIDevice currentDevice] availableMemory]);
}


@end
