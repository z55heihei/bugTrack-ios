//
//  noficaitionManagerViewController.m
//  bugTrack
//
//  Created by zhangyw on 14-12-30.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#import "noficaitionManagerViewController.h"

@interface noficaitionManagerViewController ()
@property (nonatomic,strong) NSMutableArray *bugNotifcationArray;
@end

@implementation noficaitionManagerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.bugNotifcationArray = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(bugReceiveRemote:)
                                                 name:@"bugReceiveRemote"
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.bugNotifcationArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ideniferstring = @"cellIdenifer";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:ideniferstring];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:ideniferstring];
    }
    
    NSInteger row = [indexPath row];
    NSString *bugDetail = self.bugNotifcationArray[row];
    cell.textLabel.text = bugDetail;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)bugReceiveRemote:(NSNotification *)nofication
{
    NSDictionary *reciveRemoteDict = nofication.userInfo;
    NSString *bugDetail = reciveRemoteDict[@"aps"][@"alert"];
    [self.bugNotifcationArray addObject:bugDetail];
    [self.tableView reloadData];
}

@end
