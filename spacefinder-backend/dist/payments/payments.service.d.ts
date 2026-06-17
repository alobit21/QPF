import { Repository } from 'typeorm';
import { Payment } from './entities/payment.entity';
import { BookingsService } from '../bookings/bookings.service';
export declare class PaymentsService {
    private paymentsRepository;
    private bookingsService;
    constructor(paymentsRepository: Repository<Payment>, bookingsService: BookingsService);
    initiate(userId: string, initiateDto: any): Promise<Payment>;
    handleWebhook(payload: any): Promise<{
        success: boolean;
    }>;
    findByBookingId(bookingId: string): Promise<Payment>;
}
