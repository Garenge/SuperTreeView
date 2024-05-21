//
//  SuperTreeTableView.h
//  SuperTreeView
//
//  Created by pengpeng on 2023/10/26.
//

#import <UIKit/UIKit.h>
#import "AuditDepartModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SuperTreeTableView : UIView

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIView *topView;

/// 某一级的tableView关联的产品, 表示的是点中这个tableView之后
@property (nonatomic, strong) NSObject *linkObject;
@property (nonatomic, strong) NSArray <NSString *> *dataList;

@property (nonatomic, copy) void(^cellClickedAction)(SuperTreeTableView *tableView, NSInteger index);

@end

NS_ASSUME_NONNULL_END
