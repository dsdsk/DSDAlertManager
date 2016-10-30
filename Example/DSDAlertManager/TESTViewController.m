//
//  TESTViewController.m
//  DSDAlertManager
//
//  Created by dsdsk on 10/30/2016.
//  Copyright (c) 2016 dsdsk. All rights reserved.
//

#import "TESTViewController.h"
#import "DSDAlertManager.h"

@interface CellData : NSObject
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *value;
@property (nonatomic) void (^block)(void);
+ (instancetype)instanceWithName:(NSString *)name value:(NSString *)value block:(void (^)(void))block;
@end

@implementation CellData

+ (instancetype)instanceWithName:(NSString *)name value:(NSString *)value block:(void (^)(void))block
{
    CellData *cellData = [[CellData alloc] init];
    cellData.name = name;
    cellData.value = value;
    cellData.block = block;
    return cellData;
}

@end

@interface TESTViewController ()
{
    @private
    NSArray<CellData *> *_dataSources;
}
@end

@implementation TESTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初期化
    [self initialize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 初期化
 */
- (void)initialize
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    __weak typeof(self) weakSelf = self;
    _dataSources = @[
                     [CellData instanceWithName:@"OK" value:@"" block:^{
                         [weakSelf okOnly];
                     }],
                     [CellData instanceWithName:@"OK & Cancel" value:@"" block:^{
                         [weakSelf okCancel];
                     }],
                     [CellData instanceWithName:@"YES & NO" value:@"" block:^{
                         [weakSelf yesNo];
                     }],
                     [CellData instanceWithName:@"CustomLabel YES & NO" value:@"" block:^{
                         [weakSelf customLabelYesAndNo];
                     }],
                     [CellData instanceWithName:@"OK Value & Cancel" value:@"" block:^{
                         [weakSelf okValueCancel];
                     }],
                     ];
}

#pragma mark - Show Alert

/**
 OKのみのダイアログ表示
 */
- (void)okOnly
{
    [DSDAlertManager showAlert:self
                         title:@"title"
                       message:@"message"
                            ok:^{
                                NSLog(@"OK tap!");
                            }];
}

/**
 OK-Cancelのダイアログ表示
 */
- (void)okCancel
{
    [DSDAlertManager showAlert:self
                         title:@"title"
                       message:@"message"
                            ok:^{
                                NSLog(@"OK tap!");
                            }
                        cancel:^{
                            NSLog(@"Cancel tap!");
                        }];
}

/**
 YES-NOのダイアログ表示
 */
- (void)yesNo
{
    [DSDAlertManager showAlert:self
                         title:@"title"
                       message:@"message"
                           yes:^{
                               NSLog(@"YES tap!");
                           }
                            no:^{
                                NSLog(@"NO tap!");
                            }];
}

/**
 カスタムラベルYES-NOのダイアログ表示
 */
- (void)customLabelYesAndNo
{
    [DSDAlertManager showAlert:self
                         title:@"title"
                       message:@"message"
                      yesLabel:@"CustomYES"
                           yes:^{
                               NSLog(@"YES tap!");
                           }
                       noLabel:@"CustomNO"
                            no:^{
                                NSLog(@"NO tap!");
                            }];
}

/**
 値入力可能なOK-Cancelのダイアログ表示
 */
- (void)okValueCancel
{
    __weak typeof(self) weakSelf = self;
    [DSDAlertManager showEditAlert:self
                             title:@"title"
                           message:@"message"
                             value:_dataSources[4].value
                                ok:^(NSString *value) {
                                    _dataSources[4].value = value;
                                    NSLog(@"OK(%@) tap!", value);
                                    [weakSelf.tableView reloadData];
                                }
                            cancel:^{
                                NSLog(@"Cancel tap!");
                            }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _dataSources[indexPath.row].block();
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataSources[indexPath.row].name;
    
    NSString *value = _dataSources[indexPath.row].value;
    if(![value isEqualToString:@""]){
        cell.textLabel.text = [NSString stringWithFormat:@"%@ value:(%@)", cell.textLabel.text, value];
    }
    return cell;
}

@end
