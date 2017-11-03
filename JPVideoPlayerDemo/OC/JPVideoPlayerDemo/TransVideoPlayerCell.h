//
//  TransVideoPlayerCellTableViewCell.h
//  JPVideoPlayerDemo
//
//  Created by lijian on 2017/11/145.
//  Copyright © 2017年 NewPan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, JPPlayUnreachCellStyle) {
    JPPlayUnreachCellStyleNone = 1 << 0,  // normal 播放滑动可及cell
    JPPlayUnreachCellStyleUp = 1 << 1,    // top 顶部不可及
    JPPlayUnreachCellStyleDown = 1<< 2    // bottom 底部不可及
};

@interface TransVideoPlayerCell : UITableViewCell

@property (nonatomic,strong) UIImageView *videoImv; // 视频占位图

@property (nonatomic,strong) UIImageView *playBtnView;

/** videoPath */
@property(nonatomic, strong)NSString *videoPath;

/** indexPath */
@property(nonatomic, strong)NSIndexPath *indexPath;

/** cell类型 */
@property(nonatomic, assign)JPPlayUnreachCellStyle cellStyle;

- (void)setFeed;

@end
