//
//  ViewController.m
//  AR_Hello
//
//  Created by MAC on 2017/9/22.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "ViewController.h"
#import "ARSCNViewController.h"
#import "ARSCNViewController2.h"
#import "ARSCNViewController3.h"
#import "ARSCNViewController4.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIButton *btn1 = [[UIButton alloc] init];
    btn1.backgroundColor = [UIColor blueColor];
    [btn1 setTitle:@"开启AR" forState:0];
    [btn1 setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(50);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(50);
        
    }];
    [btn1 addTarget:self action:@selector(arFunc1) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UIButton *btn2 = [[UIButton alloc] init];
    btn2.backgroundColor = [UIColor blueColor];
    [btn2 setTitle:@"捕捉平地" forState:0];
    [btn2 setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(50);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(btn1.mas_bottom).offset(50);
        
    }];
    [btn2 addTarget:self action:@selector(arFunc2) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *btn3 = [[UIButton alloc] init];
    btn3.backgroundColor = [UIColor blueColor];
    [btn3 setTitle:@"跟随相机移动" forState:0];
    [btn3 setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(50);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(btn2.mas_bottom).offset(50);
        
    }];
    [btn3 addTarget:self action:@selector(arFunc3) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn4 = [[UIButton alloc] init];
    btn4.backgroundColor = [UIColor blueColor];
    [btn4 setTitle:@"旋转" forState:0];
    [btn4 setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:btn4];
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(50);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(btn3.mas_bottom).offset(50);
        
    }];
    [btn4 addTarget:self action:@selector(arFunc4) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}


- (void)arFunc1
{
    ARSCNViewController *vc = [[ARSCNViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)arFunc2
{
    ARSCNViewController2 *vc = [[ARSCNViewController2 alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)arFunc3
{
    ARSCNViewController3 *vc = [[ARSCNViewController3 alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)arFunc4
{
    ARSCNViewController4 *vc = [[ARSCNViewController4 alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
