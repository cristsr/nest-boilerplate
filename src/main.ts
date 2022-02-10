import { NestFactory } from '@nestjs/core';
import { INestApplication, Logger, ValidationPipe } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { AppModule } from './app.module';
import { CONFIG } from './config/keys';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const config = app.get(ConfigService);

  app.useGlobalPipes(
    new ValidationPipe({
      transform: true,
    }),
  );

  app.enableCors();

  app.setGlobalPrefix('api');

  app.enableVersioning();

  const port = config.get(CONFIG.PORT);

  await app.listen(port);

  listRoutes(app);

  Logger.log(`App running at port ${port}`, 'Bootstrap');
}
bootstrap();

function listRoutes(app: INestApplication) {
  const server = app.getHttpServer();
  const router = server._events.request._router;
  const availableRoutes: [] = router?.stack
    .filter((layer) => !!layer.route)
    .map((layer) => ({
      route: {
        path: layer.route?.path,
        method: layer.route?.stack[0]?.method,
      },
    }));

  Logger.log('API list:', 'Bootstrap');
  console.table(availableRoutes);
}
