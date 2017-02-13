//
//  ViewController.m
//  StepSliderTest
//
//  Created by zgy on 2017/2/10.
//  Copyright © 2017年 zgy. All rights reserved.
//

#import "ViewController.h"
#import "CustomSlider.h"

@interface ViewController ()<CustomSliderDelegate>
@property (weak, nonatomic) IBOutlet CustomSlider *sliderView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_sliderView setTitles:@[@"1", @"2", @"3", @"4", @"5", @"6", @"7"] shouldAnmating:YES];
//    [_sliderView setTitles:@[@"30分钟", @"1小时", @"1.5小时", @"2小时", @"3小时", @"4小时", @"6小时"] shouldAnmating:YES];
    _sliderView.titleColor = [UIColor orangeColor];
    _sliderView.normalBackgroundColor = [UIColor clearColor];
    _sliderView.selectedBackgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    _sliderView.delegate = self;
}

- (void)sliderDidChanged:(CustomSlider *)slider index:(NSUInteger)idx
{
    NSLog(@"%@  %d", slider, idx);
}

@end
