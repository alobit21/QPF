import { User } from '../../users/entities/user.entity';
import { Office } from '../../offices/entities/office.entity';
import { Slot } from '../../slots/entities/slot.entity';
export declare enum BookingStatus {
    PENDING = "pending",
    ACCEPTED = "accepted",
    REJECTED = "rejected",
    COMPLETED = "completed"
}
export declare class Booking {
    id: string;
    user: User;
    userId: string;
    slot: Slot;
    slotId: string;
    office: Office;
    officeId: string;
    status: BookingStatus;
    totalPrice: number;
    duration: number;
    createdAt: Date;
    updatedAt: Date;
}
