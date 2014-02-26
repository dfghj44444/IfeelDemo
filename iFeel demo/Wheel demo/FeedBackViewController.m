//
//  FeedBackViewController.m
//  Wheel demo
//
//  Created by dfghj44444 on 13-11-4.
//
//

#import "FeedBackViewController.h"
#include "WrtingViewController.h"
#include "WheelDemoViewController.h"
@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"摆设" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.backBarButtonItem.title = @"返回";
    
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonSystemItemCancel target:self action:@selector(doback)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    //加上年月
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSMonthCalendarUnit | NSDayCalendarUnit ;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    
    int month = [comps month];
    int day = [comps day];
    UIImage *imageDate = [UIImage imageNamed: [NSString stringWithFormat:@"img/m%d.png",month]];
    [_imgMonth setImage: imageDate];
    
    UIImage *imageDay = [UIImage imageNamed: [NSString stringWithFormat:@"img/%d.png",day]];
    [_imgDay setImage: imageDay];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doback{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[WheelDemoViewController class]]) {
            [self.navigationController popToViewController:controller animated:NO];
            break;
        }
    }
}

@end
