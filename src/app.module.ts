import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { validate } from 'environment';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      validate: validate,
    }),
    // DatabaseModule,
  ],
  controllers: [AppController],
  providers: [],
})
export class AppModule {}
