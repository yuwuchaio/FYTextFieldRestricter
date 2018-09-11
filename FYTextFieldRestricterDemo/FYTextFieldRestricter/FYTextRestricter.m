//
//  FYTextRestricter.m
//  SmartTraffic
//
//  Created by FishYu on 2018/8/23.
//  Copyright © 2018年 jiangruihuang. All rights reserved.
//

#import "FYTextRestricter.h"

typedef BOOL(^FYStringFilter)(NSString * aString);
static inline NSString * kFilterString(NSString * handleString, FYStringFilter subStringFilter) {
    NSMutableString * modifyString = handleString.mutableCopy;
    for (NSInteger idx = 0; idx < modifyString.length;) {
        NSString * subString = [modifyString substringWithRange: NSMakeRange(idx, 1)];
        if (subStringFilter(subString)) {
            idx++;
        } else {
            [modifyString deleteCharactersInRange: NSMakeRange(idx, 1)];
        }
    }
    return modifyString;
}

static inline BOOL kMatchStringFormat(NSString * aString, NSString * matchFormat) {
    NSPredicate * predicate = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", matchFormat];
    return [predicate evaluateWithObject: aString];
}


@interface FYTextRestricter()

/// 当前限制器
@property (nonatomic, readwrite, assign) FYTextRestrictType restrictType;

@end

@implementation FYTextRestricter

- (instancetype)init {
    self = [super init];
    if (self) {
        self.maxLength = NSUIntegerMax;
        self.restrictType = FYTextRestrictTypeNone;
    }
    return self;
}

+ (instancetype)textRestricterWithRestrictType:(FYTextRestrictType)restrictType {
    FYTextRestricter *restricter;
    switch (restrictType) {
        case FYTextRestrictTypeChinese:
            restricter = [[NSClassFromString(@"FYTextChineseRestricter") alloc] init];
            break;
        case FYTextRestrictTypeNumber:
            restricter = [[NSClassFromString(@"FYTextNumberRestricter") alloc] init];
            break;
        case FYTextRestrictTypeDecimal:
            restricter = [[NSClassFromString(@"FYTextDecimalRestricter")  alloc] init];
            break;
        case FYTextRestrictTypeLetter:
            restricter = [[NSClassFromString(@"FYTextLetterRestricter") alloc] init];
            break;
        case FYTextRestrictTypeCustom:
            restricter = [[NSClassFromString(@"FYTextCustomRestricter") alloc] init];
            break;
        case FYTextRestrictTypeNone:
            break;
    }
    restricter.restrictType = restrictType;
    return restricter;
}

- (void)fy_restricterTextDidChanged:(UITextField *)textField {
    
    if (textField.text.length > self.maxLength) {
        textField.text = [textField.text substringToIndex:self.maxLength];
    }
}
@end

@implementation FYTextChineseRestricter
- (void)fy_restricterTextDidChanged:(UITextField *)textField {
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            textField.text = kFilterString(textField.text, ^BOOL(NSString *aString) {
                return kMatchStringFormat(aString,@"^[\u4e00-\u9fa5]+$");
            });
            [super fy_restricterTextDidChanged:textField];
        }
        else{
            
        }
    }else {
        textField.text = kFilterString(textField.text, ^BOOL(NSString *aString) {
            return kMatchStringFormat(aString,@"^[\u4e00-\u9fa5]+$");
        });
        [super fy_restricterTextDidChanged:textField];
    }
    
}
@end

@implementation FYTextNumberRestricter
- (void)fy_restricterTextDidChanged:(UITextField *)textField {
    textField.text = kFilterString(textField.text, ^BOOL(NSString *aString) {
        return kMatchStringFormat(aString, @"^[0-9]$");
    });
    [super fy_restricterTextDidChanged:textField];
}
@end

@implementation FYTextDecimalRestricter
- (void)fy_restricterTextDidChanged:(UITextField *)textField {
    textField.text = kFilterString(textField.text, ^BOOL(NSString *aString) {
        return kMatchStringFormat(aString, @"^[0-9.]$");
    });
    [super fy_restricterTextDidChanged:textField];
}
@end

@implementation FYTextLetterRestricter
- (void)fy_restricterTextDidChanged:(UITextField *)textField {
    textField.text = kFilterString(textField.text, ^BOOL(NSString *aString) {
        return kMatchStringFormat(aString, @"^[a-zA-Z]+$");
    });
    [super fy_restricterTextDidChanged:textField];
}
@end

@implementation FYTextCustomRestricter
- (void)fy_restricterTextDidChanged:(UITextField *)textField {
    if (self.customRegex) {
        textField.text = kFilterString(textField.text, ^BOOL(NSString *aString) {
            return kMatchStringFormat(aString, self.customRegex);
        });
        [super fy_restricterTextDidChanged:textField];
    }
}
@end

