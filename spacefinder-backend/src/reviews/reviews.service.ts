import { Injectable, BadRequestException, NotFoundException, ForbiddenException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Review } from './entities/review.entity';
import { BookingsService } from '../bookings/bookings.service';
import { BookingStatus } from '../bookings/entities/booking.entity';

@Injectable()
export class ReviewsService {
  constructor(
    @InjectRepository(Review)
    private reviewsRepository: Repository<Review>,
    private bookingsService: BookingsService,
  ) {}

  async create(userId: string, createDto: any) {
    const booking = await this.bookingsService.findOne(createDto.bookingId, { role: 'customer', userId });
    
    if (booking.status !== BookingStatus.COMPLETED) {
      throw new BadRequestException('Can only review completed bookings');
    }

    const review = this.reviewsRepository.create({
      ...createDto,
      userId,
      officeId: booking.officeId,
    });

    return this.reviewsRepository.save(review);
  }

  findByOffice(officeId: string) {
    return this.reviewsRepository.find({
      where: { officeId },
      relations: { user: true },
    });
  }

  findByUser(userId: string) {
    return this.reviewsRepository.find({
      where: { userId },
      relations: { office: true },
    });
  }

  async remove(id: string, userId: string, role: string) {
    const review = await this.reviewsRepository.findOne({ where: { id } });
    if (!review) throw new NotFoundException('Review not found');
    if (review.userId !== userId && role !== 'admin' && role !== 'manager') throw new ForbiddenException('Not allowed');

    return this.reviewsRepository.remove(review);
  }
}
