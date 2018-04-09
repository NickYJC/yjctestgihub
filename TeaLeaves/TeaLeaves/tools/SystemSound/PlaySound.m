//
//  PlaySound.m
//  TeaLeaves
//
//  Created by 张美文 on 15/12/4.
//  Copyright © 2015年 walter. All rights reserved.
//

#import "PlaySound.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PlaySound()
{
    SystemSoundID sound;//系统声音的id 取值范围为：1000-2000
}

@end

@implementation PlaySound

- (instancetype)initWithSoundResource:(NSString *)soundName soundType:(NSString *)soundType repeatTime:(NSUInteger)numLoop{
    if (self = [super init]) {
        [self prepPlayerSoundName:soundName andType:soundType repeat:numLoop];
    }
    
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)systemSoundList{
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    // 读取条件
    MPMediaPropertyPredicate *albumNamePredicate =
    [MPMediaPropertyPredicate predicateWithValue:[NSNumber numberWithInt:MPMediaTypeMusic ] forProperty: MPMediaItemPropertyMediaType];
    [everything addFilterPredicate:albumNamePredicate];
    
    NSArray *itemsFromGenericQuery = [everything items];
    for (MPMediaItem *song in itemsFromGenericQuery) {
        NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
        NSLog (@"获取到的音乐：%@", songTitle);
    }
}

- (BOOL)prepPlayerSoundName:(NSString *)name andType:(NSString *)type repeat:(NSUInteger)numLoop{
    NSError *error;
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return NO;
    }
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
    if (!self.player) {
        NSLog(@"error:%@", [error localizedDescription]);
        return NO;
    }
    
    [self.player prepareToPlay];
    if (numLoop == kPlaySoundTypeOnce) {
        [self.player setNumberOfLoops:1];
    }else{
        [self.player setNumberOfLoops:-1];
        switch (numLoop) {
            case kPlaySoundTypeOneMinite:{
                //
                [self repeatTimer:60];
                break;
            }
            case kPlaySoundTypeFiveMinite:{
                //
                [self repeatTimer:300];
                break;
            }
            default:
                break;
        }
    }
    
//    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    
    return YES;
}

- (void)play{
    [self.player play];
}

- (void)pause{
    [self.player pause];
}

- (void)stop{
    self.player.currentTime = 0;
    [self.player stop];
}

- (void)repeatTimer:(int)timer{
    
    __block int timeout=timer; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self stop];
            });
        }else{
//            int seconds = timeout % (timer+1);
//            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);

}

- (id)initSystemShake
{
    self = [super init];
    if (self) {
        sound = kSystemSoundID_Vibrate;//震动
    }
    return self;
}

- (id)initSystemSoundWithName:(NSString *)soundName SoundType:(NSString *)soundType
{
    self = [super init];
    if (self) {
        NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",soundName,soundType];
//        [[NSBundle bundleWithIdentifier:@"com.apple.UIKit" ] pathForResource:soundName ofType:soundType];//得到苹果框架资源UIKit.framework ，从中取出所要播放的系统声音的路径
//        [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];  //获取自定义的声音
        if (path) {
            
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
        }
        
    }
    return self;
}

- (void)playSystemSound
{
    AudioServicesPlaySystemSound(sound);
}
@end
