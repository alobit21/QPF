import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Payment, PaymentStatus } from './entities/payment.entity';
import { BookingsService } from '../bookings/bookings.service';

@Injectable()
export class PaymentsService {
  constructor(
    @InjectRepository(Payment)
    private paymentsRepository: Repository<Payment>,
    private bookingsService: BookingsService,
  ) {}

  async initiate(userId: string, initiateDto: any) {
    const booking = await this.bookingsService.findOne(initiateDto.bookingId, { role: 'customer', userId });
    
    const payment = this.paymentsRepository.create({
      bookingId: booking.id,
      amount: booking.totalPrice,
      currency: 'USD',
      method: initiateDto.method,
      status: PaymentStatus.PENDING,
    });
    
    // Logic to call external payment gateway...

    return this.paymentsRepository.save(payment);
  }

  async handleWebhook(payload: any) {
    // Process webhook logic
    return { success: true };
  }

  async findByBookingId(bookingId: string) {
    const payment = await this.paymentsRepository.findOne({ where: { bookingId } });
    if (!payment) throw new NotFoundException('Payment not found');
    return payment;
  }
}
