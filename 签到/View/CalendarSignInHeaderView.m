//
//  CalendarSignInHeaderView.m
//  CalendarDemo
//
//  Created by RYX on 2019/1/9.
//  Copyright © 2019 tuobu. All rights reserved.
//

#import "CalendarSignInHeaderView.h"
#import "Masonry.h"

// 判断是否是iPhone X系列
#define iPhoneX ([UIScreen mainScreen].bounds.size.height >= 812)

// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define iPhoneX_Top (iPhoneX ? 88.0f : 64.0f)
// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define iPhoneX_Bottom (iPhoneX ? 34.0f : 0.0f)

@implementation CalendarSignInHeaderView

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    self.backgroundColor = [UIColor colorWithRed:239/255.0 green:113/255.0 blue:108/255.0 alpha:1.0];;
    
//    UIButton *backBtn = [[UIButton alloc] init];
//    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
//    [self addSubview:backBtn];
    
    UILabel *titleLa = [[UILabel alloc] init];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"每日签到" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 18],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    
    titleLa.attributedText = string;
    [self addSubview:titleLa];
    
    UIButton *signInBtn = [[UIButton alloc] init];
    [signInBtn setImage:[UIImage imageNamed:@"签到"] forState:UIControlStateNormal];
    
    [signInBtn addTarget:self action:@selector(onSignInBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:signInBtn];
    
    UILabel *desLa = [[UILabel alloc] init];
    NSMutableAttributedString *desString = [[NSMutableAttributedString alloc] initWithString:@"已连续签到2天，继续加油!" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    
    desLa.attributedText = desString;
    [self addSubview:desLa];
    
//    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self).offset(15);
//        make.centerY.equalTo(titleLa);
//
//    }];
    
    [titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if (iPhoneX) {
            make.top.equalTo(self.mas_top).offset(44);
        }else{
            make.top.equalTo(self.mas_top).offset(20);
        }
        make.centerX.equalTo(self);
    
    }];
    
    [signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(titleLa.mas_bottom).offset(34);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(40);
        
    }];
    
    [desLa mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(signInBtn.mas_bottom).offset(20);
        
    }];

}

- (void)onSignInBtn:(UIButton *)sender{
    
    if ([sender.currentImage isEqual:[UIImage imageNamed:@"签到"]]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"签到咯" object:nil];
        
        [sender setImage:[UIImage imageNamed:@"已签到"] forState:UIControlStateNormal];
        
        return;
        
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您已签到" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [[self getCurrentViewController] presentViewController:alert animated:YES completion:^{
        
    }];

}

- (UIViewController *)getCurrentViewController{
    
    for (UIView *next = [self superview]; next; next= next.superview) {
        
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end
