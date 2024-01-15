//
//  SuperTreeTableView.m
//  SuperTreeView
//
//  Created by pengpeng on 2023/10/26.
//

#import "SuperTreeTableView.h"

@interface SuperTreeTableView() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SuperTreeTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return self;
}

@synthesize dataList = _dataList;

- (NSArray<AuditDepartModel *> *)dataList {
    if (nil == _dataList) {
        _dataList = @[];
    }
    return _dataList;
}

- (void)setDataList:(NSArray<AuditDepartModel *> *)dataList {
    _dataList = dataList;
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataList[indexPath.row].name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.cellClickedAction) {
        self.cellClickedAction(self, indexPath.row);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
@end
