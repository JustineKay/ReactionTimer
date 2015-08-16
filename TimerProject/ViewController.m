//
//  ViewController.m
//  TimerProject
//
//  Created by Justine Gartner on 8/15/15.
//  Copyright (c) 2015 Justine Gartner. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIView *redGreenView;
@property (weak, nonatomic) IBOutlet UILabel *bestTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestTimeNumeralLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *reactionButton;




@property (nonatomic) NSTimer *timer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.startButton.hidden = NO;
    self.reactionButton.hidden = YES;
    self.reactionButton.layer.cornerRadius = 150;
    
    self.timerLabel.text = @"0";
    self.timerLabel.hidden = YES;
    
    self.redGreenView.layer.cornerRadius = 150;
    self.redGreenView.hidden = YES;
    
    self.bestTimeLabel.hidden = YES;
    self.bestTimeNumeralLabel.hidden = YES;
    

}

-(void)setReactionTimer{

    NSTimer *timer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timer = timer;
    
}

-(void)setRedViewTimer{
    
    //The line below: pick a random number no less than 1.2, no greater than 5.2
    //arc4random_uniform(4) + 1.2;
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:arc4random_uniform(4) + 1.2 target:self selector:@selector(redTimerFired:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timer = timer;
    
    NSLog(@"red timer ticking");
    
}

-(void)timerFired:(NSTimer *)timer{
    
    CGFloat currentNumber = [self.timerLabel.text floatValue];
    CGFloat nextNumber = currentNumber + 0.01;
    
    self.timerLabel.text = [NSString stringWithFormat:@"%.2f", nextNumber];
    
    if (nextNumber == 100.01){
        
        [timer invalidate];
    }
    
    NSLog(@"reaction timer ticking");
    
}

-(void)redTimerFired:(NSTimer *)timer{
    
    [timer invalidate];
    [self goTime];
}


- (IBAction)startButtonTapped:(UIButton *)sender {
    
    self.startButton.hidden = YES;
    self.redGreenView.backgroundColor = [UIColor redColor];
    self.redGreenView.hidden = NO;
    self.timerLabel.hidden = YES;
    self.timerLabel.text = @"0.0";
    
    [self setRedViewTimer];
    
}

-(void)goTime{
    
    self.redGreenView.backgroundColor = [UIColor greenColor];
    self.timerLabel.hidden = NO;
    self.timerLabel.text = @"0.0";
    
    [self setReactionTimer];
    self.reactionButton.hidden = NO;
    
}

- (IBAction)reactionButtonTapped:(UIButton *)sender {
    
    [self.timer invalidate];
    
    CGFloat bestTime = [self.bestTimeNumeralLabel.text floatValue];
    CGFloat currentTime = [self.timerLabel.text floatValue];
    
    if (currentTime < bestTime || !bestTime) {
        
        bestTime = currentTime;
        self.bestTimeNumeralLabel.text = [NSString stringWithFormat:@"%.2f", bestTime];
    }
    
    self.bestTimeLabel.hidden = NO;
    self.bestTimeNumeralLabel.hidden = NO;
    
    self.reactionButton.hidden = YES;
    self.startButton.hidden = NO;
    self.redGreenView.hidden = YES;
    
}


@end
