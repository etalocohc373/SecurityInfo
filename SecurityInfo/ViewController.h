//
//  ViewController.h
//  SecurityInfo
//
//  Created by Minami Sophia Aramaki on 2013/10/14.
//  Copyright (c) 2013年 Minami Sophia Aramaki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "TapPassViewController.h"

@interface ViewController : UIViewController<UITextFieldDelegate>{
    IBOutlet UITextField *tf;
    IBOutlet UIImageView *dot;
    IBOutlet UIImageView *dot2;
    IBOutlet UIImageView *dot3;
    IBOutlet UIImageView *dot4;
    IBOutlet UIImageView *circle;
    IBOutlet UIImageView *circle2;
    IBOutlet UIImageView *circle3;
    IBOutlet UIImageView *circle4;
    IBOutlet UILabel *lb;
    NSString *pass;
    NSString *seikaipass;
    int kaisu;
    int mojisu;
    int mistaken;
    BOOL settei;
    BOOL kakunin;
    CFURLRef soundURL;
    SystemSoundID soundID;
    NSUserDefaults *store;
}

@end
