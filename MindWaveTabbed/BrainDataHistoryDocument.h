//
//  BrainDataHistoryDocument.h
//  MindWaveTabbed
//
//  Created by tester on 2/6/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BrainDataEntry;
typedef void (^EntryEnumeratorBlock) (BrainDataEntry *entry);

// Use to register for update notifications
extern NSString * const BrainDataHistoryDocumentBeginChangesNotification;
extern NSString * const BrainDataHistoryDocumentInsertBrainDataEntryNotification;
extern NSString * const BrainDataHistoryDocumentDeleteBrainDataEntryNotification;
extern NSString * const BrainDataHistoryDocumentChangesCompleteNotification;

// Use to access data in the notifications
extern NSString * const BrainDataHistoryDocumentNotificationIndexPathKey;

@interface BrainDataHistoryDocument : NSObject

@property (nonatomic, readonly) NSUInteger count;

- (BrainDataEntry *)entryAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathForEntry:(BrainDataEntry *)brainDataEntry;
- (void)addEntry:(BrainDataEntry *)brainDataEntry;
- (void)deleteEntryAtIndexPath:(NSIndexPath *)indexPath;

- (void)enumerateEntriesAscending:(BOOL)ascending
                        withBlock:(EntryEnumeratorBlock)block;
- (NSArray*)brainDataEntriesAfter:(NSDate *)startDate
                        before:(NSDate *)endDate;
@end
