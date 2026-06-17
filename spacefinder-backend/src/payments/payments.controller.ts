import { Controller, Get, Post, Body, Param, UseGuards } from '@nestjs/common';
import { PaymentsService } from './payments.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CurrentUser } from '../common/decorators/current-user.decorator';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';

@ApiTags('Payments')
@Controller('payments')
export class PaymentsController {
  constructor(private readonly paymentsService: PaymentsService) {}

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  @Post('initiate')
  initiate(@CurrentUser() user: any, @Body() initiateDto: any) {
    return this.paymentsService.initiate(user.userId, initiateDto);
  }

  @Post('webhook')
  webhook(@Body() payload: any) {
    return this.paymentsService.handleWebhook(payload);
  }

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  @Get(':bookingId')
  findByBookingId(@Param('bookingId') bookingId: string) {
    return this.paymentsService.findByBookingId(bookingId);
  }
}
