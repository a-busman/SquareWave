//
//  AudioEngine.m
//  Square Wave
//
//  Created by Alex Busman on 5/6/18.
//  Copyright © 2018 Alex Busman. All rights reserved.
//

#import "AudioEngine.h"

@interface AudioEngine()

@end

@implementation AudioEngine

AudioStreamBasicDescription mStreamFormat;
Boolean                     mIsPlaying;
Boolean                     mIsPaused;
NSString *                  mFileName;
AudioQueueRef               mAudioQueue;
AudioQueueBufferRef         mAudioQueueBuf;
int                         mTrack;
int                         mVoiceMask;
Music_Emu *                 mEmu;
const int                   kSampleRate = 44100;
const int                   kBufferSize = 8000;
const int                   kBufferCount = 3;

- (id)init {
    if (!(self = [super init])) return nil;
    
    [self setupFormat];
    OSStatus err = AudioQueueNewOutput(&mStreamFormat, AudioEngineOutputBufferCallback, (__bridge void * _Nullable)(self), nil, nil, 0, &mAudioQueue);
    if (err != noErr) {
        NSLog(@"AudioQueueNewOutput() error: %d", err);
        return nil;
    }
    return self;
}

- (void)setFileName:(NSString *)fileName {
    if (mEmu) {
        gme_delete(mEmu);
        mEmu = NULL;
    }
    mFileName = fileName;
    const char *path_string = [mFileName UTF8String];
    handle_error(gme_open_file(path_string, &mEmu, kSampleRate));
}

- (void)setTrack:(int)track {
    mTrack = track;
    int count = gme_track_count(mEmu);
    if (mTrack > count - 1) {
        mTrack = count - 1;
    }
    handle_error(gme_start_track(mEmu, mTrack));
}

- (void)play {
    if (!mFileName) {
        NSLog(@"No file name to play");
        return;
    }
    if (mIsPaused == NO) {
        handle_error(gme_start_track(mEmu, mTrack));
        [self setupFormat];
    }
    [self startAudioQueue];
}

- (void)pause {
    AudioQueuePause(mAudioQueue);
    mIsPaused = YES;
}

- (void)stop {
    AudioQueueStop(mAudioQueue, NO);
    mIsPlaying = NO;
    mIsPaused = NO;
}

- (void)nextTrack {
    int count = gme_track_count(mEmu);
    mTrack++;
    if (mTrack > count - 1) {
        mTrack--;
    }
    else handle_error(gme_start_track(mEmu, mTrack));
}

- (void)prevTrack {
    mTrack--;
    if (mTrack < 0) {
        mTrack++;
    }
    else handle_error(gme_start_track(mEmu, mTrack));
}

- (void)setMuteVoices:(int)mask {
    mVoiceMask = mask;
    gme_mute_voices(mEmu, mask);
}

- (void)startAudioQueue {
    if (mIsPlaying == NO) {
        OSStatus err;
        for (int i = 0; i < kBufferCount; ++i) {
            err = AudioQueueAllocateBuffer(mAudioQueue, kBufferSize, &mAudioQueueBuf);
            if (err != noErr) {
                NSLog(@"AudioQueueAllocateBuffer() error: %d", err);
                return;
            }
            
            int sampleCount = mAudioQueueBuf->mAudioDataBytesCapacity / sizeof (SInt16);
            mAudioQueueBuf->mAudioDataByteSize = sampleCount * sizeof (SInt16);
            SInt16 *rawBuf = mAudioQueueBuf->mAudioData;
            handle_error(gme_play(mEmu, sampleCount, rawBuf));
            err = AudioQueueEnqueueBuffer(mAudioQueue, mAudioQueueBuf, 0, nil);
            if (err != noErr) {
                NSLog(@"AudioQueueEnqueueBuffer() error: %d", err);
            }
        }
        mIsPlaying = YES;
        err = AudioQueueStart(mAudioQueue, nil);
        if (err != noErr) {
            NSLog(@"AudioQueueStart() error: %d", err);
            mIsPlaying = NO;
            return;
        }
    } else {
        if (mIsPaused == YES) {
            mIsPaused = NO;
            OSStatus err = AudioQueueStart(mAudioQueue, nil);
            if (err != noErr) { NSLog(@"AudioQueueStart() error: %d", err); mIsPlaying = NO; return; }
        } else {
            NSLog(@"Error: audio is already playing back.");
        }
    }
}

- (void)setupFormat {
    mStreamFormat.mSampleRate       = kSampleRate;
    mStreamFormat.mFormatID         = kAudioFormatLinearPCM;
    mStreamFormat.mFormatFlags      = kLinearPCMFormatFlagIsSignedInteger;
    mStreamFormat.mFramesPerPacket  = 1;
    mStreamFormat.mChannelsPerFrame = 2;
    mStreamFormat.mBitsPerChannel   = 16;
    mStreamFormat.mBytesPerFrame    = (mStreamFormat.mBitsPerChannel / 8) * mStreamFormat.mChannelsPerFrame;
    mStreamFormat.mBytesPerPacket   = mStreamFormat.mBytesPerFrame;
}

void AudioEngineOutputBufferCallback(void * inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inBuffer) {
    AudioEngine *engine = (__bridge AudioEngine *) inUserData;
    [engine processOutputBuffer:inBuffer queue: inAQ];
}

- (void)processOutputBuffer:(AudioQueueBufferRef)buffer queue:(AudioQueueRef)queue {
    OSStatus err;
    if (mIsPlaying == YES) {
        SInt16 *rawBuf = buffer->mAudioData;
        int sampleCount = buffer->mAudioDataBytesCapacity / sizeof (SInt16);
        handle_error(gme_play(mEmu, sampleCount, rawBuf));
        buffer->mAudioDataByteSize = sampleCount * sizeof (SInt16);
        err = AudioQueueEnqueueBuffer(queue, buffer, 0, NULL);
        if (err == 560030580) {
            mIsPlaying = NO;
        } else if (err != noErr) {
            NSLog(@"AudioQueueEnqueueBuffer() error %d", err);
        }
    } else {
        err = AudioQueueStop(queue, NO);
        if (err != noErr) NSLog(@"AudioQueueStop() error: %d", err);
    }
}

- (void)dealloc {
    if (mEmu) {
        gme_delete(mEmu);
        mEmu = NULL;
    }
}

static void handle_error(const char* str) {
    if (str) {
        NSLog(@"%@", [[NSString alloc] initWithUTF8String:str]);
    }
}
@end
