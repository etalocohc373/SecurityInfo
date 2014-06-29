//
//  ViewController.m
//  SecurityInfo
//
//  Created by Minami Sophia Aramaki on 2013/10/14.
//  Copyright (c) 2013年 Minami Sophia Aramaki. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [tf becomeFirstResponder];
    store = [NSUserDefaults standardUserDefaults];
    seikaipass = [store objectForKey:@"passcode"];
    [store synchronize];
    NSLog(@"%@",seikaipass);
    if(!seikaipass){
        settei = YES;
        lb.text = @"パスコードを設定";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)appeardots{
    kaisu++;
    NSString *hantei = tf.text;
    if(kaisu==1){
        dot.alpha=1;
        pass = tf.text;
        CFBundleRef mainBundle;
        mainBundle = CFBundleGetMainBundle ();
        
        soundURL  = CFBundleCopyResourceURL (mainBundle,CFSTR ("click"),CFSTR ("mp3"),NULL);
        AudioServicesCreateSystemSoundID (soundURL, &soundID);
        CFRelease (soundURL);
        AudioServicesPlaySystemSound (soundID);
    }
    if(kaisu==2){
        if([hantei length]==2){
            dot2.alpha=1;
            pass = tf.text;
            CFBundleRef mainBundle;
            mainBundle = CFBundleGetMainBundle ();
            
            soundURL  = CFBundleCopyResourceURL (mainBundle,CFSTR ("click"),CFSTR ("mp3"),NULL);
            AudioServicesCreateSystemSoundID (soundURL, &soundID);
            CFRelease (soundURL);
            AudioServicesPlaySystemSound (soundID);
        }else{
            [self performSelector:@selector(fadeout) withObject:nil];
            kaisu-=2;
        }
    }
    if(kaisu==3){
        if([hantei length]==3){
            dot3.alpha = 1.0;
            pass = tf.text;
            CFBundleRef mainBundle;
            mainBundle = CFBundleGetMainBundle ();
            
            soundURL  = CFBundleCopyResourceURL (mainBundle,CFSTR ("click"),CFSTR ("mp3"),NULL);
            AudioServicesCreateSystemSoundID (soundURL, &soundID);
            CFRelease (soundURL);
            AudioServicesPlaySystemSound (soundID);
        }else{
            [self performSelector:@selector(fadeout) withObject:nil];
            kaisu-=2;
        }
    }
    if(kaisu==4){
        if([hantei length]==4){
            dot4.alpha=1;
            pass = tf.text;
            CFBundleRef mainBundle;
            mainBundle = CFBundleGetMainBundle ();
            
            soundURL  = CFBundleCopyResourceURL (mainBundle,CFSTR ("click"),CFSTR ("mp3"),NULL);
            AudioServicesCreateSystemSoundID (soundURL, &soundID);
            CFRelease (soundURL);
            AudioServicesPlaySystemSound (soundID);
            if(settei==NO){
                if([pass isEqualToString:seikaipass]){
                    TapPassViewController *nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VC1"];
                    [self.navigationController pushViewController:nextViewController animated:YES];
                }else{
                    dot.alpha=0;
                    dot2.alpha=0;
                    dot3.alpha=0;
                    dot4.alpha=0;
                    [self performSelector:@selector(shakeView) withObject:nil];
                    kaisu=0;
                    tf.text=@"";
                    lb.text=@"パスコードが違います";
                    mistaken++;
                    if(mistaken>3){
                        lb.textColor=[UIColor redColor];
                    }
                    if(mistaken==5){
                        lb.textColor=[UIColor whiteColor];
                        tf.hidden=YES;
                        circle.alpha=0;
                        circle2.alpha=0;
                        circle3.alpha=0;
                        circle4.alpha=0;
                        [tf resignFirstResponder];
                        lb.text=@"このアプリは一定期間\nロックされます";
                    }
                }
            }else{
                if(kakunin==NO){
                    dot.alpha=0;
                    dot2.alpha=0;
                    dot3.alpha=0;
                    dot4.alpha=0;
                    kaisu=0;
                    lb.text=@"確認";
                    seikaipass = tf.text;
                    tf.text=@"";
                    kakunin=YES;
                }else{
                    if([tf.text isEqualToString:seikaipass]){
                        [store setObject:seikaipass forKey:@"passcode"];
                        [store synchronize];
                        NSLog(@"%@",seikaipass);
                        
                        TapPassViewController *nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VC1"];
                        [self.navigationController pushViewController:nextViewController animated:YES];
                    }else{
                        kakunin = NO;
                        lb.text = @"最初から";
                        dot.alpha = 0.0;
                        dot2.alpha = 0.0;
                        dot3.alpha = 0.0;
                        dot4.alpha = 0.0;
                        [self performSelector:@selector(shakeView) withObject:nil];
                        kaisu = 0;
                        tf.text = @"";
                    }
                }
            }
        }else{
            [self performSelector:@selector(fadeout) withObject:nil];
            kaisu-=2;
        }
    }
}

-(void)fadeout{
    //アニメーションの設定
    [UIView beginAnimations:@"fadeIn" context:nil];
    //アニメーション変化の仕方
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    // 3秒かけてアニメーションを終了させる
    [UIView setAnimationDuration:0.3];
    if(kaisu==4){
        dot3.alpha = 0;
    }
    if(kaisu==3){
        dot2.alpha = 0;
    }
    if(kaisu==2){
        dot.alpha = 0;
    }
    // アニメーション終了
    [UIView commitAnimations];
}

-(void)shakeView {
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.08];
    [shake setRepeatCount:2];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(circle.center.x - 10,circle.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(circle.center.x + 10, circle.center.y)]];
    [circle.layer addAnimation:shake forKey:@"position"];
    
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(circle2.center.x - 10,circle2.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(circle2.center.x + 10, circle2.center.y)]];
    [circle2.layer addAnimation:shake forKey:@"position"];
    
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(circle3.center.x - 10,circle3.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(circle3.center.x + 10, circle3.center.y)]];
    [circle3.layer addAnimation:shake forKey:@"position"];
    
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(circle4.center.x - 10,circle4.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(circle4.center.x + 10, circle4.center.y)]];
    [circle4.layer addAnimation:shake forKey:@"position"];
}

@end
