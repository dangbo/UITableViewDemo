//
//  DBTableViewCell.m
//  UITableView优化
//
//  Created by dang on 2016/12/28.
//  Copyright © 2016年 dang. All rights reserved.
//

#import "DBTableViewCell.h"
#import "Masonry.h"
#import "UIColor+expanded.h"

@implementation DBTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.newsImageView];
    }
    return self;
}

#pragma mark - public method
- (void)configWithDict:(NSDictionary *)dict {
    // ------demo中省略了dict数据
    [_newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15.0f);
        make.right.offset(-15.0f);
        make.top.offset(5.0f);
        make.bottom.offset(-5.0f);
    }];
}

#pragma mark - getter and setter
- (UIImageView *)newsImageView {
    if (!_newsImageView) {
        _newsImageView = [[UIImageView alloc] init];
        _newsImageView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    }
    return _newsImageView;
}

@end
