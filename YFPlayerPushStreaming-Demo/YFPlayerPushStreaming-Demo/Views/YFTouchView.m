//
//  YFTouchView.m
//  YFPlayerPushStreaming-Demo
//
//  Created by apple on 7/12/17.
//  Copyright © 2017 YunFan. All rights reserved.
//

#import "YFTouchView.h"
#import "Masonry.h"
#import "UIImage+Gif.h"
@interface YFTouchView()

@property (nonatomic, strong) UIButton *icon;
@property (nonatomic, strong) UIButton *theme;

@end
@implementation YFTouchView

- (instancetype)initWithIconNomal:(NSString *)nomal andSelected:(NSString *)selected andTheme:(NSString *)theme{
    
    if (self = [super init]) {
        
        self.iconStringNomal = nomal;
        self.iconStringSelected = selected;
        self.themeString = theme;
        [self setupParameter];
        
    }
    return self;
}

- (void)setupParameter{
    
    __weak typeof(self)weakSelf = self;
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(-20);
    }];
    
    [self.theme mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.mas_equalTo(20);
    }];
}

- (void)touchDownCallBackFunc:(UIButton *)sender{
    if (self.touchDownCallBack) {
        self.touchDownCallBack(self.icon,self.theme);
    }
}

- (void)touchExitcallBackFunc:(UIButton *)sender{
    if (self.touchExitCallBack) {
        self.touchExitCallBack(self.icon,self.theme);
    }
}

#pragma mark 懒加载

- (UIButton *)icon{
    if (!_icon) {
        _icon = [[UIButton alloc] init];
        [_icon setBackgroundImage:[UIImage sd_animatedGIFNamed:self.iconStringNomal] forState:UIControlStateNormal];
        [_icon setBackgroundImage:[UIImage sd_animatedGIFNamed:self.iconStringSelected] forState:UIControlStateHighlighted];
        [_icon setBackgroundImage:[UIImage sd_animatedGIFNamed:self.iconStringSelected] forState:UIControlStateSelected];
        _icon.layer.cornerRadius = 30;
        _icon.layer.masksToBounds = YES;
        [_icon addTarget:self action:@selector(touchDownCallBackFunc:) forControlEvents:UIControlEventTouchDown];
        [_icon addTarget:self action:@selector(touchExitcallBackFunc:) forControlEvents:UIControlEventTouchDragExit | UIControlEventTouchUpInside];
        
        [self addSubview:_icon];
    }
    return _icon;
}

- (UIButton *)theme{
    if (!_theme) {
        _theme = [[UIButton alloc] init];
        _theme.titleLabel.font = [UIFont systemFontOfSize:14];
        _theme.selected = NO;
        [_theme setTitleColor:[UIColor colorWithRed:0 green:228/255.0 blue:226/255.0 alpha:1] forState:UIControlStateNormal];
        [_theme setTitle:self.themeString forState:UIControlStateNormal];
//        [_theme addTarget:self action:@selector(callBackFunc:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_theme];
    }
    return _theme;
}

@end
