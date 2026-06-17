import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { OfficesService } from './offices.service';
import { OfficesController } from './offices.controller';
import { Office } from './entities/office.entity';
import { AmenitiesModule } from '../amenities/amenities.module';

@Module({
  imports: [TypeOrmModule.forFeature([Office]), AmenitiesModule],
  controllers: [OfficesController],
  providers: [OfficesService],
  exports: [OfficesService],
})
export class OfficesModule {}
