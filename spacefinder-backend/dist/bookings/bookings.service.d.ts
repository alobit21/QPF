import { Repository } from 'typeorm';
import { Booking } from './entities/booking.entity';
import { SlotsService } from '../slots/slots.service';
import { OfficesService } from '../offices/offices.service';
export declare class BookingsService {
    private bookingsRepository;
    private slotsService;
    private officesService;
    constructor(bookingsRepository: Repository<Booking>, slotsService: SlotsService, officesService: OfficesService);
    create(userId: string, createDto: any): Promise<Booking>;
    findAll(user: any, query: any): Promise<{
        items: Booking[];
        total: number;
        page: any;
        limit: any;
    }>;
    findOne(id: string, user: any): Promise<Booking>;
    accept(id: string, ownerId: string): Promise<Booking>;
    reject(id: string, ownerId: string): Promise<Booking>;
}
