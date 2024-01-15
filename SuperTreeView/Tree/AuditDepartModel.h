//
//  AuditDepartModel.h
//  SuperTreeView
//
//  Created by pengpeng on 2023/10/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuditDepartModel : NSObject

@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray <AuditDepartModel *>*childData;

@end

NS_ASSUME_NONNULL_END
