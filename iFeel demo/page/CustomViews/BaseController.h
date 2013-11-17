//
//  BaseController.h
//  LiveByTouch
//
//  Created by hao.li on 11-7-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollView.h"
#import "Global.h"
#import "BaseView.h"
#import "ButtonView.h"
#import "LableView.h"
#import "ImageView.h"
#import "TableView.h"
#import "UserInfo.h"
#import "LoginResult.h"
#import "JSON.h"
#import "CustomTabBar.h"
#import "JsonResult.h"
#import "ASIHTTPRequest.h"


@protocol BreakDelegate

-(void) breakDone:(BreakType)breakType;

@end

@interface BaseController : UIViewController<ScrollDelegate,BreakDelegate,GlobalDelegate,UITableViewRefresh> {
	
	ScrollView *scrollView;//可以滚动的效果
	
	ButtonView *bvProgress;//显示进度条 不用release 
	UIActivityIndicatorView *progress;//活动图标  不用release
	
	UITableViewCell * oldCell;//记录上次选中的cell
	
	UIView *animationView;//运用动画的对象 不用release
	
	ASIHTTPRequest *_request;
	
	CustomTabBar* tabBar;
	int tabBarHeight;
    
}

@property (nonatomic,retain) ScrollView *scrollView;
@property (nonatomic, retain) CustomTabBar* tabBar;
@property (nonatomic) int tabBarHeight;


-(void) initview;

//异步请求数据
-(void) getPaserHelper:(NSString*)url :(int)processType;
-(void) postPaserHelper :(NSString*)url :(NSArray*)params :(ProcessType)processType;
//-(void) responseDataSuccess:(JsonResult*)json;
-(void) responseReturnSuccess:(NSString*)json;
-(TableView*) getTableView;

-(void) ShowParent:(id)sender;
-(void) StartAnimation:(int)type;
-(void) PushToTop:(UIViewController*)subView;
-(void) PopToParent;
-(void) BackToMain;
-(void) RightToMain;
-(void) LeftToMain;
-(void) RightLoginOut;
-(void) RightToMap;
-(void) RightToMapList;
-(void) RightToMapPath;
-(void) LeftChooseCity;
-(void) RightRefresh;


-(void) AlphaToZero:(UIView*)tagetView;
-(void) AlphaToOne:(UIView*)targetView;
-(void) moveYTarget:(UIView*)v FromValue:(int)fromValue ToValue:(int)toValue Duration:(float)duration;
-(void) startmove:(int)type target:(UIView*)tg;
@end
