import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigService } from '@nestjs/config';
import { CONFIG } from '../config/config-keys';

@Module({
  imports: [
    TypeOrmModule.forRootAsync({
      useFactory: (configService: ConfigService) => ({
        type: configService.get<any>(CONFIG.DB_TYPE),
        host: configService.get<any>(CONFIG.DB_HOST),
        port: configService.get<any>(CONFIG.DB_PORT),
        username: configService.get<any>(CONFIG.DB_USERNAME),
        password: configService.get<any>(CONFIG.DB_PASSWORD),
        database: configService.get<any>(CONFIG.DB_NAME),
        ssl: true,
        autoLoadEntities: true,
        synchronize: false,
      }),
      inject: [ConfigService],
    }),
  ],
})
export class DatabaseModule {}
