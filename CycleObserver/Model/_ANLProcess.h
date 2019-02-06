// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLProcess.h instead.

@import CoreData;

extern const struct ANLProcessAttributes {
	__unsafe_unretained NSString *name;
} ANLProcessAttributes;

extern const struct ANLProcessRelationships {
	__unsafe_unretained NSString *operations;
	__unsafe_unretained NSString *organization;
	__unsafe_unretained NSString *organizationTableView;
} ANLProcessRelationships;

@class ANLOperation;
@class ANLOrganization;
@class ANLOrganizationTableView;

@interface ANLProcessID : NSManagedObjectID {}
@end

@interface _ANLProcess : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ANLProcessID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *operations;

- (NSMutableSet*)operationsSet;

@property (nonatomic, strong) ANLOrganization *organization;

//- (BOOL)validateOrganization:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) ANLOrganizationTableView *organizationTableView;

//- (BOOL)validateOrganizationTableView:(id*)value_ error:(NSError**)error_;

@end

@interface _ANLProcess (OperationsCoreDataGeneratedAccessors)
- (void)addOperations:(NSSet*)value_;
- (void)removeOperations:(NSSet*)value_;
- (void)addOperationsObject:(ANLOperation*)value_;
- (void)removeOperationsObject:(ANLOperation*)value_;

@end

@interface _ANLProcess (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveOperations;
- (void)setPrimitiveOperations:(NSMutableSet*)value;

- (ANLOrganization*)primitiveOrganization;
- (void)setPrimitiveOrganization:(ANLOrganization*)value;

- (ANLOrganizationTableView*)primitiveOrganizationTableView;
- (void)setPrimitiveOrganizationTableView:(ANLOrganizationTableView*)value;

@end
