//
//  FYTextRestricter.h
//  SmartTraffic
//
//  Created by FishYu on 2018/8/23.
//  Copyright © 2018年 jiangruihuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FYTextRestrictType) {
    FYTextRestrictTypeNone    = 1,
    FYTextRestrictTypeChinese = 2,  // 中文
    FYTextRestrictTypeNumber  = 3,  // 数字
    FYTextRestrictTypeDecimal = 4,  // 实数（包含小数）
    FYTextRestrictTypeLetter  = 5,  // 字母（不区分大小）
    FYTextRestrictTypeCustom  = 6,  // 自定义限制。会使用`customRegex`进行限制
};

/**
 UITextField输入限制器
 */
@interface FYTextRestricter : NSObject

/// 默认输入最长长度
@property (nonatomic, assign) NSUInteger maxLength;

/// 当前限制器类型
@property (nonatomic, readonly, assign) FYTextRestrictType restrictType;
/**
 自定义正则限制，
 ps:自定义正则，只有`restrictType`设置为`FYTextCustomRestricter`有效。
 */
@property (nonatomic, copy) NSString *customRegex;

+ (instancetype)textRestricterWithRestrictType:(FYTextRestrictType)restrictType;

// 子类重写实现用来限制文本内容
- (void)fy_restricterTextDidChanged:(UITextField *)textField;


- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
@end

/**
 中文
 */
@interface FYTextChineseRestricter : FYTextRestricter
@end
/**
 数字
 */
@interface FYTextNumberRestricter : FYTextRestricter
@end
/**
 实数
 */
@interface FYTextDecimalRestricter : FYTextRestricter
@end

/**
 字母
 */
@interface FYTextLetterRestricter : FYTextRestricter
@end
/**
 自定义规则
 */
@interface FYTextCustomRestricter : FYTextRestricter
@end
