//
//  ViewController.m
//  FYTextFieldRestricterDemo
//
//  Created by FishYu on 2018/9/11.
//  Copyright © 2018年 FishYu. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+Restricter.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.maxLength = 6;
    self.textField.restrictType = FYTextRestrictTypeNumber;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
