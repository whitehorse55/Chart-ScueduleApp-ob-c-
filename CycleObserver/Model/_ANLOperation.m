// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLOperation.m instead.

#import "_ANLOperation.h"

const struct ANLOperationAttributes ANLOperationAttributes = {
	.name = @"name",
};

const struct ANLOperationRelationships ANLOperationRelationships = {
	.operators = @"operators",
	.organizationTableView = @"organizationTableView",
	.process = @"process",
};

@implementation ANLOperationID
@end

@implementation _ANLOperation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ANLOperation" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ANLOperation";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ANLOperation" inManagedObjectContext:moc_];
}

- (ANLOperationID*)objectID {
	return (ANLOperationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic operators;

- (NSMutableSet*)operatorsSet {
	[self willAccessValueForKey:@"operators"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"operators"];

	[self didAccessValueForKey:@"operators"];
	return result;
}

@dynamic organizationTableView;

@dynamic process;

@end

