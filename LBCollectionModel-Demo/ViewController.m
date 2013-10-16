//
//  ViewController.m
//  LBCollectionModel-Demo
//
//  Created by Lucian Boboc on 10/16/13.
//  Copyright (c) 2013 Lucian Boboc. All rights reserved.
//

#import "ViewController.h"
#import "LBCollectionModel.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (strong, nonatomic) LBCollectionModel *collectionModel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionModel = [[LBCollectionModel alloc] initWithCollectionView: self.myCollectionView];
    [self.collectionModel loadInitialData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
