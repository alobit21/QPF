import { Controller, Get, Post, Body, Patch, Param, UseGuards, Query } from '@nestjs/common';
import { BookingsService } from './bookings.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';
import { UserRole } from '../users/entities/user.entity';
import { CurrentUser } from '../common/decorators/current-user.decorator';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';

@ApiTags('Bookings')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard, RolesGuard)
@Controller('bookings')
export class BookingsController {
  constructor(private readonly bookingsService: BookingsService) {}

  @Roles(UserRole.CUSTOMER)
  @Post()
  create(@CurrentUser() user: any, @Body() createDto: any) {
    return this.bookingsService.create(user.userId, createDto);
  }

  @Get()
  findAll(@CurrentUser() user: any, @Query() query: any) {
    return this.bookingsService.findAll(user, query);
  }

  @Get('history')
  getHistory(@CurrentUser() user: any, @Query() query: any) {
    return this.bookingsService.findAll(user, query);
  }

  @Get(':id')
  findOne(@Param('id') id: string, @CurrentUser() user: any) {
    return this.bookingsService.findOne(id, user);
  }

  @Roles(UserRole.OWNER)
  @Patch(':id/accept')
  accept(@Param('id') id: string, @CurrentUser() user: any) {
    return this.bookingsService.accept(id, user.userId);
  }

  @Roles(UserRole.OWNER)
  @Patch(':id/reject')
  reject(@Param('id') id: string, @CurrentUser() user: any) {
    return this.bookingsService.reject(id, user.userId);
  }
}
