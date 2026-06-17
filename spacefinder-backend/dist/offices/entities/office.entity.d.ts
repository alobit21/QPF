import { User } from '../../users/entities/user.entity';
import { Amenity } from '../../amenities/entities/amenity.entity';
import { Slot } from '../../slots/entities/slot.entity';
import { Booking } from '../../bookings/entities/booking.entity';
export declare class Office {
    id: string;
    name: string;
    description: string;
    address: string;
    city: string;
    latitude: number;
    longitude: number;
    pricePerHour: number;
    size: number;
    availableRooms: number;
    images: string[];
    isActive: boolean;
    owner: User;
    ownerId: string;
    amenities: Amenity[];
    slots: Slot[];
    bookings: Booking[];
    createdAt: Date;
    updatedAt: Date;
    deletedAt: Date;
}
