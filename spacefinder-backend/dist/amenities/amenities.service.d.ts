import { Repository } from 'typeorm';
import { Amenity } from './entities/amenity.entity';
export declare class AmenitiesService {
    private amenitiesRepository;
    constructor(amenitiesRepository: Repository<Amenity>);
    create(createDto: any): Promise<Amenity[]>;
    findAll(): Promise<Amenity[]>;
    findById(id: string): Promise<Amenity>;
}
