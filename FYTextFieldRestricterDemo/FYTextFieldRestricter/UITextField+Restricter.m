//
//  UITextField+Restricter.m
//  SmartTraffic
//
//  Created by FishYu on 2018/8/23.
//  Copyright © 2018年 jiangruihuang. All rights reserved.
//

#import "UITextField+Restricter.h"
#import <objc/runtime.h>

@implementation UITextField (Restricter)

- (void)setRestricter:(FYTextRestricter *)restricter {
    if ([self restricter]) {
        restricter.maxLength = [self restricter].maxLength;
    }
    objc_setAssociatedObject(self, @selector(restricter), restricter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self removeTarget:self.restricter action:@selector(fy_restricterTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self.restricter action:@selector(fy_restricterTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
}

- (FYTextRestricter *)restricter {
    return objc_getAssociatedObject(self, @selector(restricter));
}

- (void)setMaxLength:(NSUInteger)maxLength {
    if (![self restricter]) {
        FYTextRestricter *restricter = [FYTextRestricter textRestricterWithRestrictType:FYTextRestrictTypeCustom];
        [self setRestricter:restricter];
    }
    [self restricter].maxLength = maxLength;
}

- (NSUInteger)maxLength {
    return [self restricter].maxLength;
}

- (void)setRestrictType:(FYTextRestrictType)restrictType {
    if ([self restricter].restrictType == restrictType) return;
    FYTextRestricter *restricter = [FYTextRestricter textRestricterWithRestrictType:restrictType];
    [self setRestricter:restricter];
}

- (FYTextRestrictType)restrictType {
    return [self restricter].restrictType;
}

@end
