//
//  ViewController.m
//  SlideTableViewDemo
//
//  Created by Biao on 16/4/26.
//  Copyright © 2016年 Biao. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "JBPanGestureRecognizer.h"

#define JB_Color_RGB(a,b,c) [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:1]


@interface ViewController ()

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataList = [NSMutableArray arrayWithArray:@[@"我是一只小小小小鸟",
                                                     @"想要飞呀飞,却飞也飞不高",
                                                     @"想要飞呀飞呀飞,却飞也飞不高",
                                                     @"我寻寻觅觅,寻寻觅觅一个温暖的怀抱! ",
                                                     @"这样的要求,算不算太高",
                                                     @"所有知道我的名字的人啊",
                                                     @"你们好不好.",
                                                     @"世界是如此的小.",
                                                     @"我们注定无处可逃.",
                                                     @"当我尝尽人情冷暖",
                                                     @"当你决定为你了的理想燃烧",
                                                     @"生活的压力与生命的尊严.",
                                                     @"哪一个重要!"]];
    
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        tableView;
    });
    
    typeof(self) __weak weakSelf = self;
    JBPanGestureRecognizer *pan = [[JBPanGestureRecognizer alloc]initWithTableView:_tableView Handle:^(JBPanGestureRecognizer *panGesture, NSIndexPath *indexpath, BOOL isLeft) {
        
        if(isLeft)
        {
            [weakSelf.dataList removeObjectAtIndex:indexpath.row];
            [panGesture.tableView deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
        }
        else
        {
            DetailViewController *detail = [[DetailViewController alloc]init];
            [weakSelf addChildViewController:detail];
            [weakSelf.view addSubview:detail.view];
            [detail didMoveToParentViewController:weakSelf];
        }
    }];
    [pan addLeftText:@"comment" rightText:@"retweent"];
    [self.view addGestureRecognizer:pan];
    
}


#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 0;
    }
    cell.textLabel.text = self.dataList[indexPath.row];
    cell.backgroundColor = JB_Color_RGB(245, 110, 235);
    return cell;
}



@end
