//
//  MethodSwizzleController.m
//  RuntimeExample
//
//  Created by Joe on 2019/5/29.
//  Copyright © 2019年 tony. All rights reserved.
//

#import "MethodSwizzleController.h"
#import "NSArray+Safe.h"
#import "NSMutableArray+Safe.h"
#import "UIViewController+Track.h"

@interface MethodSwizzleController ()

@end

@implementation MethodSwizzleController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)track_viewWillAppear:(BOOL)animated {
    NSLog(@"track_viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)track_viewDidAppear:(BOOL)animated {
    NSLog(@"track_viewDidAppear");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //数组越界
    NSArray *array = @[@"a",@"b",@"c",@"d"];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithObjects:@"a",@"b",@"c",@"d", nil];
    NSString *index1 = [array objectAtIndex:4];
    NSString *index2 = [mutableArray objectAtIndex:4];
    NSLog(@"index1=%@",index1);
    NSLog(@"index2=%@",index2);
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
