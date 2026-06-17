import { BookingsService } from './bookings.service';
export declare class BookingsController {
    private readonly bookingsService;
    constructor(bookingsService: BookingsService);
    create(user: any, createDto: any): Promise<import("./entities/booking.entity").Booking>;
    findAll(user: any, query: any): Promise<{
        items: import("./entities/booking.entity").Booking[];
        total: number;
        page: any;
        limit: any;
    }>;
    getHistory(user: any, query: any): Promise<{
        items: import("./entities/booking.entity").Booking[];
        total: number;
        page: any;
        limit: any;
    }>;
    findOne(id: string, user: any): Promise<import("./entities/booking.entity").Booking>;
    accept(id: string, user: any): Promise<import("./entities/booking.entity").Booking>;
    reject(id: string, user: any): Promise<import("./entities/booking.entity").Booking>;
}
