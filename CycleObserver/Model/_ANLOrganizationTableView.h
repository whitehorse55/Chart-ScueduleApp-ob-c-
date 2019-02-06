// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLOrganizationTableView.h instead.

@import CoreData;

extern const struct ANLOrganizationTableViewRelationships {
	__unsafe_unretained NSString *operation;
	__unsafe_unretained NSString *operator;
	__unsafe_unretained NSString *organization;
	__unsafe_unretained NSString *process;
} ANLOrganizationTableViewRelationships;

@class ANLOperation;
@class ANLOperator;
@class ANLOrganization;
@class ANLProcess;

@interface ANLOrganizationTableViewID : NSManagedObjectID {}
@end

@interface _ANLOrganizationTableView : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ANLOrganizationTableViewID* objectID;

@property (nonatomic, strong) ANLOperation *operation;

//- (BOOL)validateOperation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) ANLOperator *operator;

//- (BOOL)validateOperator:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) ANLOrganization *organization;

//- (BOOL)validateOrganization:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) ANLProcess *process;

//- (BOOL)validateProcess:(id*)value_ error:(NSError**)error_;

@end

@interface _ANLOrganizationTableView (CoreDataGeneratedPrimitiveAccessors)

- (ANLOperation*)primitiveOperation;
- (void)setPrimitiveOperation:(ANLOperation*)value;

- (ANLOperator*)primitiveOperator;
- (void)setPrimitiveOperator:(ANLOperator*)value;

- (ANLOrganization*)primitiveOrganization;
- (void)setPrimitiveOrganization:(ANLOrganization*)value;

- (ANLProcess*)primitiveProcess;
- (void)setPrimitiveProcess:(ANLProcess*)value;

@end
