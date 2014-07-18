//
//  KKViewController.m
//  ThreadDemo
//
//  Created by user on 14-7-18.
//  Copyright (c) 2014年 QTPay. All rights reserved.
//

#import "KKViewController.h"

@interface KKViewController () {
    int tickets;
    int count;
    NSThread *ticketThread1;
    NSThread *ticketThread2;
    NSLock *ticketLock;
    NSCondition *ticketCondition;
}

@end

@implementation KKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tickets = 100;
    ticketLock = [[NSLock alloc] init];
    ticketCondition = [[NSCondition alloc] init];
    
    ticketThread1 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicket) object:nil];
    ticketThread1.name = @"Thread-1";
    [ticketThread1 start];
    
    ticketThread2 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicket) object:nil];
    ticketThread2.name = @"Thread-2";
    [ticketThread2 start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sellTicket
{
    while (TRUE) {
//        [ticketLock lock];
        [ticketCondition lock];
        
        if (tickets <= 0)
            break;
        
//        [NSThread sleepForTimeInterval:0.09];
        
        count = 100 - --tickets;
        NSLog(@"卖出%d张票, 剩余%d张票, 当前线程: %@", count, tickets, [[NSThread currentThread] name]);
//        self.ticketsLabel.text = [NSString stringWithFormat:@"卖出%d张票, 剩余%d张票, 当前线程: %@", tickets, count, [[NSThread currentThread] name]];
        
        
        [ticketCondition unlock];
    }
}

@end
