//
//  MYQPageTableViewController.m
//  ZGHomePageHorizontalView
//
//  Created by 徐宗根 on 2017/7/21.
//  Copyright © 2017年 Zong. All rights reserved.
//

#import "ZGPageTableViewController.h"
#import "ZGHomePageHorizontalViewController.h"

@interface ZGPageTableViewController ()

@end

@implementation ZGPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - 
- (instancetype)initWithContainVC:(ZGHomePageHorizontalViewController *)contianVC
{
    if (self = [super init]) {
        self.containVC = contianVC;
    }
    return self;
}


#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 0) {
        
        // 处理父scrollView下拉，上拉没有减速效果
        if (self.containVC.tableView.contentOffset.y > -64.0) {
            self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
        }
        
        
        //        NSLog(@"scrollView contentOffset %@ ",NSStringFromCGPoint(scrollView.contentOffset));
        if (self.containVC.tableView.contentOffset.y < ZGHomePageHorizontalTopViewHeight - 64.0) {
            CGPoint tmpContentOffset = self.containVC.tableView.contentOffset;
            tmpContentOffset.y += scrollView.contentOffset.y;
            self.containVC.tableView.contentOffset = tmpContentOffset;
            
            self.tableView.contentOffset = CGPointMake(0, 0);
        }
        
    }else {
        
        // 处理父scrollView下拉，上拉没有减速效果
        if (self.containVC.tableView.contentOffset.y < -64.0) {
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        
        if (self.containVC.tableView.contentOffset.y >= - 64 - 60) {
            
            
            CGPoint tmpContentOffset = self.containVC.tableView.contentOffset;
            tmpContentOffset.y += scrollView.contentOffset.y;
            self.containVC.tableView.contentOffset = tmpContentOffset;
        }
        self.tableView.contentOffset = CGPointMake(0, 0);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(self.containVC.tableView.contentOffset.y < -64.0)
    {
        [self.containVC.tableView setContentOffset:CGPointMake(0, -64.0) animated:YES];
    }else if (self.containVC.tableView.contentOffset.y > ZGHomePageHorizontalTopViewHeight - 64.0){
        [self.containVC.tableView setContentOffset:CGPointMake(0, ZGHomePageHorizontalTopViewHeight - 64.0) animated:YES];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        if(self.containVC.tableView.contentOffset.y < -64.0)
        {
            [self.containVC.tableView setContentOffset:CGPointMake(0, -64.0) animated:YES];
        }else if (self.containVC.tableView.contentOffset.y > ZGHomePageHorizontalTopViewHeight - 64.0){
            [self.containVC.tableView setContentOffset:CGPointMake(0, ZGHomePageHorizontalTopViewHeight - 64.0) animated:YES];
        }
    }
}



@end