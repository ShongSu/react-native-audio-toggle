//
//  RNAudioToggle.m
//  RNAudioToggle
//
//  Created by ShongSu on 2017-12-14.    - -!
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNAudioToggle.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@implementation RNAudioToggle

// The React Native bridge needs to know our module
RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport {
    NSString *category = [[AVAudioSession sharedInstance] category];
    return @{
             @"module": @"AudioToggle",
             @"category": category,
             };
}

RCT_EXPORT_METHOD(setAudioMode:(NSString *)mode) {

    AVAudioSession* session = [AVAudioSession sharedInstance];

    if (mode != nil) {
        if ([mode isEqualToString:@"speaker"]) {
            [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
            [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];
        } else if ([mode isEqualToString:@"earpiece"]){
            [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
            [session overrideOutputAudioPort:AVAudioSessionPortOverrideNone error:nil];
        } else {
            [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
        }

    }
}

RCT_EXPORT_METHOD(reset) {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategorySoloAmbient error:nil];
}

RCT_EXPORT_METHOD(getCategory:(RCTResponseSenderBlock)callback) {
    NSString *category = [[AVAudioSession sharedInstance] category];
    callback(@[category, @(true)]);
}

@end
