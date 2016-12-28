//
//  DBTableViewCell.h
//  UITableView优化
//
//  Created by dang on 2016/12/28.
//  Copyright © 2016年 dang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *newsImageView;

@property (nonatomic, strong) NSNumber *imageViewHeight;

- (void)configWithDict:(NSDictionary *)dict;

@end
