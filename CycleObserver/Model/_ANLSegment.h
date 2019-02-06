// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLSegment.h instead.

@import CoreData;

extern const struct ANLSegmentAttributes {
	__unsafe_unretained NSString *duration;
	__unsafe_unretained NSString *index;
	__unsafe_unretained NSString *initialTime;
} ANLSegmentAttributes;

extern const struct ANLSegmentRelationships {
	__unsafe_unretained NSString *button;
	__unsafe_unretained NSString *currentMeasure;
	__unsafe_unretained NSString *cycle;
} ANLSegmentRelationships;

@class ANLButton;
@class ANLCurrentMeasure;
@class ANLCycle;

@interface ANLSegmentID : NSManagedObjectID {}
@end

@interface _ANLSegment : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ANLSegmentID* objectID;

@property (nonatomic, strong) NSNumber* duration;

@property (atomic) float durationValue;
- (float)durationValue;
- (void)setDurationValue:(float)value_;

//- (BOOL)validateDuration:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* index;

@property (atomic) int64_t indexValue;
- (int64_t)indexValue;
- (void)setIndexValue:(int64_t)value_;

//- (BOOL)validateIndex:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* initialTime;

//- (BOOL)validateInitialTime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) ANLButton *button;

//- (BOOL)validateButton:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) ANLCurrentMeasure *currentMeasure;

//- (BOOL)validateCurrentMeasure:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) ANLCycle *cycle;

//- (BOOL)validateCycle:(id*)value_ error:(NSError**)error_;

@end

@interface _ANLSegment (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveDuration;
- (void)setPrimitiveDuration:(NSNumber*)value;

- (float)primitiveDurationValue;
- (void)setPrimitiveDurationValue:(float)value_;

- (NSNumber*)primitiveIndex;
- (void)setPrimitiveIndex:(NSNumber*)value;

- (int64_t)primitiveIndexValue;
- (void)setPrimitiveIndexValue:(int64_t)value_;

- (NSDate*)primitiveInitialTime;
- (void)setPrimitiveInitialTime:(NSDate*)value;

- (ANLButton*)primitiveButton;
- (void)setPrimitiveButton:(ANLButton*)value;

- (ANLCurrentMeasure*)primitiveCurrentMeasure;
- (void)setPrimitiveCurrentMeasure:(ANLCurrentMeasure*)value;

- (ANLCycle*)primitiveCycle;
- (void)setPrimitiveCycle:(ANLCycle*)value;

@end
