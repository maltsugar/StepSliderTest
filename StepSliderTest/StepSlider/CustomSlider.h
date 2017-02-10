//
//  CustomSlider.h
//  StepSliderTest
//
//  Created by zgy on 2017/2/10.
//  Copyright © 2017年 zgy. All rights reserved.
//  此view高度为 底部slider高度 + 上部labels高度 (底部slider高度为 所有圈中最大直径)
//  此view高度为 底部slider高度 + 上部labels高度 (底部slider高度为 所有圈中最大直径)
//  此view高度为 底部slider高度 + 上部labels高度 (底部slider高度为 所有圈中最大直径)
#import <UIKit/UIKit.h>
#import "StepSlider.h"

@interface CustomSlider : UIView

@property (nonatomic, strong) StepSlider *slider;

@property (nonatomic, strong) UIFont *normalFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *normalBackgroundColor;


@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIFont *selectedFont;


- (instancetype)initWithTitles:(NSArray *)titles shouldAnmating:(BOOL)animate;


- (void)setTitles:(NSArray *)titles shouldAnmating:(BOOL)animate;

@end
