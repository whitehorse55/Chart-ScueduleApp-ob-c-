// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLOrganizationTableView.m instead.

#import "_ANLOrganizationTableView.h"

const struct ANLOrganizationTableViewRelationships ANLOrganizationTableViewRelationships = {
	.operation = @"operation",
	.operator = @"operator",
	.organization = @"organization",
	.process = @"process",
};

@implementation ANLOrganizationTableViewID
@end

@implementation _ANLOrganizationTableView

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ANLOrganizationTableView" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ANLOrganizationTableView";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ANLOrganizationTableView" inManagedObjectContext:moc_];
}

- (ANLOrganizationTableViewID*)objectID {
	return (ANLOrganizationTableViewID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic operation;

@dynamic operator;

@dynamic organization;

@dynamic process;

@end

