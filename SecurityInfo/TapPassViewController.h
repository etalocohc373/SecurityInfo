//
//  TapPassViewController.h
//  SecurityInfo
//
//  Created by Minami Sophia Aramaki on 2013/10/14.
//  Copyright (c) 2013年 Minami Sophia Aramaki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TabViewController.h"

@interface TapPassViewController : UIViewController{
    IBOutlet UIImageView *img;
    IBOutlet UILabel *lb;
    IBOutlet UILabel *lb2;
    UIImageView *hamon;
    UITapGestureRecognizer *tapGesture;
    NSTimer *timer;
    NSUserDefaults *store;
    float time;
    float taptime[5];
    float seikaitime[5];
    float kakunintime[5];
    int kaisu;
    BOOL tapped;
    BOOL first;
    BOOL kakunin;
}

@end
