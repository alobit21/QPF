import { User } from '../../users/entities/user.entity';
import { Booking } from '../../bookings/entities/booking.entity';
export declare class Message {
    id: string;
    booking: Booking;
    bookingId: string;
    sender: User;
    senderId: string;
    receiver: User;
    receiverId: string;
    content: string;
    isRead: boolean;
    createdAt: Date;
}
