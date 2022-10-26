import { plainToClass } from 'class-transformer';
import { getMetadataStorage, validateSync } from 'class-validator';
import { Logger, Type } from '@nestjs/common';
import { Environment } from './keys';

export type Keys<T> = Readonly<{
  [key in keyof T]: key;
}>;

export function validate(config: Record<string, unknown>) {
  const logger = new Logger(validate.name);

  const validatedConfig = plainToClass(Environment, config);

  const errors = validateSync(validatedConfig, {
    skipMissingProperties: false,
  });

  if (errors.length > 0) {
    errors
      .map((error) => error.constraints)
      .map((constraints) => Object.values(constraints))
      .forEach((v) => logger.error(v));

    throw new TypeError('Invalid environment configuration');
  }

  return validatedConfig;
}

export function mapEnvironmentKeys<T>(type: Type<T>): Keys<T> {
  const metadataStorage = getMetadataStorage();

  const targetMetadata = metadataStorage.getTargetValidationMetadatas(
    type,
    null,
    false,
    false,
  );

  const entries = targetMetadata.map(({ propertyName }) => [
    propertyName,
    propertyName,
  ]);

  return Object.freeze(Object.fromEntries(entries));
}
