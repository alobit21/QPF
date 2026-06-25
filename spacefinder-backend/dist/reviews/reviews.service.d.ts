import { Repository } from 'typeorm';
import { Review } from './entities/review.entity';
import { BookingsService } from '../bookings/bookings.service';
export declare class ReviewsService {
    private reviewsRepository;
    private bookingsService;
    constructor(reviewsRepository: Repository<Review>, bookingsService: BookingsService);
    create(userId: string, createDto: any): Promise<Review[]>;
    findByOffice(officeId: string): Promise<Review[]>;
    findByUser(userId: string): Promise<Review[]>;
    remove(id: string, userId: string, role: string): Promise<Review>;
}
