//
//  SuperTreeView.m
//  SuperTreeView
//
//  Created by pengpeng on 2023/10/26.
//

#import "SuperTreeView.h"
#import <Masonry/Masonry.h>
#import <MJExtension/MJExtension.h>
#import "AuditDepartModel.h"

@interface SuperTreeView()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIStackView *stackView;

@end

@implementation SuperTreeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.spacing = 0;
    stackView.distribution = UIStackViewDistributionFillEqually;
    [scrollView addSubview:stackView];
    self.stackView = stackView;
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.height.right.equalTo(scrollView);
    }];
}

- (void)reloadData {
    // 第一个tableView
    if (self.getDataListBlock) {
        SuperTreeTableView *tableView = [self createSuperTableViewWithTag:9999];
        NSArray <NSString *>*dataList = self.getDataListBlock(self, tableView, -1);
        [self reloadTableView:tableView dataList:dataList];
    }
}

- (void)reloadTableView:(SuperTreeTableView *)tableView dataList:(NSArray <NSString *>*)dataList {
    if (dataList.count == 0) {
        return;
    }
    tableView.dataList = dataList;
    [self.stackView addArrangedSubview:tableView];
    [self.scrollView layoutIfNeeded];
    [self.scrollView setContentOffset:CGPointMake(MAX(0, self.stackView.frame.size.width - self.scrollView.frame.size.width), 0)];
}

- (SuperTreeTableView *)createSuperTableViewWithTag:(NSInteger)tag {
    // 默认宽度屏幕的 1/3.5
    CGFloat width = UIScreen.mainScreen.bounds.size.width / 3.5;
    
    SuperTreeTableView *tableView = [[SuperTreeTableView alloc] init];
    tableView.tag = tag;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
    
    __weak typeof(self) weakSelf = self;
    [tableView setCellClickedAction:^(SuperTreeTableView * _Nonnull tableView, NSInteger index) {
        [weakSelf tableView:tableView didSelectedAtIndex:index];
    }];
    return tableView;
}

- (void)tableView:(SuperTreeTableView *)tableView didSelectedAtIndex:(NSInteger)index {
    // 该tableView往后所有的tableview都自动移除
    NSMutableArray *willRemove = [NSMutableArray array];
    for (SuperTreeTableView *sTView in self.stackView.subviews) {
        if (sTView.tag > tableView.tag) {
            [willRemove addObject:sTView];
        }
    }
    for (UIView *view in willRemove) {
        [view removeFromSuperview];
    }
    
    // 显示下级数据
    if (self.getDataListBlock) {

        SuperTreeTableView *lastTableView = self.stackView.subviews.lastObject;
        SuperTreeTableView *newTableView = [self createSuperTableViewWithTag:lastTableView.tag + 1];
        newTableView.linkObject = lastTableView.linkObject;
        NSArray <NSString *>*dataList = self.getDataListBlock(self, newTableView, index);
        [self reloadTableView:newTableView dataList:dataList];
    }
}

@end
