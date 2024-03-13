import { Module } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';
import { ENV } from 'environment';

@Module({
  imports: [
    MongooseModule.forRootAsync({
      useFactory: (configService: ConfigService) => ({
        uri: configService.get(ENV.DB_URI),
      }),
      inject: [ConfigService],
    }),
  ],
})
export class DatabaseModule {}
