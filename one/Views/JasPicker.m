//
//  JasPicker.m
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "JasPicker.h"


typedef enum {
    ArrayType = 0,     //单列
    DictionaryType,  //双列联动
    DateType,        //日期
} PickerType;

@interface JasPicker ()

@property(nonatomic, assign) PickerType type;
@property(nonatomic, strong) NSString *selectIndex;

@property(nonatomic, strong) NSString *selectKey;
@property(nonatomic, strong) NSString *selectValue;

@property(nonatomic, strong) NSDate *selectDate;

@property(nonatomic, strong) NSArray *arrayValues;
@property(nonatomic, strong) NSDictionary *dictionaryValues;
@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UIPickerView *picker;
@property(nonatomic, strong) UIDatePicker *datepicker;

@property(nonatomic, strong) UIButton *btnDone;
@property(nonatomic, strong) UIButton *btnCancel;

@property(copy, nonatomic) void(^arrayBlock)(NSString *value);
@property(copy, nonatomic) void(^dictionaryBlock)(NSString *key, NSString *value);
@property(copy, nonatomic) void(^dateBlock)(NSDate *value);
@end

@implementation JasPicker

/**
*  @author jaskang, 15-05-05 11:05:04
*
*  选择器-数组
*
*  @param values 内容数组
*  @param block  完成
*
*  @return PickerSelector
*/
- (instancetype)initWithArray:(NSArray *)values Complete:(void (^)(NSString *value))block {
    self = [super initWithFrame:ScreenBounds];
    if (self) {
        self.backgroundColor = GetUIColorAlpha(0x000000, 0);
        self.type = ArrayType;
        self.arrayBlock = block;
        self.arrayValues = values;
        self.selectIndex = [values firstObject];

        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 260)];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.borderColor = GetUIColor(0xCCCCCC).CGColor;
        self.contentView.layer.borderWidth = 0.5;

        self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, 216)];
        self.picker.delegate = self;

        self.btnDone = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.btnDone setFrame:CGRectMake(ScreenWidth - 68, 6, 60, 32)];
        [self.btnDone setTitle:@"确定" forState:UIControlStateNormal];
        [self.btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnDone setBackgroundColor:UIColorBule];
        self.btnDone.layer.cornerRadius = 3;
        [self.btnDone addTarget:self action:@selector(tapDone) forControlEvents:UIControlEventTouchUpInside];

        self.btnCancel = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.btnCancel setFrame:CGRectMake(8, 6, 60, 32)];
        [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [self.btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnCancel setBackgroundColor:UIColorBule];
        self.btnCancel.layer.cornerRadius = 3;
        [self.btnCancel addTarget:self action:@selector(tapCancel) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:self.btnDone];
        [self.contentView addSubview:self.btnCancel];
        [self.contentView addSubview:self.picker];
        [self addSubview:self.contentView];
        [KeyWindow addSubview:self];
    }
    return self;
}

/**
*  @author jaskang, 15-05-05 11:05:16
*
*  字典选择器-联动
*
*  @param values 内容字典
*  @param block  完成
*
*  @return PickerSelector
*/
- (instancetype)initWithDictionary:(NSDictionary *)values Complete:(void (^)(NSString *key, NSString *value))block {
    self = [super initWithFrame:ScreenBounds];
    if (self) {
        self.backgroundColor = GetUIColorAlpha(0x000000, 0.0);
        self.type = DictionaryType;
        self.dictionaryBlock = block;
        self.selectKey = [values.allKeys firstObject];
        self.selectValue = [[values objectForKey:self.selectKey] firstObject];
        self.dictionaryValues = values;

        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 260)];
        self.contentView.backgroundColor = [UIColor whiteColor];

        self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, 216)];
        self.picker.delegate = self;

        self.btnDone = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.btnDone setFrame:CGRectMake(ScreenWidth - 68, 6, 60, 32)];
        [self.btnDone setTitle:@"确定" forState:UIControlStateNormal];
        [self.btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnDone setBackgroundColor:UIColorBule];
        self.btnDone.layer.cornerRadius = 3;
        [self.btnDone addTarget:self action:@selector(tapDone) forControlEvents:UIControlEventTouchUpInside];

        self.btnCancel = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.btnCancel setFrame:CGRectMake(8, 6, 60, 32)];
        [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [self.btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnCancel setBackgroundColor:UIColorBule];
        self.btnCancel.layer.cornerRadius = 3;
        [self.btnCancel addTarget:self action:@selector(tapCancel) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:self.btnDone];
        [self.contentView addSubview:self.btnCancel];
        [self.contentView addSubview:self.picker];
        [self addSubview:self.contentView];
        [KeyWindow addSubview:self];
    }
    return self;
}

/**
*  @author JasKang, 15-05-05 11:05:11
*
*  日期选择器
*  @param value 默认日期
*  @param block 完成
*  @return PickerSelector
*/
- (instancetype)initWithDate:(NSDate *)value UIDatePicker:(UIDatePicker *)datepicker
                Complete:(void (^)(NSDate *value))block {
    self = [super initWithFrame:ScreenBounds];
    if (self) {
        self.backgroundColor = GetUIColorAlpha(0x000000, 0.0);
        self.type = DateType;
        self.dateBlock = block;
        self.selectDate = value;

        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 260)];
        self.contentView.backgroundColor = [UIColor whiteColor];


        self.datepicker = datepicker;
        self.datepicker.date = value;
        [self.datepicker addTarget:self action:@selector(eventForDatePicker:) forControlEvents:UIControlEventValueChanged];

        [self.contentView addSubview:self.datepicker];


        self.btnDone = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.btnDone setFrame:CGRectMake(ScreenWidth - 68, 6, 60, 32)];
        [self.btnDone setTitle:@"确定" forState:UIControlStateNormal];
        [self.btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnDone setBackgroundColor:UIColorBule];
        self.btnDone.layer.cornerRadius = 3;
        [self.btnDone addTarget:self action:@selector(tapDone) forControlEvents:UIControlEventTouchUpInside];

        self.btnCancel = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.btnCancel setFrame:CGRectMake(8, 6, 60, 32)];
        [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [self.btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnCancel setBackgroundColor:UIColorBule];
        self.btnCancel.layer.cornerRadius = 3;
        [self.btnCancel addTarget:self action:@selector(tapCancel) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:self.btnDone];
        [self.contentView addSubview:self.btnCancel];

        [self addSubview:self.contentView];
        [KeyWindow addSubview:self];
    }
    return self;
}

/**
*  @author JasKang, 15-05-05 11:05:59
*
*  显示
*/
- (void)show {
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = GetUIColorAlpha(0x000000, 0.5);
        self.contentView.frame = CGRectMake(0, ScreenHeight - 260, ScreenWidth, 260);
    }                completion:^(BOOL finished) {
        if (finished && self.type == DateType) {

        }
    }];
}

/**
*  @author JasKang, 15-05-05 11:05:07
*
*  完成
*/
- (void)tapDone {
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = GetUIColorAlpha(0x000000, 0);
        self.contentView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 260);
    }                completion:^(BOOL finished) {
        if (finished) {
            switch (self.type) {
                case ArrayType:
                    self.arrayBlock(self.selectIndex);
                    break;
                case DictionaryType:
                    self.dictionaryBlock(self.selectKey, self.selectValue);
                    break;
                default:
                    [self.datepicker removeTarget:self action:@selector(eventForDatePicker:) forControlEvents:UIControlEventValueChanged];
                    self.dateBlock(self.selectDate);
                    break;
            }
            [self removeFromSuperview];
        }
    }];
}

/**
*  @author JasKang, 15-05-05 11:05:19
*
*  取消
*/
- (void)tapCancel {
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = GetUIColorAlpha(0x000000, 0);
        self.contentView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 260);
    }                completion:^(BOOL finished) {
        if (finished) {

            [self removeFromSuperview];
        }
    }];
}

/**
*  @author JasKang, 15-05-05 11:05:27
*
*  选择日期
*
*  @param sender <#sender description#>
*/
- (void)eventForDatePicker:(UIDatePicker *)sender {
    self.selectDate = sender.date;
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    switch (self.type) {
        case ArrayType:
            return 1;
            break;
        case DictionaryType:
            return 2;
            break;
        default:
            return 0;
            break;
    }
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (self.type) {
        case ArrayType:
            return self.arrayValues.count;
            break;
        case DictionaryType:
            if (component == 0) {
                return self.dictionaryValues.allKeys.count;
            } else {
                return [(NSArray *) self.dictionaryValues[self.selectKey] count];
            }
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (self.type) {
        case ArrayType:
            return [self.arrayValues objectAtIndex:row];
            break;
        case DictionaryType:
            if (component == 0) {
                return [self.dictionaryValues.allKeys objectAtIndex:row];
            } else {
                return [[self.dictionaryValues objectForKey:self.selectKey] objectAtIndex:row];
            }
            break;
        default:
            return @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (self.type) {
        case ArrayType:
            self.selectIndex = [self.arrayValues objectAtIndex:row];
            break;
        case DictionaryType:
            if (component == 0) {
                self.selectKey = [self.dictionaryValues.allKeys objectAtIndex:row];
                self.selectValue = [[self.dictionaryValues objectForKey:self.selectKey] objectAtIndex:0];
                [pickerView reloadComponent:1];
            } else {
                self.selectValue = [[self.dictionaryValues objectForKey:self.selectKey] objectAtIndex:row];
            }
            break;
        default:
            break;
    }
}

@end
