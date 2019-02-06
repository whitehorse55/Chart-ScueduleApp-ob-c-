// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLOrganization.m instead.

#import "_ANLOrganization.h"

const struct ANLOrganizationAttributes ANLOrganizationAttributes = {
	.name = @"name",
};

const struct ANLOrganizationRelationships ANLOrganizationRelationships = {
	.organizationTableView = @"organizationTableView",
	.processes = @"processes",
};

@implementation ANLOrganizationID
@end

@implementation _ANLOrganization

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ANLOrganization" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ANLOrganization";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ANLOrganization" inManagedObjectContext:moc_];
}

- (ANLOrganizationID*)objectID {
	return (ANLOrganizationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic organizationTableView;

@dynamic processes;

- (NSMutableSet*)processesSet {
	[self willAccessValueForKey:@"processes"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"processes"];

	[self didAccessValueForKey:@"processes"];
	return result;
}

@end

