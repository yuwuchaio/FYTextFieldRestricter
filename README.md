# FYTextFieldRestricter
UITextField常见限制输入工具包含长度和输入的字符格式。

开发中经常性的和`UITextField`打交道，常会碰见对输入的限制，作者总结平时碰到过的场景。由此才有这个Demo诞生。
`FYTextFieldRestricter`通过对`UITextField`的扩展，提供了包含了输入长度的限制、字母、汉字、数字。`UITextField`限制输入实现主要是通过`target-action`监听
`UITextField`的`UIControlEventEditingChanged`事件。然后在使用正则过滤输入。

## Usage：
手动拖入`FYTextFieldRestricter`文件夹
```
typedef NS_ENUM(NSInteger, FYTextRestrictType) {
    FYTextRestrictTypeNone    = 1,
    FYTextRestrictTypeChinese = 2,  // 中文
    FYTextRestrictTypeNumber  = 3,  // 数字
    FYTextRestrictTypeDecimal = 4,  // 实数（包含小数）
    FYTextRestrictTypeLetter  = 5,  // 字母（不区分大小）
    FYTextRestrictTypeCustom  = 6,  // 自定义限制。会使用`customRegex`进行限制
};
```

```
.m中

#import "UITextField+Restricter.h"
    /// 限制数字输入、6位最大长度
    self.textField.maxLength = 6;
    self.textField.restrictType = FYTextRestrictTypeNumber;
```

PS:使用了该分类限制输入时，如果自己外部代理或者监听中做了限制可能会导致冲突。更多详情，请查看源码，如果代码中存在问题请在`issue`中留言。
感谢！！

Demo参考: [UITextField的那点事](http://sindrilin.com/tips/2016/09/23/UITextField%E7%9A%84%E9%82%A3%E7%82%B9%E4%BA%8B.html)
