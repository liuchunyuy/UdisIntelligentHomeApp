//
//  HMDatabasePool.h
//  HMDB
//
//  Created by August Mueller on 6/22/11.
//  Copyright 2011 Flying Meat Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@class HMDatabase;

/** Pool of `<HMDatabase>` objects.

 ### See also
 
 - `<HMDatabaseQueue>`
 - `<HMDatabase>`

 @warning Before using `HMDatabasePool`, please consider using `<HMDatabaseQueue>` instead.

 If you really really really know what you're doing and `HMDatabasePool` is what
 you really really need (ie, you're using a read only database), OK you can use
 it.  But just be careful not to deadlock!

 For an example on deadlocking, search for:
 `ONLY_USE_THE_POOL_IF_YOU_ARE_DOING_READS_OTHERWISE_YOULL_DEADLOCK_USE_HMDatabaseQUEUE_INSTEAD`
 in the main.m file.
 */

@interface HMDatabasePool : NSObject {
    NSString            *_path;
    
    dispatch_queue_t    _lockQueue;
    
    NSMutableArray      *_databaseInPool;
    NSMutableArray      *_databaseOutPool;
    
    __unsafe_unretained id _delegate;
    
    NSUInteger          _maximumNumberOfDatabasesToCreate;
}

@property (atomic, retain) NSString *path;
@property (atomic, assign) id delegate;
@property (atomic, assign) NSUInteger maximumNumberOfDatabasesToCreate;

///---------------------
/// @name Initialization
///---------------------

/** Create pool using path.

 @param aPath The file path of the database.

 @return The `HMDatabasePool` object. `nil` on error.
 */

+ (instancetype)databasePoolWithPath:(NSString*)aPath;

/** Create pool using path.

 @param aPath The file path of the database.

 @return The `HMDatabasePool` object. `nil` on error.
 */

- (instancetype)initWithPath:(NSString*)aPath;

///------------------------------------------------
/// @name Keeping track of checked in/out databases
///------------------------------------------------

/** Number of checked-in databases in pool
 
 @returns Number of databases
 */

- (NSUInteger)countOfCheckedInDatabases;

/** Number of checked-out databases in pool

 @returns Number of databases
 */

- (NSUInteger)countOfCheckedOutDatabases;

/** Total number of databases in pool

 @returns Number of databases
 */

- (NSUInteger)countOfOpenDatabases;

/** Release all databases in pool */

- (void)releaseAllDatabases;

///------------------------------------------
/// @name Perform database operations in pool
///------------------------------------------

/** Synchronously perform database operations in pool.

 @param block The code to be run on the `HMDatabasePool` pool.
 */

- (void)inDatabase:(void (^)(HMDatabase *db))block;

/** Synchronously perform database operations in pool using transaction.

 @param block The code to be run on the `HMDatabasePool` pool.
 */

- (void)inTransaction:(void (^)(HMDatabase *db, BOOL *rollback))block;

/** Synchronously perform database operations in pool using deferred transaction.

 @param block The code to be run on the `HMDatabasePool` pool.
 */

- (void)inDeferredTransaction:(void (^)(HMDatabase *db, BOOL *rollback))block;

#if SQLITE_VERSION_NUMBER >= 3007000

/** Synchronously perform database operations in pool using save point.

 @param block The code to be run on the `HMDatabasePool` pool.

 @warning You can not nest these, since calling it will pull another database out of the pool and you'll get a deadlock. If you need to nest, use `<[HMDatabase startSavePointWithName:error:]>` instead.
*/

- (NSError*)inSavePoint:(void (^)(HMDatabase *db, BOOL *rollback))block;
#endif

@end


@interface NSObject (HMDatabasePoolDelegate)

- (BOOL)databasePool:(HMDatabasePool*)pool shouldAddDatabaseToPool:(HMDatabase*)database;

@end

