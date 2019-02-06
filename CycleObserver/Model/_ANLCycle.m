// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLCycle.m instead.

#import "_ANLCycle.h"

const struct ANLCycleAttributes ANLCycleAttributes = {
	.index = @"index",
};

const struct ANLCycleRelationships ANLCycleRelationships = {
	.measure = @"measure",
	.segments = @"segments",
};

@implementation ANLCycleID
@end

@implementation _ANLCycle

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ANLCycle" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ANLCycle";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ANLCycle" inManagedObjectContext:moc_];
}

- (ANLCycleID*)objectID {
	return (ANLCycleID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"indexValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"index"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic index;

- (int64_t)indexValue {
	NSNumber *result = [self index];
	return [result longLongValue];
}

- (void)setIndexValue:(int64_t)value_ {
	[self setIndex:@(value_)];
}

- (int64_t)primitiveIndexValue {
	NSNumber *result = [self primitiveIndex];
	return [result longLongValue];
}

- (void)setPrimitiveIndexValue:(int64_t)value_ {
	[self setPrimitiveIndex:@(value_)];
}

@dynamic measure;

@dynamic segments;

- (NSMutableSet*)segmentsSet {
	[self willAccessValueForKey:@"segments"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"segments"];

	[self didAccessValueForKey:@"segments"];
	return result;
}

@end

