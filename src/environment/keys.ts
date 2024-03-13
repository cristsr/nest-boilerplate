import { Transform } from 'class-transformer';
import { IsBoolean, IsNumber, IsString } from 'class-validator';
import { mapEnvironmentKeys } from 'src/environment/utils';

/**
 * Define here all environment variables to create dynamic CONFIG object that is used
 * to access to all properties using ConfigService.
 * @see https://docs.nestjs.com/techniques/configuration
 */
export class Environment {
  @IsString()
  ENV: string;

  @Transform(({ value }) => Number(value))
  @IsNumber()
  PORT: number;

  @IsString()
  DB_URI: string;

  @Transform(({ value }) => value === 'true')
  @IsBoolean()
  SHOW_DOCS: boolean;
}

/**
 * Object created dynamically to access all properties defined in Environment class
 * used as enum to retrieve values using ConfigService.
 *
 * @usageNotes
 *
 * ### Retrieve config values
 *
 * ```ts
 * class MyService {
 *   constructor(private configService: ConfigService) {}
 *
 *   doSomething(): void {
 *     const env = this.configService.get(CONFIG.ENV);
 *     const port = this.configService.get(CONFIG.PORT);
 *   }
 * }
 * ```
 */
export const ENV = mapEnvironmentKeys<Environment>(Environment);
