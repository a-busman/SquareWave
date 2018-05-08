//
//  ViewController.m
//  Square Wave
//
//  Created by Alex Busman on 5/5/18.
//  Copyright © 2018 Alex Busman. All rights reserved.
//

#import "ViewController.h"
#import "AudioEngine.h"

@interface ViewController ()
@property AudioEngine *ae;
@property int muteMask;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"nsf"];
    _ae = [[AudioEngine alloc] init];
    [_ae setFileName: path];
    [_ae setTrack: 0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playTapped:(id)sender {
    [_ae play];
}
- (IBAction)pauseTapped:(id)sender {
    [_ae pause];
}
- (IBAction)stopTapped:(id)sender {
    [_ae stop];
}
- (IBAction)nextTapped:(id)sender {
    [_ae nextTrack];
}
- (IBAction)prevToggled:(id)sender {
    [_ae prevTrack];
}

- (IBAction)switchToggled:(id)sender {
    UISwitch *toggle = (UISwitch *)sender;
    if (!toggle.on) {
        _muteMask |= 1 << toggle.tag;
    } else {
        _muteMask &= ~(1 << toggle.tag);
    }
    [_ae setMuteVoices:_muteMask];
}

@end
