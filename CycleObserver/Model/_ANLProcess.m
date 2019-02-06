// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLProcess.m instead.

#import "_ANLProcess.h"

const struct ANLProcessAttributes ANLProcessAttributes = {
	.name = @"name",
};

const struct ANLProcessRelationships ANLProcessRelationships = {
	.operations = @"operations",
	.organization = @"organization",
	.organizationTableView = @"organizationTableView",
};

@implementation ANLProcessID
@end

@implementation _ANLProcess

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ANLProcess" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ANLProcess";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ANLProcess" inManagedObjectContext:moc_];
}

- (ANLProcessID*)objectID {
	return (ANLProcessID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic operations;

- (NSMutableSet*)operationsSet {
	[self willAccessValueForKey:@"operations"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"operations"];

	[self didAccessValueForKey:@"operations"];
	return result;
}

@dynamic organization;

@dynamic organizationTableView;

@end

