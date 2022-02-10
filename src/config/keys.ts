import { IsBoolean, IsNumber, IsString } from 'class-validator';
import { Transform } from 'class-transformer';

/**
 * Define here all environment variables and initialize them
 * with undefined to create dynamic CONFIG object that is used
 * to access to all properties using ConfigService.
 * @see https://docs.nestjs.com/techniques/configuration
 */
export class Environment {
  @IsString()
  ENV: string = undefined;

  @Transform(({ value }) => Number(value))
  @IsNumber()
  PORT: number = undefined;

  @IsString()
  DB_HOST: string = undefined;

  @IsString()
  DB_TYPE: string = undefined;

  @Transform(({ value }) => Number(value))
  @IsNumber()
  DB_PORT: number = undefined;

  @IsString()
  DB_USERNAME: string = undefined;

  @IsString()
  DB_PASSWORD: string = undefined;

  @IsString()
  DB_NAME: string = undefined;

  @Transform(({ value }) => value === 'true')
  @IsBoolean()
  DB_SSL: boolean = undefined;

  @Transform(({ value }) => value === 'true')
  @IsBoolean()
  DB_SYNCHRONIZE: boolean = undefined;

  @Transform(({ value }) => value === 'true')
  @IsBoolean()
  SHOW_DOCS: boolean = undefined;
}

const keys = Object.keys(new Environment()) as (keyof Environment)[];

const entries = keys.map((key) => [key, key]);

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
export const CONFIG = Object.fromEntries(entries) as {
  [key in keyof Environment]: string;
};
