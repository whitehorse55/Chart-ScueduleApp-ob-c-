// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLMeasure.m instead.

#import "_ANLMeasure.h"

const struct ANLMeasureAttributes ANLMeasureAttributes = {
	.date = @"date",
	.dateText = @"dateText",
	.notes = @"notes",
	.place = @"place",
	.taktTime = @"taktTime",
	.timeScale = @"timeScale",
};

const struct ANLMeasureRelationships ANLMeasureRelationships = {
	.buttons = @"buttons",
	.currentMeasure = @"currentMeasure",
	.cycles = @"cycles",
	.operator = @"operator",
	.photos = @"photos",
};

@implementation ANLMeasureID
@end

@implementation _ANLMeasure

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ANLMeasure" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ANLMeasure";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ANLMeasure" inManagedObjectContext:moc_];
}

- (ANLMeasureID*)objectID {
	return (ANLMeasureID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"taktTimeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"taktTime"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"timeScaleValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"timeScale"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic date;

@dynamic dateText;

@dynamic notes;

@dynamic place;

@dynamic taktTime;

- (float)taktTimeValue {
	NSNumber *result = [self taktTime];
	return [result floatValue];
}

- (void)setTaktTimeValue:(float)value_ {
	[self setTaktTime:@(value_)];
}

- (float)primitiveTaktTimeValue {
	NSNumber *result = [self primitiveTaktTime];
	return [result floatValue];
}

- (void)setPrimitiveTaktTimeValue:(float)value_ {
	[self setPrimitiveTaktTime:@(value_)];
}

@dynamic timeScale;

- (int64_t)timeScaleValue {
	NSNumber *result = [self timeScale];
	return [result longLongValue];
}

- (void)setTimeScaleValue:(int64_t)value_ {
	[self setTimeScale:@(value_)];
}

- (int64_t)primitiveTimeScaleValue {
	NSNumber *result = [self primitiveTimeScale];
	return [result longLongValue];
}

- (void)setPrimitiveTimeScaleValue:(int64_t)value_ {
	[self setPrimitiveTimeScale:@(value_)];
}

@dynamic buttons;

- (NSMutableSet*)buttonsSet {
	[self willAccessValueForKey:@"buttons"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"buttons"];

	[self didAccessValueForKey:@"buttons"];
	return result;
}

@dynamic currentMeasure;

@dynamic cycles;

- (NSMutableSet*)cyclesSet {
	[self willAccessValueForKey:@"cycles"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"cycles"];

	[self didAccessValueForKey:@"cycles"];
	return result;
}

@dynamic operator;

@dynamic photos;

- (NSMutableSet*)photosSet {
	[self willAccessValueForKey:@"photos"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"photos"];

	[self didAccessValueForKey:@"photos"];
	return result;
}

@end

