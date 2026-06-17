import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Slot } from './entities/slot.entity';
import { OfficesService } from '../offices/offices.service';

@Injectable()
export class SlotsService {
  constructor(
    @InjectRepository(Slot)
    private slotsRepository: Repository<Slot>,
    private officesService: OfficesService,
  ) {}

  async create(officeId: string, ownerId: string, createDto: any) {
    const office = await this.officesService.findOne(officeId);
    if (office.ownerId !== ownerId) throw new ForbiddenException('Not allowed');
    
    const slot = this.slotsRepository.create({ ...createDto, officeId });
    return this.slotsRepository.save(slot);
  }

  async findAvailableByOffice(officeId: string) {
    return this.slotsRepository.find({
      where: { officeId, isAvailable: true },
      order: { date: 'ASC', startTime: 'ASC' },
    });
  }

  async findOne(id: string) {
    const slot = await this.slotsRepository.findOne({ where: { id }, relations: { office: true } });
    if (!slot) throw new NotFoundException('Slot not found');
    return slot;
  }

  async update(id: string, ownerId: string, updateDto: any) {
    const slot = await this.findOne(id);
    if (slot.office.ownerId !== ownerId) throw new ForbiddenException('Not allowed');
    
    Object.assign(slot, updateDto);
    return this.slotsRepository.save(slot);
  }

  async remove(id: string, ownerId: string) {
    const slot = await this.findOne(id);
    if (slot.office.ownerId !== ownerId) throw new ForbiddenException('Not allowed');
    
    await this.slotsRepository.remove(slot);
  }
}
