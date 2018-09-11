//
//  UITextField+Restricter.h
//  SmartTraffic
//
//  Created by FishYu on 2018/8/23.
//  Copyright © 2018年 jiangruihuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYTextRestricter.h"

@interface UITextField (Restricter)

// 最大长度
@property (nonatomic, assign) NSUInteger maxLength;
// 目前限制器的类型
@property (nonatomic, assign) FYTextRestrictType restrictType;
// 自定义限制器（会覆盖restrictType的限制）
@property (nonatomic, strong) FYTextRestricter *restricter;

@end
