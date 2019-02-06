// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLButton.h instead.

@import CoreData;

extern const struct ANLButtonAttributes {
	__unsafe_unretained NSString *color;
	__unsafe_unretained NSString *index;
	__unsafe_unretained NSString *name;
} ANLButtonAttributes;

extern const struct ANLButtonRelationships {
	__unsafe_unretained NSString *measure;
	__unsafe_unretained NSString *segments;
} ANLButtonRelationships;

@class ANLMeasure;
@class ANLSegment;

@interface ANLButtonID : NSManagedObjectID {}
@end

@interface _ANLButton : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ANLButtonID* objectID;

@property (nonatomic, strong) NSNumber* color;

@property (atomic) int64_t colorValue;
- (int64_t)colorValue;
- (void)setColorValue:(int64_t)value_;

//- (BOOL)validateColor:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* index;

@property (atomic) int64_t indexValue;
- (int64_t)indexValue;
- (void)setIndexValue:(int64_t)value_;

//- (BOOL)validateIndex:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) ANLMeasure *measure;

//- (BOOL)validateMeasure:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *segments;

- (NSMutableSet*)segmentsSet;

@end

@interface _ANLButton (SegmentsCoreDataGeneratedAccessors)
- (void)addSegments:(NSSet*)value_;
- (void)removeSegments:(NSSet*)value_;
- (void)addSegmentsObject:(ANLSegment*)value_;
- (void)removeSegmentsObject:(ANLSegment*)value_;

@end

@interface _ANLButton (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveColor;
- (void)setPrimitiveColor:(NSNumber*)value;

- (int64_t)primitiveColorValue;
- (void)setPrimitiveColorValue:(int64_t)value_;

- (NSNumber*)primitiveIndex;
- (void)setPrimitiveIndex:(NSNumber*)value;

- (int64_t)primitiveIndexValue;
- (void)setPrimitiveIndexValue:(int64_t)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (ANLMeasure*)primitiveMeasure;
- (void)setPrimitiveMeasure:(ANLMeasure*)value;

- (NSMutableSet*)primitiveSegments;
- (void)setPrimitiveSegments:(NSMutableSet*)value;

@end
