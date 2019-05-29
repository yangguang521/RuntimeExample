//
//  CategroyPropertyController.m
//  RuntimeExample
//
//  Created by Joe on 2019/5/29.
//  Copyright © 2019年 tony. All rights reserved.
//

#import "CategroyPropertyController.h"
#import "UIView+Title.h"

@interface CategroyPropertyController ()

@end

@implementation CategroyPropertyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //categroy增加属性
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, ([UIScreen mainScreen].bounds.size.height-100)/2, 100, 100)];
    titleView.backgroundColor = [UIColor greenColor];
    titleView.title = @"Name";
    [self.view addSubview:titleView];
    NSLog(@"titleView.title=%@",titleView.title);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
