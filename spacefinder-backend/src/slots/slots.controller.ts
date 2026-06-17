import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards } from '@nestjs/common';
import { SlotsService } from './slots.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';
import { UserRole } from '../users/entities/user.entity';
import { CurrentUser } from '../common/decorators/current-user.decorator';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';

@ApiTags('Slots')
@Controller()
export class SlotsController {
  constructor(private readonly slotsService: SlotsService) {}

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(UserRole.OWNER)
  @Post('offices/:id/slots')
  create(@Param('id') id: string, @CurrentUser() user: any, @Body() createDto: any) {
    return this.slotsService.create(id, user.userId, createDto);
  }

  @Get('offices/:id/slots')
  findAvailable(@Param('id') id: string) {
    return this.slotsService.findAvailableByOffice(id);
  }

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(UserRole.OWNER)
  @Patch('slots/:id')
  update(@Param('id') id: string, @CurrentUser() user: any, @Body() updateDto: any) {
    return this.slotsService.update(id, user.userId, updateDto);
  }

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(UserRole.OWNER)
  @Delete('slots/:id')
  remove(@Param('id') id: string, @CurrentUser() user: any) {
    return this.slotsService.remove(id, user.userId);
  }
}
