//
//  CustomSlider.m
//  StepSliderTest
//
//  Created by zgy on 2017/2/10.
//  Copyright © 2017年 zgy. All rights reserved.
//

#import "CustomSlider.h"
#import "UIView+Extension.h"

#define kTitlesLabelCenterY 12

@interface CustomSlider ()
{
    BOOL _shouldAnimating;
}
@property (nonatomic, strong) NSMutableArray *titleLabels;


@end

@implementation CustomSlider

- (instancetype)initWithTitles:(NSArray *)titles shouldAnmating:(BOOL)animate
{
    self = [super init];
    if (self) {
        _shouldAnimating = animate;
        [self initTitleLabels:titles];
    }
    return self;
}
- (instancetype)initWithCount:(NSUInteger)count
{
    self = [super init];
    if (self) {
        [self initSliderWithCount:count];
    }
    return self;
}

- (void)initTitleLabels:(NSArray *)titles
{
    _normalFont = [UIFont systemFontOfSize:12.f];
    _titleColor = [UIColor orangeColor];
    _normalBackgroundColor = [UIColor clearColor];
    _selectedBackgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    _selectedFont = [UIFont systemFontOfSize:13.f];
    
    
    for (NSString *t in titles) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = t;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.layer.cornerRadius = 2.0;
        lab.clipsToBounds = YES;
        [self addSubview:lab];
        [self.titleLabels addObject:lab];
        
        // 用户配置
        lab.font = self.normalFont;
        lab.backgroundColor = self.normalBackgroundColor;
        lab.textColor = self.titleColor;
        
        [lab sizeToFit];
        lab.width += 10;
    }
    
    [self initSliderWithCount:titles.count];
}

- (void)initSliderWithCount:(NSUInteger)count
{
    [self addSubview:self.slider];
    _slider.tintColor = [UIColor blueColor];
    _slider.trackColor = [UIColor grayColor];
    _slider.maxCount = count;
    _slider.sliderCircleRadius = 10.0; // slider高度为直径
    _slider.trackHeight = 5.0;
    _slider.sliderCircleColor = [UIColor orangeColor];
}

- (void)setTitles:(NSArray *)titles shouldAnmating:(BOOL)animate
{
    _shouldAnimating = animate;
    [self.titleLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.titleLabels removeAllObjects];
    
    [self initTitleLabels:titles];
    
    [self layoutIfNeeded];
}

- (void)setSliderCount:(NSUInteger)count
{
    [self.titleLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.titleLabels removeAllObjects];
    
    [self initSliderWithCount:count];
    
    [self layoutIfNeeded];
}

- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor
{
    _normalBackgroundColor = normalBackgroundColor;
    for (int i = 0; i < self.titleLabels.count; i ++) {
        if (i == self.slider.index) {
            continue;
        }
        UILabel *lab = self.titleLabels[i];
        lab.backgroundColor = normalBackgroundColor;
    }
    
}

- (void)setNormalFont:(UIFont *)normalFont
{
    _normalFont = normalFont;
    for (int i = 0; i < self.titleLabels.count; i ++) {
        if (i == self.slider.index) {
            continue;
        }
        UILabel *lab = self.titleLabels[i];
        lab.font = normalFont;
    }
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    for (int i = 0; i < self.titleLabels.count; i ++) {
        UILabel *lab = self.titleLabels[i];
        lab.textColor = titleColor;
    }
}

- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor
{
    _selectedBackgroundColor = selectedBackgroundColor;
    for (int i = 0; i < self.titleLabels.count; i ++) {
        if (i == self.slider.index) {
            UILabel *lab = self.titleLabels[i];
            lab.backgroundColor = self.selectedBackgroundColor;
            continue;
        }
    }
}

- (void)setSelectedFont:(UIFont *)selectedFont
{
    _selectedFont = selectedFont;
    for (int i = 0; i < self.titleLabels.count; i ++) {
        if (i == self.slider.index) {
            UILabel *lab = self.titleLabels[i];
            lab.font = self.selectedFont;
            continue;
        }
    }
}


#pragma mark- sliderAction
- (void)handleSliderAction
{
    if (_shouldAnimating) {
        [UIView beginAnimations:nil context:nil];
        for (UILabel *lab in self.titleLabels) {
            lab.font = self.normalFont;
            lab.backgroundColor = self.normalBackgroundColor;
            lab.centerY = kTitlesLabelCenterY;
        }
        
        UILabel *selectLab = self.titleLabels[self.slider.index];
        selectLab.font = self.selectedFont;
        selectLab.backgroundColor = self.selectedBackgroundColor;
        selectLab.centerY = kTitlesLabelCenterY - 3;
        [UIView commitAnimations];
    }
    
    if ([self.delegate respondsToSelector:@selector(sliderDidChanged:index:)]) {
        [self.delegate sliderDidChanged:self index:self.slider.index];
    }
}

- (void)sliderValueChangedAction
{
    if ([self.delegate respondsToSelector:@selector(sliderValueChanged:value:)]) {
        [self.delegate sliderValueChanged:self value:self.slider.index];
    }
}


#pragma mark-
- (void)layoutSubviews
{
    [super layoutSubviews];
    float width = CGRectGetWidth(self.bounds);
    float height = CGRectGetHeight(self.bounds);
    
    float maxRadius = fmaxf(_slider.sliderCircleRadius, _slider.trackCircleRadius);
    
    self.slider.frame = CGRectMake(0, 20, width, height - 20);
    
    float labW = (width - 2*maxRadius) / (self.titleLabels.count-1);
    for (int i = 0; i < self.titleLabels.count; i ++) {
        UILabel *lab = self.titleLabels[i];
        lab.centerX = i * labW + maxRadius;
        lab.centerY = kTitlesLabelCenterY;
    }
    
    
    [self handleSliderAction];
}


- (NSMutableArray *)titleLabels
{
    if (nil == _titleLabels) {
        _titleLabels = [[NSMutableArray alloc]init];
    }
    return _titleLabels;
}

- (StepSlider *)slider
{
    if (nil == _slider) {
        _slider = [[StepSlider alloc]init];
        _slider.dotsInteractionEnabled = NO;
        [_slider addTarget:self action:@selector(handleSliderAction) forControlEvents:UIControlEventTouchUpInside];
        [_slider addTarget:self action:@selector(sliderValueChangedAction) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

@end
