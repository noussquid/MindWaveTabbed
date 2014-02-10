//
//  BrainDataHistoryDocument.m
//  MindWaveTabbed
//
//  Created by tester on 2/6/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import "BrainDataHistoryDocument.h"
#import "BrainDataEntry.h"

// Use to register for update notifications
NSString * const BrainDataHistoryDocumentBeginChangesNotification =
@"BrainDataHistoryDocumentBeginChangesNotification";

NSString * const BrainDataHistoryDocumentInsertBrainDataEntryNotification =
@"BrainDataHistoryDocumentInsertBrainDataEntryNotification";

NSString * const BrainDataHistoryDocumentDeleteBrainDataEntryNotification =
@"BrainDataHistoryDocumentDeleteBrainDataEntryNotification";

NSString * const BrainDataHistoryDocumentChangesCompleteNotification =
@"BrainDataHistoryDocumentChangesCompleteNotification";

// Use to access data in the notifications
NSString * const BrainDataHistoryDocumentNotificationIndexPathKey =
@"BrainDataHistoryDocumentNotificationIndexPathKey";

@interface BrainDataHistoryDocument()
@property (strong, nonatomic)NSMutableArray *brainDataHistory;
@end

@implementation BrainDataHistoryDocument

#pragma mark - Initialization Methods

- (id)init
{
    self = [super init];
    if (self) {
        _brainDataHistory = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Accessor Methods

-(NSUInteger)count
{
    return [self.brainDataHistory count];
}

+ (NSSet *)keyPathsForValuesAffectingCount
{
    return [NSSet setWithObjects:@"brainDataHistory", nil];
}

#pragma mark - KVO Accessors

- (void)insertObject:(BrainDataEntry *)object inBrainDataHistoryAtIndex:(NSUInteger)index
{
    [self.brainDataHistory insertObject:object atIndex:index];
}

- (void)removeObjectFromBrainDataHistoryAtIndex:(NSUInteger)index
{
    [self.brainDataHistory removeObjectAtIndex:index];
}

#pragma mark - Public Methods

- (BrainDataEntry *)entryAtIndexPath:(NSIndexPath *)indexPath
{
    return self.brainDataHistory[(NSUInteger)indexPath.row];
}

- (NSIndexPath *)indexPathForEntry:(BrainDataEntry *)brainDataEntry
{
    NSUInteger row = [self.brainDataHistory indexOfObject:brainDataEntry];
    return [NSIndexPath indexPathForRow:(NSInteger)row inSection:0];
}

- (void)addEntry:(BrainDataEntry *)brainDataEntry
{
    NSUInteger index = [self insertionPointForDate:brainDataEntry.date];
    NSIndexPath *indexPath =
    [NSIndexPath indexPathForRow:(NSInteger)index inSection:0];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center
     postNotificationName:BrainDataHistoryDocumentBeginChangesNotification
     object:self];
    
    [self insertObject:brainDataEntry inBrainDataHistoryAtIndex:index];
    
    [center
     postNotificationName:
     BrainDataHistoryDocumentInsertBrainDataEntryNotification
     object:self
     userInfo:@{BrainDataHistoryDocumentNotificationIndexPathKey:indexPath}];
    
    [center
     postNotificationName:BrainDataHistoryDocumentChangesCompleteNotification
     object:self];
}

- (void)deleteEntryAtIndexPath:(NSIndexPath *)indexPath
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center
     postNotificationName:BrainDataHistoryDocumentBeginChangesNotification
     object:self];
    
    [self removeObjectFromBrainDataHistoryAtIndex:(NSUInteger)indexPath.row];
    
    [center
     postNotificationName:
     BrainDataHistoryDocumentDeleteBrainDataEntryNotification
     object:self
     userInfo:@{BrainDataHistoryDocumentNotificationIndexPathKey:indexPath}];
    
    [center
     postNotificationName:BrainDataHistoryDocumentChangesCompleteNotification
     object:self];
}

- (void)enumerateEntriesAscending:(BOOL)ascending withBlock:(EntryEnumeratorBlock)block
{
    NSUInteger options = 0;
    if (ascending)
    {
        options = NSEnumerationReverse;
    }
    
    [self.brainDataHistory
     enumerateObjectsWithOptions:options
     usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
         block(obj);
     }];
}

- (NSArray *)brainDataEntriesAfter:(NSDate *)startDate
                         before:(NSDate *)endDate
{
    
    NSPredicate *betweenDates =
    [NSPredicate predicateWithBlock:^BOOL(BrainDataEntry *entry,
                                          NSDictionary *bindings) {
        return ([entry.date compare:startDate] != NSOrderedAscending) &&
        ([entry.date compare:endDate] != NSOrderedDescending);
    }];
    
    return [self.brainDataHistory filteredArrayUsingPredicate:betweenDates];
}

#pragma mark - NSObject Methods

-(NSString *)description
{
    return [NSString stringWithFormat:
            @"BrainDataHistoryDocument: count = %@, history = %@",
            @(self.count), self.brainDataHistory];
}



#pragma mark - Private Methods

- (NSUInteger)insertionPointForDate:(NSDate *)date
{
    NSUInteger index = 0;
    for (BrainDataEntry *entry in self.brainDataHistory)
    {
        if ([date compare:entry.date] == NSOrderedDescending)
        {
            return index;
        }
        index++;
    }
    return index;
}


@end
