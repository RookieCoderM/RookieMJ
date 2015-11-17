//
//  ViewController.m
//  环保型音乐播放器
//
//  Created by mj on 15/11/17.
//  Copyright © 2015年 BeastsStorm Technology. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController () <AVAudioPlayerDelegate>
@property (strong, nonatomic) IBOutlet UIProgressView *myProgress;
@property (weak, nonatomic) IBOutlet UISlider *myJindu;
@property (weak, nonatomic) IBOutlet UISlider *myVolume;
@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (nonatomic,strong)AVAudioPlayer*myPlayer;
- (IBAction)changeVolume:(UISlider *)sender;
- (IBAction)changeJindu:(UISlider *)sender;
- (IBAction)didBtnClicked:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 找到音乐路径
    NSString*mp3 = [[NSBundle mainBundle]pathForResource:@"十面埋伏" ofType:@"mp3"];
    
    // 将字符串路径转换为URL链接
    NSURL *url = [NSURL fileURLWithPath:mp3];
    
    //  创建播放器对象并添加歌曲
    self.myPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    self.totalTime.text = [NSString stringWithFormat:@"%g",self.myPlayer.duration];
    
    // 设置最大最小音量
    self.myVolume.minimumValue = 0;
    self.myVolume.maximumValue = 100;
    
    // 设置最大最小播放进度
    self.myJindu.minimumValue = 0;
    self.myJindu.maximumValue = 100;
    
     //实时刷新进度条
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self  selector:@selector(bofang) userInfo:nil repeats:YES];
//    [timer fire];
    
    // 设置观察者
    [self.myPlayer addObserver:self forKeyPath:@"currentTime" options:NSKeyValueObservingOptionNew context:nil];
    
    

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{


    NSLog(@"--%f",self.myPlayer.currentTime);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 设置音量
- (IBAction)changeVolume:(UISlider *)sender {
    self.myPlayer.volume = sender.value;
}

// 设置播放进度
- (IBAction)changeJindu:(UISlider *)sender {
    float a = (sender.value) /(self.myJindu.maximumValue);
    NSLog(@"%g",a);
    self.myPlayer.currentTime = a*self.myPlayer.duration;
    
}

- (IBAction)didBtnClicked:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"播放"]) {
        [self.myPlayer play];
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        self.myProgress.progress = self.myPlayer.currentTime/self.myPlayer.duration;
        
    }else if ([sender.currentTitle isEqualToString:@"暂停"])
    {
        [self.myPlayer pause];
        [sender setTitle:@"播放" forState:UIControlStateNormal];
    }

}

- (void)bofang
{
    
    [self.myProgress setProgress:self.myPlayer.currentTime/self.myPlayer.duration animated:YES];
}

// 观察者
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"aaa");
    [self.myProgress setProgress:self.myPlayer.currentTime/self.myPlayer.duration animated:YES];
}

@end
