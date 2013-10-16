 //
//  LBCollectionModel.h
//
//  Created by Lucian Boboc on 3/22/13.
//  Copyright (c) 2013 Lucian Boboc. All rights reserved.
//

#import <Foundation/Foundation.h>

#if ! __has_feature(objc_arc)
#error LBCollectionViewModel class is ARC only.
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
#error LBCollectionViewModel class needs iOS 7.0 or later.
#endif

@interface LBCollectionModel : NSObject <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *myCollectionView;
@property (strong, nonatomic) NSMutableArray *modelArray;

- (id) initWithCollectionView: (UICollectionView *) collectionView;
- (void) loadInitialData;
@end
