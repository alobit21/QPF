import { Office } from '../../offices/entities/office.entity';
import { Booking } from '../../bookings/entities/booking.entity';
export declare enum UserRole {
    OWNER = "owner",
    CUSTOMER = "customer",
    ADMIN = "admin",
    MANAGER = "manager"
}
export declare class User {
    id: string;
    email: string;
    password?: string;
    firstName: string;
    lastName: string;
    role: UserRole;
    phone: string;
    profileImage: string;
    isVerified: boolean;
    offices: Office[];
    bookings: Booking[];
    createdAt: Date;
    updatedAt: Date;
    deletedAt: Date;
}
