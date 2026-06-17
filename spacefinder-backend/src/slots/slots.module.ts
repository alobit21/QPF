import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SlotsService } from './slots.service';
import { SlotsController } from './slots.controller';
import { Slot } from './entities/slot.entity';
import { OfficesModule } from '../offices/offices.module';

@Module({
  imports: [TypeOrmModule.forFeature([Slot]), OfficesModule],
  controllers: [SlotsController],
  providers: [SlotsService],
  exports: [SlotsService],
})
export class SlotsModule {}
