import { Office } from '../../offices/entities/office.entity';
import { Booking } from '../../bookings/entities/booking.entity';
export declare class Slot {
    id: string;
    office: Office;
    officeId: string;
    date: string;
    startTime: string;
    endTime: string;
    roomNumber: string;
    isAvailable: boolean;
    bookings: Booking[];
    createdAt: Date;
    updatedAt: Date;
}
