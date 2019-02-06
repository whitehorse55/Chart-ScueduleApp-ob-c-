// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLCycle.h instead.

@import CoreData;

extern const struct ANLCycleAttributes {
	__unsafe_unretained NSString *index;
} ANLCycleAttributes;

extern const struct ANLCycleRelationships {
	__unsafe_unretained NSString *measure;
	__unsafe_unretained NSString *segments;
} ANLCycleRelationships;

@class ANLMeasure;
@class ANLSegment;

@interface ANLCycleID : NSManagedObjectID {}
@end

@interface _ANLCycle : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ANLCycleID* objectID;

@property (nonatomic, strong) NSNumber* index;

@property (atomic) int64_t indexValue;
- (int64_t)indexValue;
- (void)setIndexValue:(int64_t)value_;

//- (BOOL)validateIndex:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) ANLMeasure *measure;

//- (BOOL)validateMeasure:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *segments;

- (NSMutableSet*)segmentsSet;

@end

@interface _ANLCycle (SegmentsCoreDataGeneratedAccessors)
- (void)addSegments:(NSSet*)value_;
- (void)removeSegments:(NSSet*)value_;
- (void)addSegmentsObject:(ANLSegment*)value_;
- (void)removeSegmentsObject:(ANLSegment*)value_;

@end

@interface _ANLCycle (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveIndex;
- (void)setPrimitiveIndex:(NSNumber*)value;

- (int64_t)primitiveIndexValue;
- (void)setPrimitiveIndexValue:(int64_t)value_;

- (ANLMeasure*)primitiveMeasure;
- (void)setPrimitiveMeasure:(ANLMeasure*)value;

- (NSMutableSet*)primitiveSegments;
- (void)setPrimitiveSegments:(NSMutableSet*)value;

@end
