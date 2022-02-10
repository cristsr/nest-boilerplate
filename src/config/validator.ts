import { plainToClass } from 'class-transformer';
import { validateSync } from 'class-validator';

import { Logger } from '@nestjs/common';
import { Environment } from './keys';

export function validate(config: Record<string, unknown>) {
  const logger = new Logger(validate.name);

  const validatedConfig = plainToClass(Environment, config, {
    enableImplicitConversion: true,
  });

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
