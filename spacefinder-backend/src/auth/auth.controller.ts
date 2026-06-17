import { Controller, Post, Body, UnauthorizedException, HttpCode, HttpStatus } from '@nestjs/common';
import { AuthService } from './auth.service';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Auth')
@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('register')
  async register(@Body() registerDto: any) {
    return this.authService.register(registerDto);
  }

  @HttpCode(HttpStatus.OK)
  @Post('login')
  async login(@Body() loginDto: any) {
    const user = await this.authService.validateUser(loginDto.email, loginDto.password);
    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }
    return this.authService.login(user);
  }

  @Post('refresh-token')
  async refreshToken(@Body() tokenDto: any) {
    // Implement token refresh logic
    return { message: 'Token refreshed' };
  }

  @Post('forgot-password')
  async forgotPassword(@Body() dto: any) {
    return { message: 'Password reset link sent' };
  }

  @Post('reset-password')
  async resetPassword(@Body() dto: any) {
    return { message: 'Password reset successfully' };
  }
}
