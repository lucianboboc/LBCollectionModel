//
//  LBCollectionModel.m
//
//  Created by Lucian Boboc on 3/22/13.
//  Copyright (c) 2013 Lucian Boboc. All rights reserved.
//

#import "LBCollectionModel.h"
#import "LBCell.h"
#import "LBFooter.h"

#define kFooterViewIdentifier @"LBCollectionFooterViewIdentifier"
#define kCellIdentifier @"LBCollectionViewCellIdentifier"

#define kPadding 10.0
#define kCellWidth 145.0
#define kCellHeight 145.0

#define kCollectionFooterHeigt 40.0
#define kDefaultItemsCount 10

@interface LBCollectionModel ()
@property (nonatomic) BOOL isLoading;
@property (nonatomic) int elementsCount;

- (void) fetchMoreDataFromTheServerOrFromDatabaseWithCount: (int) count;
- (void) updateUI;
@end

@implementation LBCollectionModel



- (id) initWithCollectionView: (UICollectionView *) collectionView
{
    self = [super init];
    if(self)
    {
        self.myCollectionView = collectionView;
        self.myCollectionView.dataSource = self;
        self.myCollectionView.delegate = self;
        self.modelArray = [@[] mutableCopy];
    }
    return self;
}

- (void) fetchMoreDataFromTheServerOrFromDatabaseWithCount: (int) count
{

#warning  - this method should be implemented as desired
    
    int initialCount = [self.modelArray count];
    for(int i = initialCount; i < initialCount + kDefaultItemsCount; i++)
        self.modelArray[i] = [NSString stringWithFormat: @"%d",i+1];
}

- (void) loadInitialData
{
    [self fetchMoreDataFromTheServerOrFromDatabaseWithCount: kDefaultItemsCount];
}
- (void) updateUI
{
    [self.myCollectionView reloadData];
}







#pragma mark - CollectionView Footer Spinner Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(self.isLoading)
        return;
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.isLoading)
        return;
    if (self.myCollectionView.contentOffset.y + self.myCollectionView.frame.size.height >= self.myCollectionView.contentSize.height - kCollectionFooterHeigt)
        [self startLoadingMore];
}


- (void) startLoadingMore
{
    self.isLoading = YES;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.myCollectionView.collectionViewLayout;
    [UIView animateWithDuration: 0.3 animations: ^{
        [layout invalidateLayout];
    } completion: ^(BOOL finish){
        self.elementsCount = [self.modelArray count];
        [self fetchMoreDataFromTheServerOrFromDatabaseWithCount: [self.modelArray count] + kDefaultItemsCount];     // first load will be kDefaultItemsCount

#warning  - stopLoadingMore method should be called after the fetchMoreDataFromTheServerOrFromDatabaseWithCount returns, if you load data async from a web api call stopLoadingMode on completion.
        
        [self stopLoadingMore];
    }];
}


- (void)stopLoadingMore
{
    self.isLoading = NO;
    [UIView animateWithDuration: 0.3 animations: ^{
        if(self.elementsCount == [self.modelArray count])
            [self.myCollectionView setContentOffset: CGPointMake(0, self.myCollectionView.contentOffset.y - kCollectionFooterHeigt)];
    } completion: ^(BOOL finish){
        [self updateUI];
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if(self.isLoading)
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, kCollectionFooterHeigt);
    else
        return CGSizeZero;
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString: UICollectionElementKindSectionFooter] == YES)
    {
        LBFooter *footer = [self.myCollectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionFooter withReuseIdentifier: kFooterViewIdentifier forIndexPath: indexPath];
        return footer;
    }
    return nil;
}








#pragma mark - CollectionView Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.modelArray count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = kCellIdentifier;
    LBCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: identifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void) configureCell: (LBCell *) cell atIndexPath: (NSIndexPath *) indexPath
{

#warning  - this method should be implemented as desired

    cell.label.text = self.modelArray[indexPath.row];
}






#pragma mark - CollectionView FlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kCellWidth, kCellHeight);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kPadding, kPadding, kPadding, kPadding);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kPadding;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kPadding;
}

@end
