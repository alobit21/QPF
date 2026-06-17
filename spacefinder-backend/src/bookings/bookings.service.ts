import { Injectable, NotFoundException, ForbiddenException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Booking, BookingStatus } from './entities/booking.entity';
import { SlotsService } from '../slots/slots.service';
import { OfficesService } from '../offices/offices.service';

@Injectable()
export class BookingsService {
  constructor(
    @InjectRepository(Booking)
    private bookingsRepository: Repository<Booking>,
    private slotsService: SlotsService,
    private officesService: OfficesService,
  ) {}

  async create(userId: string, createDto: any) {
    const slot = await this.slotsService.findOne(createDto.slotId);
    if (!slot.isAvailable) throw new BadRequestException('Slot is not available');

    const office = await this.officesService.findOne(slot.officeId);
    const duration = createDto.duration || 1;
    const totalPrice = office.pricePerHour * duration;

    const booking = this.bookingsRepository.create({
      userId,
      slotId: slot.id,
      officeId: office.id,
      duration,
      totalPrice,
      status: BookingStatus.PENDING,
    });

    slot.isAvailable = false;
    await this.slotsService.update(slot.id, office.ownerId, { isAvailable: false });

    return this.bookingsRepository.save(booking);
  }

  async findAll(user: any, query: any) {
    const { page = 1, limit = 10 } = query;
    const skip = (page - 1) * limit;

    const qb = this.bookingsRepository.createQueryBuilder('booking')
      .leftJoinAndSelect('booking.office', 'office')
      .leftJoinAndSelect('booking.slot', 'slot');

    if (user.role === 'customer') {
      qb.where('booking.userId = :userId', { userId: user.userId });
    } else if (user.role === 'owner') {
      qb.where('office.ownerId = :ownerId', { ownerId: user.userId });
    }

    const [items, total] = await qb.skip(skip).take(limit).getManyAndCount();
    return { items, total, page, limit };
  }

  async findOne(id: string, user: any) {
    const booking = await this.bookingsRepository.findOne({
      where: { id },
      relations: { office: true, slot: true, user: true },
    });

    if (!booking) throw new NotFoundException('Booking not found');

    if (user.role === 'customer' && booking.userId !== user.userId) {
      throw new ForbiddenException('Not allowed');
    }
    if (user.role === 'owner' && booking.office.ownerId !== user.userId) {
      throw new ForbiddenException('Not allowed');
    }

    return booking;
  }

  async accept(id: string, ownerId: string) {
    const booking = await this.findOne(id, { role: 'owner', userId: ownerId });
    booking.status = BookingStatus.ACCEPTED;
    return this.bookingsRepository.save(booking);
  }

  async reject(id: string, ownerId: string) {
    const booking = await this.findOne(id, { role: 'owner', userId: ownerId });
    booking.status = BookingStatus.REJECTED;
    
    // Free the slot
    await this.slotsService.update(booking.slotId, ownerId, { isAvailable: true });
    
    return this.bookingsRepository.save(booking);
  }
}
