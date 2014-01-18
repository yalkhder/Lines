//
//  LIMainViewController.m
//  Lines
//
//  Created by Yasser Al-Khder on 12/3/2013.
//  Copyright (c) 2013 Yasser Al-Khder. All rights reserved.
//

#import "LIMainViewController.h"
#import "LILinearInterpView.h"
#import "LICachedView.h"
#import "LISmoothedBIView.h"

@interface LIMainViewController ()

@end

@implementation LIMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view = [[LISmoothedBIView alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
