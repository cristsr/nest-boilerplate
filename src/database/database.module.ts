import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ConfigService } from '@nestjs/config';
import { CONFIG } from '../config/keys';

@Module({
  imports: [
    MongooseModule.forRootAsync({
      useFactory: (configService: ConfigService) => ({
        uri: configService.get(CONFIG.DB_URI),
      }),
      inject: [ConfigService],
    }),
  ],
})
export class DatabaseModule {}
