//
//  PlaySound.h
//  TeaLeaves
//
//  Created by 张美文 on 15/12/4.
//  Copyright © 2015年 walter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface PlaySound : NSObject
@property (nonatomic, strong) AVAudioPlayer *player;
- (instancetype)initWithSoundResource:(NSString *)soundName soundType:(NSString *)soundType repeatTime:(NSUInteger)numLoop;
- (void)play;
- (void)pause;
- (void)stop;

- (id)initSystemShake;
- (id)initSystemSoundWithName:(NSString *)soundName SoundType:(NSString *)soundType;
- (void)playSystemSound;

@end
