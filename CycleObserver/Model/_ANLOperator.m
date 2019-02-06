// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLOperator.m instead.

#import "_ANLOperator.h"

const struct ANLOperatorAttributes ANLOperatorAttributes = {
	.name = @"name",
};

const struct ANLOperatorRelationships ANLOperatorRelationships = {
	.measures = @"measures",
	.operation = @"operation",
	.organizationTableView = @"organizationTableView",
};

@implementation ANLOperatorID
@end

@implementation _ANLOperator

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ANLOperator" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ANLOperator";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ANLOperator" inManagedObjectContext:moc_];
}

- (ANLOperatorID*)objectID {
	return (ANLOperatorID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic measures;

- (NSMutableSet*)measuresSet {
	[self willAccessValueForKey:@"measures"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"measures"];

	[self didAccessValueForKey:@"measures"];
	return result;
}

@dynamic operation;

@dynamic organizationTableView;

@end

