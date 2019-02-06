// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLMeasure.h instead.

@import CoreData;

extern const struct ANLMeasureAttributes {
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *dateText;
	__unsafe_unretained NSString *notes;
	__unsafe_unretained NSString *place;
	__unsafe_unretained NSString *taktTime;
	__unsafe_unretained NSString *timeScale;
} ANLMeasureAttributes;

extern const struct ANLMeasureRelationships {
	__unsafe_unretained NSString *buttons;
	__unsafe_unretained NSString *currentMeasure;
	__unsafe_unretained NSString *cycles;
	__unsafe_unretained NSString *operator;
	__unsafe_unretained NSString *photos;
} ANLMeasureRelationships;

@class ANLButton;
@class ANLCurrentMeasure;
@class ANLCycle;
@class ANLOperator;
@class ANLPhoto;

@interface ANLMeasureID : NSManagedObjectID {}
@end

@interface _ANLMeasure : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ANLMeasureID* objectID;

@property (nonatomic, strong) NSDate* date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* dateText;

//- (BOOL)validateDateText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* notes;

//- (BOOL)validateNotes:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* place;

//- (BOOL)validatePlace:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* taktTime;

@property (atomic) float taktTimeValue;
- (float)taktTimeValue;
- (void)setTaktTimeValue:(float)value_;

//- (BOOL)validateTaktTime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* timeScale;

@property (atomic) int64_t timeScaleValue;
- (int64_t)timeScaleValue;
- (void)setTimeScaleValue:(int64_t)value_;

//- (BOOL)validateTimeScale:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *buttons;

- (NSMutableSet*)buttonsSet;

@property (nonatomic, strong) ANLCurrentMeasure *currentMeasure;

//- (BOOL)validateCurrentMeasure:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *cycles;

- (NSMutableSet*)cyclesSet;

@property (nonatomic, strong) ANLOperator *operator;

//- (BOOL)validateOperator:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *photos;

- (NSMutableSet*)photosSet;

@end

@interface _ANLMeasure (ButtonsCoreDataGeneratedAccessors)
- (void)addButtons:(NSSet*)value_;
- (void)removeButtons:(NSSet*)value_;
- (void)addButtonsObject:(ANLButton*)value_;
- (void)removeButtonsObject:(ANLButton*)value_;

@end

@interface _ANLMeasure (CyclesCoreDataGeneratedAccessors)
- (void)addCycles:(NSSet*)value_;
- (void)removeCycles:(NSSet*)value_;
- (void)addCyclesObject:(ANLCycle*)value_;
- (void)removeCyclesObject:(ANLCycle*)value_;

@end

@interface _ANLMeasure (PhotosCoreDataGeneratedAccessors)
- (void)addPhotos:(NSSet*)value_;
- (void)removePhotos:(NSSet*)value_;
- (void)addPhotosObject:(ANLPhoto*)value_;
- (void)removePhotosObject:(ANLPhoto*)value_;

@end

@interface _ANLMeasure (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;

- (NSString*)primitiveDateText;
- (void)setPrimitiveDateText:(NSString*)value;

- (NSString*)primitiveNotes;
- (void)setPrimitiveNotes:(NSString*)value;

- (NSString*)primitivePlace;
- (void)setPrimitivePlace:(NSString*)value;

- (NSNumber*)primitiveTaktTime;
- (void)setPrimitiveTaktTime:(NSNumber*)value;

- (float)primitiveTaktTimeValue;
- (void)setPrimitiveTaktTimeValue:(float)value_;

- (NSNumber*)primitiveTimeScale;
- (void)setPrimitiveTimeScale:(NSNumber*)value;

- (int64_t)primitiveTimeScaleValue;
- (void)setPrimitiveTimeScaleValue:(int64_t)value_;

- (NSMutableSet*)primitiveButtons;
- (void)setPrimitiveButtons:(NSMutableSet*)value;

- (ANLCurrentMeasure*)primitiveCurrentMeasure;
- (void)setPrimitiveCurrentMeasure:(ANLCurrentMeasure*)value;

- (NSMutableSet*)primitiveCycles;
- (void)setPrimitiveCycles:(NSMutableSet*)value;

- (ANLOperator*)primitiveOperator;
- (void)setPrimitiveOperator:(ANLOperator*)value;

- (NSMutableSet*)primitivePhotos;
- (void)setPrimitivePhotos:(NSMutableSet*)value;

@end
