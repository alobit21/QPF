import { Controller, Get, Post, Body, Patch, Param, Delete, Query, UseGuards, UploadedFiles, UseInterceptors } from '@nestjs/common';
import { OfficesService } from './offices.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';
import { UserRole } from '../users/entities/user.entity';
import { CurrentUser } from '../common/decorators/current-user.decorator';
import { ApiTags, ApiBearerAuth, ApiConsumes } from '@nestjs/swagger';
import { FilesInterceptor } from '@nestjs/platform-express';

@ApiTags('Offices')
@Controller('offices')
export class OfficesController {
  constructor(private readonly officesService: OfficesService) {}

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(UserRole.OWNER)
  @Post()
  create(@CurrentUser() user: any, @Body() createDto: any) {
    return this.officesService.create(user.userId, createDto);
  }

  @Get()
  findAll(@Query() query: any) {
    return this.officesService.findAll(query);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.officesService.findOne(id);
  }

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(UserRole.OWNER)
  @Patch(':id')
  update(@Param('id') id: string, @CurrentUser() user: any, @Body() updateDto: any) {
    return this.officesService.update(id, user.userId, updateDto);
  }

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(UserRole.OWNER)
  @Delete(':id')
  remove(@Param('id') id: string, @CurrentUser() user: any) {
    return this.officesService.remove(id, user.userId);
  }

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(UserRole.OWNER)
  @Post(':id/amenities')
  addAmenity(@Param('id') id: string, @CurrentUser() user: any, @Body('amenityId') amenityId: string) {
    return this.officesService.addAmenity(id, user.userId, amenityId);
  }

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(UserRole.OWNER)
  @Delete(':id/amenities/:amenityId')
  removeAmenity(@Param('id') id: string, @Param('amenityId') amenityId: string, @CurrentUser() user: any) {
    return this.officesService.removeAmenity(id, user.userId, amenityId);
  }

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(UserRole.OWNER)
  @Post(':id/images')
  @UseInterceptors(FilesInterceptor('images'))
  @ApiConsumes('multipart/form-data')
  uploadImages(@Param('id') id: string, @CurrentUser() user: any, @UploadedFiles() files: Array<Express.Multer.File>) {
    // Implement cloudinary integration
    return { message: 'Images uploaded successfully', files: files?.length };
  }
}
