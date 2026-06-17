import { Booking } from '../../bookings/entities/booking.entity';
export declare enum PaymentStatus {
    PENDING = "pending",
    SUCCESS = "success",
    FAILED = "failed",
    REFUNDED = "refunded"
}
export declare class Payment {
    id: string;
    booking: Booking;
    bookingId: string;
    amount: number;
    currency: string;
    method: string;
    status: PaymentStatus;
    transactionId: string;
    paidAt: Date;
}
