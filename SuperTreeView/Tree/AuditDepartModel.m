//
//  AuditDepartModel.m
//  SuperTreeView
//
//  Created by pengpeng on 2023/10/26.
//

#import "AuditDepartModel.h"

@implementation AuditDepartModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"tid": @"id"
    };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"childData": @"AuditDepartModel"
    };
}

@end
