//
//  ViewController.m
//  SKVideoPlay
//
//  Created by AY on 2017/10/28.
//  Copyright © 2017年 xunli. All rights reserved.
//

#import "ViewController.h"
#import "FullViewController.h"
#import "VideoPlayView.h"
#import "AppDelegate.h"

@interface ViewController ()<VideoPlayViewDelegate>

@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,strong)VideoPlayView *playView;
/**  全屏播放的界面*/
@property (nonatomic, strong) FullViewController *fullVc;



@end

@implementation ViewController
#pragma mark 0- 懒加载代码
- (FullViewController *)fullVc
{
    if (_fullVc == nil) {
        self.fullVc = [[FullViewController alloc] init];
    }
    
    return _fullVc;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	
	// 一旦进入此界面 允许程序横屏播放

	AppDelegate *delegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
	
	delegate.allowRotation = YES;
	
	
    // 创建一个 imageview  ，你要播放视频界面的大小

    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.width * 9/16)];
    _imageView.userInteractionEnabled = YES;
    
    [self.view addSubview:_imageView];
    
    
    // 创建videoView
    VideoPlayView *videoView = [VideoPlayView videoPlayView];
    videoView.frame = self.imageView.bounds;
    videoView.delegate = self;
    [self.imageView addSubview:videoView];
    _playView = videoView;

	
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

	NSString *path = [[NSBundle mainBundle]pathForResource:@"register_guide_video.mp4" ofType:nil];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:path]];

    
    [self.playView setPlayerItem:item];
}


- (void)videoplayViewSwitchOrientation:(BOOL)isFull
{
    // 屏幕翻转的时候应该禁止动画
    if (isFull) {
        [self presentViewController:self.fullVc animated:NO completion:^{
            self.playView.frame = self.fullVc.view.bounds;
            [self.fullVc.view addSubview:self.playView];
        }];
    } else {
        [self.fullVc dismissViewControllerAnimated:NO completion:^{
            self.playView.frame = CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
            [self.view addSubview:self.playView];
        }];
    }
}

#pragma mark - 懒加载代码


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
