// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLButton.m instead.

#import "_ANLButton.h"

const struct ANLButtonAttributes ANLButtonAttributes = {
	.color = @"color",
	.index = @"index",
	.name = @"name",
};

const struct ANLButtonRelationships ANLButtonRelationships = {
	.measure = @"measure",
	.segments = @"segments",
};

@implementation ANLButtonID
@end

@implementation _ANLButton

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ANLButton" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ANLButton";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ANLButton" inManagedObjectContext:moc_];
}

- (ANLButtonID*)objectID {
	return (ANLButtonID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"colorValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"color"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"indexValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"index"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic color;

- (int64_t)colorValue {
	NSNumber *result = [self color];
	return [result longLongValue];
}

- (void)setColorValue:(int64_t)value_ {
	[self setColor:@(value_)];
}

- (int64_t)primitiveColorValue {
	NSNumber *result = [self primitiveColor];
	return [result longLongValue];
}

- (void)setPrimitiveColorValue:(int64_t)value_ {
	[self setPrimitiveColor:@(value_)];
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

@dynamic name;

@dynamic measure;

@dynamic segments;

- (NSMutableSet*)segmentsSet {
	[self willAccessValueForKey:@"segments"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"segments"];

	[self didAccessValueForKey:@"segments"];
	return result;
}

@end

