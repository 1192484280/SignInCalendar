//
//  CalendarSignInFooterView.m
//  CalendarDemo
//
//  Created by RYX on 2019/1/10.
//  Copyright © 2019 tuobu. All rights reserved.
//

#import "CalendarSignInFooterView.h"
#import "Masonry.h"

@implementation CalendarSignInFooterView

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    self.backgroundColor = UIColor.whiteColor;
    
    self.layer.cornerRadius = 5;
    
    UILabel *la = [[UILabel alloc] init];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"积分兑换" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    la.attributedText = string;
    [self addSubview:la];
    
    UILabel *btnLa = [[UILabel alloc] init];
    NSString *str2 = @"您当前拥有520积分，点击兑换";
    NSMutableAttributedString *attStr2 = [[NSMutableAttributedString alloc] initWithString:str2 attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    
    [attStr2 addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:12/255.0 green:166/255.0 blue:240/255.0 alpha:1.0]} range:NSMakeRange(str2.length - 4, 4)];
    
    btnLa.attributedText = attStr2;
    [self addSubview:btnLa];
    btnLa.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [btnLa addGestureRecognizer:tap];
    
    
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(20);
    }];
    
    [btnLa mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(la.mas_bottom).offset(15);
    }];
    
}

- (void)onTap:(UITapGestureRecognizer *)tap{

    if (self.tapBlock != nil) {
        
        self.tapBlock();
    }
    
}
@end
