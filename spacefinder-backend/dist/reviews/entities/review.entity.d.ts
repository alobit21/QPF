import { User } from '../../users/entities/user.entity';
import { Office } from '../../offices/entities/office.entity';
import { Booking } from '../../bookings/entities/booking.entity';
export declare class Review {
    id: string;
    user: User;
    userId: string;
    office: Office;
    officeId: string;
    booking: Booking;
    bookingId: string;
    rating: number;
    comment: string;
    createdAt: Date;
}
