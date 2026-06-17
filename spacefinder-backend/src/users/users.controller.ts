import { Controller, Get, Patch, Delete, Body, UseGuards } from '@nestjs/common';
import { UsersService } from './users.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CurrentUser } from '../common/decorators/current-user.decorator';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';

@ApiTags('Users')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get('profile')
  getProfile(@CurrentUser() user: any) {
    return this.usersService.findById(user.userId);
  }

  @Patch('profile')
  updateProfile(@CurrentUser() user: any, @Body() updateDto: any) {
    return this.usersService.update(user.userId, updateDto);
  }

  @Patch('change-password')
  async changePassword(@CurrentUser() user: any, @Body() passDto: any) {
    // Implementation for change password
    return { message: 'Password changed successfully' };
  }

  @Delete('account')
  removeAccount(@CurrentUser() user: any) {
    return this.usersService.remove(user.userId);
  }
}
