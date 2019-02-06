// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLSegment.m instead.

#import "_ANLSegment.h"

const struct ANLSegmentAttributes ANLSegmentAttributes = {
	.duration = @"duration",
	.index = @"index",
	.initialTime = @"initialTime",
};

const struct ANLSegmentRelationships ANLSegmentRelationships = {
	.button = @"button",
	.currentMeasure = @"currentMeasure",
	.cycle = @"cycle",
};

@implementation ANLSegmentID
@end

@implementation _ANLSegment

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ANLSegment" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ANLSegment";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ANLSegment" inManagedObjectContext:moc_];
}

- (ANLSegmentID*)objectID {
	return (ANLSegmentID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"durationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"duration"];
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

@dynamic duration;

- (float)durationValue {
	NSNumber *result = [self duration];
	return [result floatValue];
}

- (void)setDurationValue:(float)value_ {
	[self setDuration:@(value_)];
}

- (float)primitiveDurationValue {
	NSNumber *result = [self primitiveDuration];
	return [result floatValue];
}

- (void)setPrimitiveDurationValue:(float)value_ {
	[self setPrimitiveDuration:@(value_)];
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

@dynamic initialTime;

@dynamic button;

@dynamic currentMeasure;

@dynamic cycle;

@end

