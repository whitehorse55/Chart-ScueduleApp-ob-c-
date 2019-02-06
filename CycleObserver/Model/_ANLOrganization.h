// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLOrganization.h instead.

@import CoreData;

extern const struct ANLOrganizationAttributes {
	__unsafe_unretained NSString *name;
} ANLOrganizationAttributes;

extern const struct ANLOrganizationRelationships {
	__unsafe_unretained NSString *organizationTableView;
	__unsafe_unretained NSString *processes;
} ANLOrganizationRelationships;

@class ANLOrganizationTableView;
@class ANLProcess;

@interface ANLOrganizationID : NSManagedObjectID {}
@end

@interface _ANLOrganization : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ANLOrganizationID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) ANLOrganizationTableView *organizationTableView;

//- (BOOL)validateOrganizationTableView:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *processes;

- (NSMutableSet*)processesSet;

@end

@interface _ANLOrganization (ProcessesCoreDataGeneratedAccessors)
- (void)addProcesses:(NSSet*)value_;
- (void)removeProcesses:(NSSet*)value_;
- (void)addProcessesObject:(ANLProcess*)value_;
- (void)removeProcessesObject:(ANLProcess*)value_;

@end

@interface _ANLOrganization (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (ANLOrganizationTableView*)primitiveOrganizationTableView;
- (void)setPrimitiveOrganizationTableView:(ANLOrganizationTableView*)value;

- (NSMutableSet*)primitiveProcesses;
- (void)setPrimitiveProcesses:(NSMutableSet*)value;

@end
