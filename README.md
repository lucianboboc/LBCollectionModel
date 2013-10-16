LBCollectionModel
====================================

LBCollectionModel
 
This project will provide a collectionView delegate and data source class which implements the "Load more" option.
To use this in your project you have to:
 
1. copy the <code>LBCollectionModel</code>,<code>LBFooter</code> and <code>LBCell</code> classes into your project.
2. In your view controller you have to instantiate this class:
<code>self.collectionModel = [[LBCollectionModel alloc] initWithCollectionView: self.myCollectionView];</code>
3. Perform an initial load: <code>[self.collectionModel loadInitialData];</code>
4. Inside the <code>LBCollectionModel</code> class implementation replace the <code>fetchMoreDataFromTheServerOrFromDatabaseWithCount:</code> and <code>configureCell:atIndexPath:</code> methods with your implementation.
 
That's it, enjoy!
 
https://twitter.com/lucianboboc
