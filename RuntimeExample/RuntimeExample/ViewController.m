//
//  ViewController.m
//  RuntimeExample
//
//  Created by Joe on 2019/5/28.
//  Copyright © 2019年 tony. All rights reserved.
//

#import "ViewController.h"
#import "CategroyPropertyController.h"
#import "MethodSwizzleController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *titleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"Runtime";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSLog(@"---%d----%d",indexPath.section, indexPath.row);
    switch (indexPath.row) {
        case 0: {
            CategroyPropertyController *controller = [[CategroyPropertyController alloc] init];
            controller.titleName = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        case 1:{
            MethodSwizzleController *controller = [[MethodSwizzleController alloc] init];
            controller.titleName = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
            
        default:
            break;
    }
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"Catergoy增加属性", @"MethodSwizzle交换方法", @"", @"", @""];
    }
    return _titleArray;
}

@end

