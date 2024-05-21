//
//  SuperTreeTableView.m
//  SuperTreeView
//
//  Created by pengpeng on 2023/10/26.
//

#import "SuperTreeTableView.h"
#import <Masonry/Masonry.h>

@interface SuperTreeTableView() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SuperTreeTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        UIStackView *stackView = [[UIStackView alloc] init];
        stackView.axis = UILayoutConstraintAxisVertical;
        stackView.distribution = UIStackViewDistributionFill;
        stackView.spacing = 0;
        [self addSubview:stackView];
        [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];

        UIView *topView = [[UIView alloc] init];
        self.topView = topView;
        [stackView addArrangedSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
        }];

        UILabel *topLabel = [[UILabel alloc] init];
        topLabel.backgroundColor = UIColor.orangeColor;
        topLabel.numberOfLines = 2;
        topLabel.textAlignment = NSTextAlignmentCenter;
        [topView addSubview:topLabel];
        self.topLabel = topLabel;
        [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];

        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = UIColor.whiteColor;
        if (@available(iOS 15.0, *)) {
            tableView.sectionHeaderTopPadding = 0;
        } else {
            // Fallback on earlier versions
        }
        [stackView addArrangedSubview:tableView];
        self.tableView = tableView;

        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

        tableView.tableHeaderView = [UIView new];
        tableView.tableFooterView = [UIView new];
    }
    return self;
}

@synthesize dataList = _dataList;

- (NSArray<NSString *> *)dataList {
    if (nil == _dataList) {
        _dataList = @[];
    }
    return _dataList;
}

- (void)setDataList:(NSArray<NSString *> *)dataList {
    _dataList = dataList;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.topLabel.text = [NSString stringWithFormat:@"选中: %@", self.dataList[indexPath.row]];

    if (self.cellClickedAction) {
        self.cellClickedAction(self, indexPath.row);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
@end
