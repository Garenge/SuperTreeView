//
//  SuperTreeTableView.h
//  SuperTreeView
//
//  Created by pengpeng on 2023/10/26.
//

#import <UIKit/UIKit.h>
#import "AuditDepartModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SuperTreeTableView : UITableView

@property (nonatomic, strong) NSArray <AuditDepartModel *> *dataList;

@property (nonatomic, copy) void(^cellClickedAction)(SuperTreeTableView *tableView, NSInteger index);

@end

NS_ASSUME_NONNULL_END
