import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { INestApplication, Logger, ValidationPipe } from '@nestjs/common';

function listRoutes(app: INestApplication) {
  const server = app.getHttpServer();
  const router = server._events.request._router;
  const availableRoutes: [] = router?.stack
    .map((layer) => {
      if (layer.route) {
        return {
          route: {
            path: layer.route?.path,
            method: layer.route?.stack[0]?.method,
          },
        };
      }
    })
    .filter((item) => item !== undefined);

  Logger.log('API list:', 'Bootstrap');
  console.table(availableRoutes);
}

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.useGlobalPipes(new ValidationPipe());

  app.enableCors();

  app.setGlobalPrefix('api/v1');

  await app.listen(AppModule.port);

  listRoutes(app);

  Logger.log(`App running at port ${AppModule.port}`, 'Bootstrap');
}
bootstrap();
