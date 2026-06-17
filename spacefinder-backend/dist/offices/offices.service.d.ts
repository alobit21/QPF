import { Repository } from 'typeorm';
import { Office } from './entities/office.entity';
import { AmenitiesService } from '../amenities/amenities.service';
export declare class OfficesService {
    private officesRepository;
    private amenitiesService;
    constructor(officesRepository: Repository<Office>, amenitiesService: AmenitiesService);
    create(ownerId: string, createDto: any): Promise<Office[]>;
    findAll(query: any): Promise<{
        items: Office[];
        total: number;
        page: any;
        limit: any;
    }>;
    findOne(id: string): Promise<Office>;
    update(id: string, ownerId: string, updateDto: any): Promise<Office>;
    remove(id: string, ownerId: string): Promise<void>;
    addAmenity(officeId: string, ownerId: string, amenityId: string): Promise<Office>;
    removeAmenity(officeId: string, ownerId: string, amenityId: string): Promise<Office>;
}
