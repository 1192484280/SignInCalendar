//
//  CalendarSignInFooterView.h
//  CalendarDemo
//
//  Created by RYX on 2019/1/10.
//  Copyright © 2019 tuobu. All rights reserved.
//

#import <UIKit/UIKit.h>

//无返回
typedef void (^tapBlock)(void);

@interface CalendarSignInFooterView : UIView

@property (nonatomic,copy) tapBlock tapBlock;

@end


