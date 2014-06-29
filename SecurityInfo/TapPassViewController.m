//
//  TapPassViewController.m
//  SecurityInfo
//
//  Created by Minami Sophia Aramaki on 2013/10/14.
//  Copyright (c) 2013年 Minami Sophia Aramaki. All rights reserved.
//

#import "TapPassViewController.h"

@interface TapPassViewController ()

@end

@implementation TapPassViewController

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
	// Do any additional setup after loading the view.
    
    tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(view_Tapped:)];
    
    // ビューにジェスチャーを追加
    [img addGestureRecognizer:tapGesture];
    
    store = [NSUserDefaults standardUserDefaults];
    NSString *key;
    for (int i=0; i<5; i++) {
        key=[NSString stringWithFormat:@"tapkey%d",i];
        seikaitime[i] = [store floatForKey:key];
        [store synchronize];
        NSLog(@"%.2f",seikaitime[i]);
    }
    if(!seikaitime[4]){
        first=YES;
        lb.text=@"タップコードを設定";
        lb2.hidden=NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)view_Tapped:(UITapGestureRecognizer *)sender
{
    if(!first){
        if(tapped){
            taptime[kaisu]=time;
            kaisu++;
            if(kaisu==5){
                [timer invalidate];
                
                BOOL machigai=NO;
                for (int i=0; i<5; i++) {
                    if(fabs(taptime[i]-seikaitime[i])>0.3){
                        machigai=YES;
                        //NSLog(@"誤差: %.2f",fabs(taptime[i]-seikaitime[i]));
                    }
                }
                if(machigai){
                    [self performSelector:@selector(shakeView) withObject:nil];
                    kaisu=0;
                    tapped=NO;
                    NSLog(@"NO");
                    [timer invalidate];
                    time=0;
                }else{
                    //通過
                    NSLog(@"OK");
                    [timer invalidate];
                    
                    TabViewController *mycontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"VC2"];
                    mycontroller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    [self presentViewController:mycontroller animated:YES completion:nil];
                }
            }
        }else{
            timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(up) userInfo:nil repeats:YES];
            tapped=YES;
            kaisu++;
        }
        [self performSelector:@selector(fadehamon) withObject:nil];
    }else{
        lb2.hidden=YES;
        
        if(tapped){
            if(kakunin){
                taptime[kaisu]=time;
            }else{
                kakunintime[kaisu]=time;
            }
            kaisu++;
            if(kaisu == 5){
                [timer invalidate];
                if(kakunin){
                    BOOL machigai=NO;
                    for (int i=0; i<5; i++) {
                        if(fabs(taptime[i]-kakunintime[i])>0.3){
                            machigai=YES;
                        }
                    }
                    if(machigai){
                        [self performSelector:@selector(shakeView) withObject:nil];
                        kaisu=0;
                        tapped=NO;
                        [timer invalidate];
                        time=0;
                        kakunin=NO;
                        NSLog(@"kakuninNO");
                    }else{
                        //通過
                        NSLog(@"kakuninOK");
                        
                        [timer invalidate];
                        time=0;
                        
                        NSString *key;
                        for (int i=0; i<5; i++) {
                            key=[NSString stringWithFormat:@"tapkey%d",i];
                            [store setFloat:kakunintime[i] forKey:key];
                            [store synchronize];
                        }
                        
                        TabViewController *mycontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"VC2"];
                        mycontroller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                        [self presentViewController:mycontroller animated:YES completion:nil];
                    }
                }else{
                    kakunin=YES;
                    lb.text=@"確認";
                    [timer invalidate];
                    kaisu=0;
                    time=0;
                    tapped=NO;
                }
            }
        }else{
            timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(up) userInfo:nil repeats:YES];
            tapped=YES;
            kaisu++;
        }
        
        [self performSelector:@selector(fadehamon) withObject:nil];
    }
}

-(void)fadehamon{
    CGPoint location = [tapGesture locationInView:img];
    
    UIImage *img2 = [UIImage imageNamed:@"hamon 2.png"];
    CGRect rect = CGRectMake(location.x-80, location.y-70, 150, 150);
    hamon = [[UIImageView alloc] initWithFrame:rect];
    hamon.image=img2;
    [img addSubview:hamon];
    
    // 拡大縮小を設定
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.duration = 1; // アニメーション速度
    animation.repeatCount = 1; // 繰り返し回数
    
    animation.fromValue = [NSNumber numberWithFloat:0.2]; // 開始時の倍率
    animation.toValue = [NSNumber numberWithFloat:1.2]; // 終了時の倍率
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [hamon.layer addAnimation:animation forKey:@"scale-layer"];
    
    [UIView beginAnimations:@"fadeOut" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    hamon.alpha=0;
    [UIView commitAnimations];
}

-(void)up{
    time += 0.1;
}

-(void)shakeView {
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.08];
    [shake setRepeatCount:2];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(img.center.x - 10,img.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(img.center.x + 10, img.center.y)]];
    [img.layer addAnimation:shake forKey:@"position"];
    
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(lb.center.x - 10,lb.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(lb.center.x + 10, lb.center.y)]];
    [lb.layer addAnimation:shake forKey:@"position"];
}

@end
