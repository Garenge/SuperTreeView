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
#import "SuperTreeTableView.h"

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

- (void)setDepartsList:(NSArray *)departsList {
    _departsList = departsList;
    
    // 第一个tableView
    [self createSuperTableViewWithTag:9999 dataList:self.departsList];
}

- (void)createSuperTableViewWithTag:(NSInteger)tag dataList:(NSArray <AuditDepartModel *>*)dataList{
    // 默认宽度屏幕的 1/3.5
    CGFloat width = UIScreen.mainScreen.bounds.size.width / 3.5;
    
    SuperTreeTableView *tableView = [[SuperTreeTableView alloc] init];
    tableView.tag = tag;
    tableView.dataList = dataList;
    [self.stackView addArrangedSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
    
    __weak typeof(self) weakSelf = self;
    [tableView setCellClickedAction:^(SuperTreeTableView * _Nonnull tableView, NSInteger index) {
        [weakSelf tableView:tableView didSelectedAtIndex:index];
    }];
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
    AuditDepartModel *model = tableView.dataList[index];
    if (model.childData.count > 0) {
        
        SuperTreeTableView *lastTableView = self.stackView.subviews.lastObject;
        [self createSuperTableViewWithTag:lastTableView.tag + 1 dataList:model.childData];
        
        [self.scrollView layoutIfNeeded];
        [self.scrollView setContentOffset:CGPointMake(MAX(0, self.stackView.frame.size.width - self.scrollView.frame.size.width), 0)];
    }
}

@end
