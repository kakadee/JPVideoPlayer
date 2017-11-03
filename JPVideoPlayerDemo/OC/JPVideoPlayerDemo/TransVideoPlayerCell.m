//
//  TransVideoPlayerCellTableViewCell.m
//  JPVideoPlayerDemo
//
//  Created by lijian on 2017/11/145.
//  Copyright © 2017年 NewPan. All rights reserved.
//

#import "TransVideoPlayerCell.h"
#import "UIView+WebVideoCache.h"
#import "Masonry.h"

#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define kBigVideoCellVideoHeight (SCREEN_WIDTH*338/600)

@interface TransVideoPlayerCell()<JPVideoPlayerDelegate>

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *locationLabel;
@property (nonatomic,strong) UILabel *tagLabel;
@property (nonatomic,strong) UILabel *commentNumLabel;

//@property (nonatomic,strong) UIImageView *videoImv; // 视频占位图
@property (nonatomic,strong) UIImageView *locationIconImv; // 位置图标
@property (nonatomic,strong) UIImageView *commentIconImv; // 评论图标
//@property (nonatomic,strong) UIImageView *playBtnImv; // 播放按钮图标
@property (nonatomic,strong) UIImageView *seperateLine; // 分割线

@end

@implementation TransVideoPlayerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        [self setupConstraints];
        self.videoImv.jp_videoPlayerDelegate = self;
    }
    return self;
}

- (void)setupViews {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
    
    _locationLabel = [[UILabel alloc] init];
    _locationLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    _locationLabel.textColor = [UIColor colorWithRed:0/255.0 green:187/255.0 blue:220/255.0 alpha:1/1.0];
    [_locationLabel sizeToFit];
    [self.contentView addSubview:self.locationLabel];
    
    _tagLabel = [[UILabel alloc] init];
    _tagLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    _tagLabel.textColor = [UIColor grayColor];
    [_tagLabel sizeToFit];
    [self.contentView addSubview:self.tagLabel];
    
    _commentNumLabel = [[UILabel alloc] init];
    _commentNumLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    _commentNumLabel.textColor = [UIColor blackColor];
    [_commentNumLabel sizeToFit];
    [self.contentView addSubview:self.commentNumLabel];
    
    _locationIconImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LocationIcon"]];
    [self.contentView addSubview:self.locationIconImv];
    
    _commentIconImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CommentIcon"]];
    [self.contentView addSubview:self.commentIconImv];
    
    _seperateLine = [[UIImageView alloc] init];
    _seperateLine.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1/1.0];
    [self.contentView addSubview:self.seperateLine];
    
    
    _videoImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeHolder"]];
    _videoImv.layer.cornerRadius = 6.f;
    _videoImv.layer.masksToBounds = YES;
    [self.contentView addSubview:self.videoImv];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    
    _playBtnView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play"]];
    [_playBtnView setBackgroundColor:[UIColor redColor]];
    [self.contentView addSubview:self.playBtnView];
}

- (void)setupConstraints {
    
    [self.videoImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(24);
        make.top.mas_equalTo(35);
        make.trailing.mas_equalTo(-24);
        make.height.equalTo(self.videoImv.mas_width).multipliedBy(9.0f/16);
    }];
    
    [self.playBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.videoImv);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.videoImv);
        make.top.mas_equalTo(self.videoImv.mas_bottom).mas_offset(20);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).mas_offset(-31);
    }];
    
    [self.locationIconImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.videoImv);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(18);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(13);
        make.bottom.mas_equalTo(-30);
    }];
    
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.locationIconImv.mas_trailing).mas_offset(3);
        make.centerY.equalTo(self.locationIconImv);
    }];
    
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.locationLabel.mas_trailing).mas_offset(3);
        make.centerY.equalTo(self.locationIconImv);
    }];
    
    [self.commentIconImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).mas_offset(-43);
        make.centerY.equalTo(self.locationIconImv);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(14);
    }];
    
    [self.commentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.commentIconImv.mas_trailing).mas_offset(5);
        make.centerY.equalTo(self.locationIconImv);
    }];
    
    [self.seperateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(24);
        make.trailing.mas_equalTo(-24);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(self.locationIconImv.mas_bottom).mas_offset(29);
    }];
}

- (void)setFeed {
    self.titleLabel.text = @"阿姆斯特丹也被旅游业弄的头大，政府的办法是提高旅游税收";
    self.locationLabel.text = @"荷兰";
    self.tagLabel.text = @"城市、旅游不容易";
    self.commentNumLabel.text = @"34";
}

#pragma mark - JPVideoPlayerDelegate
- (BOOL)videoPlayerManager:(JPVideoPlayerManager *)videoPlayerManager shouldAutoReplayForURL:(NSURL *)videoURL{
    // do something here.
    return NO;
}

- (BOOL)videoPlayerManager:(JPVideoPlayerManager *)videoPlayerManager shouldDownloadVideoForURL:(NSURL *)videoURL{
    // do something here.
    return YES;
}

- (BOOL)shouldProgressViewOnTop{
    return YES;
}

@end
