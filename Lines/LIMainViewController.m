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

@property (strong, nonatomic) UIButton *clearButton;
@property (strong, nonatomic) LISmoothedBIView *smoothedBIView;

@end

@implementation LIMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.view = [[LISmoothedBIView alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
    self.smoothedBIView = [[LISmoothedBIView alloc] initWithFrame:self.view.frame];
    self.smoothedBIView.autoresizesSubviews = YES;
    self.smoothedBIView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.smoothedBIView];
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.clearButton.frame = CGRectMake(self.view.bounds.size.width - 75, 25, 70, 30);  // yea yea need to dynamically do that
    [self.clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    [self.clearButton addTarget:self action:@selector(clearButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.clearButton.autoresizesSubviews = YES;
    self.clearButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self.view addSubview:self.clearButton];
}

- (void)clearButtonPressed
{
    NSLog(@"Clear Button Pressed");
    [self.smoothedBIView clearView];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
