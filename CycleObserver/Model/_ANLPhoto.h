// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLPhoto.h instead.

@import CoreData;

extern const struct ANLPhotoAttributes {
	__unsafe_unretained NSString *data;
	__unsafe_unretained NSString *date;
} ANLPhotoAttributes;

extern const struct ANLPhotoRelationships {
	__unsafe_unretained NSString *measure;
} ANLPhotoRelationships;

@class ANLMeasure;

@interface ANLPhotoID : NSManagedObjectID {}
@end

@interface _ANLPhoto : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ANLPhotoID* objectID;

@property (nonatomic, strong) NSData* data;

//- (BOOL)validateData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) ANLMeasure *measure;

//- (BOOL)validateMeasure:(id*)value_ error:(NSError**)error_;

@end

@interface _ANLPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveData;
- (void)setPrimitiveData:(NSData*)value;

- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;

- (ANLMeasure*)primitiveMeasure;
- (void)setPrimitiveMeasure:(ANLMeasure*)value;

@end
