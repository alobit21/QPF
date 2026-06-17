import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { BookingsService } from './bookings.service';
import { BookingsController } from './bookings.controller';
import { Booking } from './entities/booking.entity';
import { SlotsModule } from '../slots/slots.module';
import { OfficesModule } from '../offices/offices.module';

@Module({
  imports: [TypeOrmModule.forFeature([Booking]), SlotsModule, OfficesModule],
  controllers: [BookingsController],
  providers: [BookingsService],
  exports: [BookingsService],
})
export class BookingsModule {}
