// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLOperation.h instead.

@import CoreData;

extern const struct ANLOperationAttributes {
	__unsafe_unretained NSString *name;
} ANLOperationAttributes;

extern const struct ANLOperationRelationships {
	__unsafe_unretained NSString *operators;
	__unsafe_unretained NSString *organizationTableView;
	__unsafe_unretained NSString *process;
} ANLOperationRelationships;

@class ANLOperator;
@class ANLOrganizationTableView;
@class ANLProcess;

@interface ANLOperationID : NSManagedObjectID {}
@end

@interface _ANLOperation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ANLOperationID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *operators;

- (NSMutableSet*)operatorsSet;

@property (nonatomic, strong) ANLOrganizationTableView *organizationTableView;

//- (BOOL)validateOrganizationTableView:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) ANLProcess *process;

//- (BOOL)validateProcess:(id*)value_ error:(NSError**)error_;

@end

@interface _ANLOperation (OperatorsCoreDataGeneratedAccessors)
- (void)addOperators:(NSSet*)value_;
- (void)removeOperators:(NSSet*)value_;
- (void)addOperatorsObject:(ANLOperator*)value_;
- (void)removeOperatorsObject:(ANLOperator*)value_;

@end

@interface _ANLOperation (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveOperators;
- (void)setPrimitiveOperators:(NSMutableSet*)value;

- (ANLOrganizationTableView*)primitiveOrganizationTableView;
- (void)setPrimitiveOrganizationTableView:(ANLOrganizationTableView*)value;

- (ANLProcess*)primitiveProcess;
- (void)setPrimitiveProcess:(ANLProcess*)value;

@end
