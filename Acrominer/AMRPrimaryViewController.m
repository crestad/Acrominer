//
//  AMRPrimaryViewController.m
//  Acrominer
//
//  Created by Dave on 9/2/15.
//  Copyright (c) 2015 Dave. All rights reserved.
//

#import "AMRPrimaryViewController.h"
#import "AMRMessageDisplayViewController.h"

@interface AMRPrimaryViewController ()
{
    AMRMessageDisplayViewController *messageDisplayController;
    CGRect messageInitialFrame;
}

@end

@implementation AMRPrimaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displaySlideUpMessage:) name:AMRMessageDisplayNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditingStarted:) name:UITextFieldTextDidBeginEditingNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:AMRMessageDisplayNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:UITextFieldTextDidBeginEditingNotification];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (IBAction)viewTapped:(id)sender {
    [self hideSlideUpMessage:YES];
}

- (void)textFieldEditingStarted:(NSNotification *)notification {
    [self hideSlideUpMessage:YES];
}

- (void) displayContentController:(UIViewController*)content inFrame:(CGRect)frame;
{
    [self addChildViewController:content];
    content.view.frame = frame;
    [self.view addSubview:content.view];
    [content didMoveToParentViewController:self];
}

- (void)displaySlideUpMessage:(NSNotification *)notification {
    messageDisplayController = [[AMRMessageDisplayViewController alloc] initWithNibName:@"AMRMessageDisplayViewController" bundle:nil];
    NSString *message = notification.object;
    messageDisplayController.message = message;
    if (message) {
        CGRect myBounds = self.view.bounds;
        CGFloat messageWidth = MIN(myBounds.size.width, 300);
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        UIFont *font = [UIFont boldSystemFontOfSize:16.0f];
        NSDictionary *attrs = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName: paragraphStyle };
        CGSize constraint = CGSizeMake(messageWidth - 16, myBounds.size.height);
        CGRect messageBoundingBox = [message boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
        messageBoundingBox = CGRectMake(messageBoundingBox.origin.x, messageBoundingBox.origin.y, ceil(messageBoundingBox.size.width), ceil(messageBoundingBox.size.height));
        CGFloat messageHeight = MAX(messageBoundingBox.size.height + 16, 40);
        CGRect messageRect = CGRectMake((messageWidth - messageBoundingBox.size.width) / 2, (messageHeight - messageBoundingBox.size.height) / 2, messageBoundingBox.size.width, messageBoundingBox.size.height);
        messageDisplayController.messageRect = messageRect;
        
        messageInitialFrame = CGRectMake((myBounds.size.width - messageWidth) / 2, myBounds.size.height + messageHeight, messageWidth, messageHeight);
        CGRect messageEndingFrame = CGRectMake((myBounds.size.width - messageWidth) / 2, myBounds.size.height - messageHeight, messageWidth, messageHeight);
        [self displayContentController:messageDisplayController inFrame:messageInitialFrame];
        [UIView animateWithDuration:0.5 animations:^{
            messageDisplayController.view.frame = messageEndingFrame;
        }];
    } else {
        [self hideSlideUpMessage:YES];
    }
}

- (void)hideSlideUpMessage:(BOOL)animated {
    if (messageDisplayController) {
        AMRMessageDisplayViewController *controller = messageDisplayController;
        CGRect frame = messageInitialFrame;
        messageDisplayController = nil;
        if (animated) {
            [UIView animateWithDuration:0.5 animations:^{
                controller.view.frame = frame;
            }];
        } else {
            controller.view.frame = frame;
        }
    }
}

@end
