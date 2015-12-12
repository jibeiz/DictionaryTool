//
//  ViewController.m
//  DictionaryTool
//
//  Created by 苏余昕龙 on 15/12/12.
//  Copyright © 2015年 DevSu. All rights reserved.
//

#import "ViewController.h"
#import "ECdictionary.h"

//#define SHOWFUNC NSlog(@"生命周期阶段:%s",__func__)
@interface ViewController ()

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建输入框
    UITextField * inputTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 50)];
    inputTF.center = CGPointMake(self.view.frame.size.width/2-50, self.view.frame.size.height*0.2);
    inputTF.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.3];
    inputTF.borderStyle = UITextBorderStyleRoundedRect;
    inputTF.tag = 1;
    inputTF.placeholder = @"请输入要翻译的文字";
    inputTF.clearButtonMode = UITextFieldViewModeAlways;
    inputTF.returnKeyType = UIReturnKeyGo;
    inputTF.delegate = self;
    
    [self.view addSubview:inputTF];
    
    //创建显示翻译的label
    UILabel * lbResult = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, self.view.frame.size.height*0.618)];
    lbResult.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height*0.65);
    lbResult.tag = 2;
    lbResult.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.4];
    lbResult.textColor = [UIColor blackColor];
    lbResult.font = [UIFont systemFontOfSize:18];
    lbResult.textAlignment = NSTextAlignmentLeft;
    lbResult.numberOfLines = 0;
    lbResult.lineBreakMode = NSLineBreakByCharWrapping;
    
    [self.view addSubview:lbResult];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITextField *tf=[self.view viewWithTag:1];
    [tf resignFirstResponder];
}
#pragma mark textfield代理方法
// 点击键盘上的go，结束编辑状态，开始查询翻译，并且返回翻译结果
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //用户输入的内容
    NSString * strInput = textField.text;
    //使用正则表达式判断用户输入的是否是英文，若英文，则查询返回中文；否则就返回英文
    NSString *regex = @"^[a-zA-Z]{1,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //保存翻译返回值
    NSString *strResult = @"";
    if ([pred evaluateWithObject:strInput]) {
        //匹配英文
        strResult = [ECdictionary ENGTransToCHN:strInput];
    } else {
        strResult = [ECdictionary CHNTransToENG:strInput];
    }
    UILabel * lb = [self.view viewWithTag:2];
    lb.text = strResult;
    //释放第一响应
    [textField resignFirstResponder];
    return YES;
}

@end
