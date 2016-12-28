//
//  TableViewController.m
//  UITableView优化
//
//  Created by dang on 2016/12/28.
//  Copyright © 2016年 dang. All rights reserved.
//

    #import "TableViewController.h"
    #import "DBTableViewCell.h"
    #import "UIImageView+WebCache.h"
    #import "UIColor+expanded.h"

    @interface TableViewController ()
    @property (nonatomic, strong) NSMutableArray *heightMArray;/** cell高度数组*/
    @property (nonatomic, strong) NSMutableArray *newsMArray;  /** 新闻数据源*/
    @end

    @implementation TableViewController

    - (void)viewDidLoad {
        [super viewDidLoad];
        self.tableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.showsVerticalScrollIndicator = NO;
        [self.tableView registerClass:[DBTableViewCell class] forCellReuseIdentifier:NSStringFromClass([DBTableViewCell class])];
        //...获取网络数据, 在这里用假数据
        self.newsMArray = [[NSMutableArray alloc] initWithObjects:
    @"http://pic2.zhimg.com/0e7f5548fca3cb7c29d69189c609f66d.jpg",
    @"http://i0.hdslb.com/bfs/archive/b947b06dfb53af2bda5a53d145934596d5abbab5.jpg",
    @"http://pic1.zhimg.com/3a0b66018f28365e57cc51816cb17678.jpg",
    @"http://i0.hdslb.com/bfs/archive/c0f647ee5d5d77263fdbc49129563004e40b704e.jpg",
    @"http://pic1.zhimg.com/e1ac4a1d20226abb980244537bf537f8.jpg",
    @"http://i0.hdslb.com/bfs/archive/9b7e61ceb18aed36138e7726afcebbf69b6862e6.jpg",
    @"http://pic2.zhimg.com/5e2f62618ca4bdd8fe4c38ed1ed69271.jpg",
    @"http://i0.hdslb.com/bfs/archive/232dd1d0e577b9830386f7a3237de4a3e837c021.jpg",
    @"http://pic3.zhimg.com/9e9c66ff2242006a573d37334b35b746.jpg",
    @"http://i0.hdslb.com/bfs/archive/ced5cbdd59ce9b751a60472181faf3a6b2b73de8.jpg",
    @"http://pic3.zhimg.com/9e9c66ff2242006a573d37334b35b746.jpg",
    @"http://i0.hdslb.com/bfs/archive/0c819a923a0e816961ea8d5483584b4b503827c8.jpg",
    @"http://pic3.zhimg.com/9caa7d6525ed9df0b505dffcf96a67c6.jpg", nil];
        [self.tableView reloadData];
    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

    #pragma mark - UITableViewDataSourse
    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return self.newsMArray.count;
    }

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 1;
    }

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        DBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DBTableViewCell class])];
        cell.imageViewHeight = [self.heightMArray objectAtIndex:indexPath.section];
        [cell configWithDict:[self.newsMArray objectAtIndex:indexPath.section]];
        [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:[self.newsMArray objectAtIndex:indexPath.section]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // ------if用来判断是否已经update高度数组中图片的高度，如果没有if会陷入死循环
            if ([[self.heightMArray objectAtIndex:indexPath.section] isEqual:@(self.view.frame.size.width*3/5)]) {
                NSNumber *number = [NSNumber numberWithFloat:(image.size.height/image.size.width) * self.view.frame.size.width];
                [self.heightMArray replaceObjectAtIndex:indexPath.section withObject:number];
                // ------在主线程中重新加载tableView
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }];
        return cell;
    }

    #pragma mark - UITableViewDelegate
    - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 10.0f;
    }

    - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        return view;
    }

    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        // ------图片距离cell顶部5+底部5
        return 10 + [[self.heightMArray objectAtIndex:indexPath.section] floatValue];
    }

    #pragma mark - getter and setter
    - (NSMutableArray *)heightMArray {
        if (_heightMArray == nil) {
            _heightMArray = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < self.newsMArray.count; i++) {
                // ------给图片一个默认高度
                [_heightMArray addObject:@(self.view.frame.size.width*3/5)];
            }
        }
        return _heightMArray;
    }
    @end
