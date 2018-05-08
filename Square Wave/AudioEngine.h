//
//  AudioEngine.h
//  Square Wave
//
//  Created by Alex Busman on 5/6/18.
//  Copyright © 2018 Alex Busman. All rights reserved.
//

#ifndef AudioEngine_h
#define AudioEngine_h

#import "gme/gme.h"

#import <AudioToolbox/AudioToolbox.h>

@interface AudioEngine : NSObject
- (void)setFileName:(NSString *)fileName;
- (void)setTrack:(int)track;
- (void)play;
- (void)pause;
- (void)stop;
- (void)nextTrack;
- (void)prevTrack;
- (void)setMuteVoices:(int)mask;
@end
#endif /* AudioEngine_h */
