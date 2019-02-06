// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLOperator.h instead.

@import CoreData;

extern const struct ANLOperatorAttributes {
	__unsafe_unretained NSString *name;
} ANLOperatorAttributes;

extern const struct ANLOperatorRelationships {
	__unsafe_unretained NSString *measures;
	__unsafe_unretained NSString *operation;
	__unsafe_unretained NSString *organizationTableView;
} ANLOperatorRelationships;

@class ANLMeasure;
@class ANLOperation;
@class ANLOrganizationTableView;

@interface ANLOperatorID : NSManagedObjectID {}
@end

@interface _ANLOperator : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ANLOperatorID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *measures;

- (NSMutableSet*)measuresSet;

@property (nonatomic, strong) ANLOperation *operation;

//- (BOOL)validateOperation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) ANLOrganizationTableView *organizationTableView;

//- (BOOL)validateOrganizationTableView:(id*)value_ error:(NSError**)error_;

@end

@interface _ANLOperator (MeasuresCoreDataGeneratedAccessors)
- (void)addMeasures:(NSSet*)value_;
- (void)removeMeasures:(NSSet*)value_;
- (void)addMeasuresObject:(ANLMeasure*)value_;
- (void)removeMeasuresObject:(ANLMeasure*)value_;

@end

@interface _ANLOperator (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveMeasures;
- (void)setPrimitiveMeasures:(NSMutableSet*)value;

- (ANLOperation*)primitiveOperation;
- (void)setPrimitiveOperation:(ANLOperation*)value;

- (ANLOrganizationTableView*)primitiveOrganizationTableView;
- (void)setPrimitiveOrganizationTableView:(ANLOrganizationTableView*)value;

@end
