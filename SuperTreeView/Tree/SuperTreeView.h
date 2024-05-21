//
//  SuperTreeView.h
//  SuperTreeView
//
//  Created by pengpeng on 2023/10/26.
//

#import <UIKit/UIKit.h>
#import "AuditDepartModel.h"
#import "SuperTreeTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SuperTreeView : UIView

- (void)reloadData;

@property (nonatomic, copy) NSArray <NSString *>*(^getDataListBlock)(SuperTreeView *treeView, SuperTreeTableView *tableView, NSInteger selectedIndex);

@end

NS_ASSUME_NONNULL_END
