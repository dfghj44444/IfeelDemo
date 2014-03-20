//
//  WrtingViewController.cpp
//  Wheel demo
//
//  Created by dfghj44444 on 13-11-2.
//
//

#include "WrtingViewController.h"
#include "FeedBackViewController.h"
#include "WheelDemoViewController.h"
@interface WritingViewController()

@end

@implementation WritingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.txtMain.userInteractionEnabled = YES;
    self.txtMain.delegate = self;
    //心情记录
    //UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"摆设" style:UIBarButtonItemStyleBordered target:nil action:nil];
    //self.navigationItem.rightBarButtonItem = backItem;
    //self.navigationItem.backBarButtonItem.title = @"返回";
}

-(id)init{
    self = [super initWithNibName:@"WritingView"   bundle:nil ];
    if (self) {
        //self.view.delegate = self;
        self.txtMain.userInteractionEnabled = YES;
        self.txtMain.delegate = self;
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    return [self init];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    NSLog(@"textViewShouldBeginEditing:");
    
    return YES;
    
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    NSLog(@"textViewShouldEndEditing:");
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    UIBarButtonItem *done =    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(leaveEditMode)] ;
    
    self.navigationItem.rightBarButtonItem = done;
    
    self.txtMain.text = @"";
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    self.navigationItem.rightBarButtonItem = nil;
    [self leaveEditMode];
    
}
//点击完成
- (void)leaveEditMode {
    
    [self.txtMain resignFirstResponder];
    //WritingToDB();
    //FeedBackViewController *aViewController = [[FeedBackViewController alloc] init];
    //[self presentModalViewController:aViewController animated:TRUE];
    //[self.navigationController pushViewController:aViewController animated:TRUE];
    //[self.navigationController ];
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    int nSegment = [accountDefaults integerForKey: @"curSegment"];
    [WheelDemoViewController  AddRecord:nSegment withString:self.txtMain.text];
    
    FeedBackViewController *aViewController = [[FeedBackViewController alloc] init];
    [self.navigationController pushViewController:aViewController animated:TRUE];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{

}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    
}


@end