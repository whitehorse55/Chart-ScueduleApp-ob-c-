// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLCurrentMeasure.h instead.

@import CoreData;

extern const struct ANLCurrentMeasureRelationships {
	__unsafe_unretained NSString *measure;
	__unsafe_unretained NSString *segment;
} ANLCurrentMeasureRelationships;

@class ANLMeasure;
@class ANLSegment;

@interface ANLCurrentMeasureID : NSManagedObjectID {}
@end

@interface _ANLCurrentMeasure : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ANLCurrentMeasureID* objectID;

@property (nonatomic, strong) ANLMeasure *measure;

//- (BOOL)validateMeasure:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) ANLSegment *segment;

//- (BOOL)validateSegment:(id*)value_ error:(NSError**)error_;

@end

@interface _ANLCurrentMeasure (CoreDataGeneratedPrimitiveAccessors)

- (ANLMeasure*)primitiveMeasure;
- (void)setPrimitiveMeasure:(ANLMeasure*)value;

- (ANLSegment*)primitiveSegment;
- (void)setPrimitiveSegment:(ANLSegment*)value;

@end
