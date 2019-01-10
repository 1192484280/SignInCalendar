//
//  CalendarView.m
//  CalendarDemo
//
//  Created by RYX on 2019/1/9.
//  Copyright © 2019 tuobu. All rights reserved.
//

#import "CalendarView.h"
#import "FSCalendar.h"
#import "Masonry.h"

@interface CalendarView ()<FSCalendarDelegate,FSCalendarDataSource>

@property (nonatomic,strong) FSCalendar *calendar;
@property (nonatomic,strong) NSMutableArray *dateArr;

@end

@implementation CalendarView

- (NSMutableArray *)dateArr{
    
    if (!_dateArr) {
        
        _dateArr = [NSMutableArray array];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
        
        for (int i = 1; i <= 12; i++) {
            
            for (int j = 1; j <= 28 ; j++) {
                
                NSString *daystr = [NSString stringWithFormat:@"2018-%d-%d",i,j];
                NSDate *day = [dateFormatter dateFromString:daystr];
                [self.dateArr addObject:day];
            }
        }
    }
    return _dateArr;
}

- (void)setUI{

    self.layer.cornerRadius = 5;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.2f;
    self.layer.shadowRadius = 4.f;
    self.layer.shadowOffset = CGSizeMake(1,1);
    
    [self addSubview:self.calendar];
    
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
        
    }];
}

#pragma mark - 签到历史
- (void)signInHistory{
    
    for (NSDate *date in self.dateArr) {
        
        [self.calendar selectDate:date];
    }
    
    //回到今天(你需要去到的时间date和是否显示动画)
    [self.calendar setCurrentPage:[NSDate date] animated:YES];
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self setUI];
        
        [self signInHistory];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signIn:) name:@"签到咯" object:nil];
    }
    return self;
}

- (void)signIn:(NSNotification *)noti{
    
    
    [self.calendar selectDate:[NSDate date]]; // 设置默认选中日期是今天
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (FSCalendar *)calendar {
    if (!_calendar) {
        //日历控件初始化
        _calendar = [[FSCalendar alloc] init];
        //设置是否用户多选
        _calendar.allowsMultipleSelection = YES;
        // 设置代理
        _calendar.layer.cornerRadius = 5;
        _calendar.delegate = self;
        _calendar.dataSource = self;
        _calendar.firstWeekday = 2;     //设置周一为第一天
        _calendar.appearance.weekdayTextColor = [UIColor blackColor];
        //        _calendar.appearance.weekdayFont = FONT_18;
        _calendar.appearance.headerTitleColor = [UIColor blackColor];
        _calendar.appearance.titleDefaultColor = [UIColor darkGrayColor];
        //        _calendar.appearance.titleFont = FONT_18;
        //        _calendar.appearance.subtitleDefaultColor = [UIColor greenColor];
//        _calendar.appearance.eventDefaultColor = [UIColor redColor];
//        _calendar.appearance.eventSelectionColor = [UIColor blueColor];
        _calendar.appearance.selectionColor = [UIColor colorWithRed:239/255.0 green:113/255.0 blue:108/255.0 alpha:1.0];
        _calendar.appearance.headerDateFormat = @"yyyy-MM";
        _calendar.appearance.todayColor = [UIColor lightGrayColor];
        _calendar.appearance.titleTodayColor = [UIColor whiteColor];
        _calendar.appearance.borderRadius = 1.0;  // 设置当前选择是圆形,0.0是正方形
        _calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
        _calendar.backgroundColor = [UIColor whiteColor];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
        _calendar.locale = locale;  // 设置周次是中文显示
        //        _calendar.headerHeight = 0.0f; // 当不显示头的时候设置
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;  // 设置周次为一,二
//        _calendar.placeholderType = FSCalendarPlaceholderTypeFillHeadTail; //月份模式时，只显示当前月份
        _calendar.placeholderType = FSCalendarPlaceholderTypeNone;
        
    }
    return _calendar;
}

#pragma mark - FSCalendarDelegate,FSCalendarDataSource
- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date{
    
    if ([self.calendar isDateInToday:date]) {
        
        return @"今";
        
    }
    return nil;
    
}

//设置选中日期的border颜色
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderSelectionColorForDate:(NSDate *)date {
    
    return [UIColor whiteColor];
    
}

//最大时间今天
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar{
    
    return [NSDate date];
    
}

// 未签到的不可点击
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{

    return NO;
}

// 已签到的不可点击
- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    
    return NO;
}
@end
