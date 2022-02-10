import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { DatabaseModule } from './database/database.module';
import { CONFIG } from './config/config-keys';
import { AppController } from './app.controller';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    DatabaseModule,
  ],
  controllers: [AppController],
  providers: [],
})
export class AppModule {
  static port: number;

  constructor(private configService: ConfigService) {
    AppModule.port = +configService.get(CONFIG.PORT);
  }
}
