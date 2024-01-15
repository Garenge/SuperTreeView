//
//  SuperTreeView.h
//  SuperTreeView
//
//  Created by pengpeng on 2023/10/26.
//

#import <UIKit/UIKit.h>
#import "AuditDepartModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SuperTreeView : UIView

@property (nonatomic, strong) NSArray <AuditDepartModel *>*departsList;

@end

NS_ASSUME_NONNULL_END
