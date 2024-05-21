//
//  ViewController.m
//  SuperTreeView
//
//  Created by pengpeng on 2023/10/26.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import <MJExtension/MJExtension.h>
#import "AuditDepartModel.h"
#import "SuperTreeView.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray <AuditDepartModel *>*departsList;

@end

@implementation ViewController

- (NSArray<AuditDepartModel *> *)departsList {
    if (nil == _departsList) {
        
        _departsList = [self createTestDepartsWithDepth:8];
    }
    return _departsList;
}

- (NSArray <AuditDepartModel *> *)createTestDepartsWithDepth:(NSInteger)depth {
    
    if (depth > 0) {
        
        NSInteger randomCount = arc4random() % 6;
        NSLog(@"randomCount: %ld", randomCount);
        
        NSMutableArray *dataList = [NSMutableArray array];
        for (NSInteger index = 0; index < randomCount; index ++) {
            
            AuditDepartModel *model = [[AuditDepartModel alloc] init];
            model.name = [NSString stringWithFormat:@"部门%ld", index + 1];
            
            NSInteger randomDept = arc4random() % depth;
            NSLog(@"randomDept: %ld", randomDept);
            
            model.childData = [self createTestDepartsWithDepth:depth - 1];
            [dataList addObject:model];
        }
        
        return dataList;
    }
    return @[];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SuperTreeView *treeView = [[SuperTreeView alloc] init];
    [self.view addSubview:treeView];
    [treeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];

    treeView.getDataListBlock = ^NSArray<NSString *> * _Nonnull(SuperTreeView * _Nonnull treeView, SuperTreeTableView * _Nonnull tableView, NSInteger selectedIndex) {

        NSArray <AuditDepartModel *>*models;
        if (selectedIndex == -1) {
            // 第一级
            models = self.departsList;
        } else {
            // 第 i 级
            NSArray <AuditDepartModel *>*linkObjects = (NSArray <AuditDepartModel *>*)tableView.linkObject;
            models = linkObjects[selectedIndex].childData;
        }
        tableView.linkObject = models;
        return [models valueForKey:@"name"];
    };
    [treeView reloadData];
}


@end
