//
//  NowPlayingViewController.h
//  Square Wave
//
//  Created by Alex Busman on 5/8/18.
//  Copyright © 2018 Alex Busman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrubBar.h"
#import "MarqueeLabel.h"

@interface NowPlayingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *albumArtImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleSmallLabel;
@property (weak, nonatomic) IBOutlet UIView *playPauseSmallView;
@property (weak, nonatomic) IBOutlet UIView *nextTrackSmallView;
@property (weak, nonatomic) IBOutlet UIButton *playPauseSmallButton;
@property (weak, nonatomic) IBOutlet UIButton *nextTrackSmallButton;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *visualEffectView;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *nextTrackButton;
@property (weak, nonatomic) IBOutlet UIButton *prevTrackButton;
@property (weak, nonatomic) IBOutlet UIImageView *volumeDownImageView;
@property (weak, nonatomic) IBOutlet UIImageView *volumeUpImageView;
@property (weak, nonatomic) IBOutlet UISlider *fakeVolumeSlider;
@property (weak, nonatomic) IBOutlet ScrubBar *scrubBarSlider;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeRemainingLabel;
@property (weak, nonatomic) IBOutlet UIView *dividingLineView;

@property (weak, nonatomic) IBOutlet UILabel *shuffleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shuffleImage;
@property (weak, nonatomic) IBOutlet UIView *shuffleView;

@property (weak, nonatomic) IBOutlet UILabel *repeatLabel;
@property (weak, nonatomic) IBOutlet UIImageView *repeatImage;
@property (weak, nonatomic) IBOutlet UIView *repeatView;

@property (weak, nonatomic) IBOutlet MarqueeLabel *titleMarquee;
@property (weak, nonatomic) IBOutlet MarqueeLabel *gameMarquee;

@property (weak, nonatomic) IBOutlet UIButton *thumbsUpButton;
@property (weak, nonatomic) IBOutlet UIButton *thumbsDownButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *albumArtLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *albumArtTrailingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *albumArtTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundAlbumArtWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundAlbumArtHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrubBarWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrubBarBottomConstraint;

@property (weak, nonatomic) IBOutlet UIView *volumeViewPlaceholder;
@property (weak, nonatomic) IBOutlet UIView *airPlayViewPlaceholder;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *currentTimeTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeRemainingTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thumbsDownTrailingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *prevTrackTrailingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextTrackLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thumbsUpLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *volumeWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *handleView;
@end
