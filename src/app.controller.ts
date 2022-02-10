import { Controller, Get, HttpCode, HttpStatus, Logger } from '@nestjs/common';

@Controller('health')
export class AppController {
  private readonly logger = new Logger(AppController.name);

  @Get()
  @HttpCode(HttpStatus.ACCEPTED)
  health() {
    this.logger.log('Health check success');
  }
}
