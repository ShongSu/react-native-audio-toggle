//
//  RNAudioToggle.m
//  RNAudioToggle
//
//  Created by Michel Paquet on 2017-12-14.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNAudioToggle.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@implementation RNAudioToggle

// The React Native bridge needs to know our module
RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport {
    return @{@"greeting": @"Test AudioToggle Component!"};
}

RCT_EXPORT_METHOD(setAudioMode:(NSString *)mode) {
    
    NSError* __autoreleasing err = nil;
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_None;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if ([mode isEqualToString:@"earpiece"]) {
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&err];
        audioRouteOverride = kAudioSessionProperty_OverrideCategoryDefaultToSpeaker;
        AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(audioRouteOverride), &audioRouteOverride);
    } else if ([mode isEqualToString:@"speaker"] || [mode isEqualToString:@"ringtone"]) {
        [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:&err];
    } else if ([mode isEqualToString:@"normal"]) {
        [session setCategory:AVAudioSessionCategorySoloAmbient error:&err];
    }
}

@end
