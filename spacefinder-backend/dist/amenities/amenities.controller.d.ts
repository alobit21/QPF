import { AmenitiesService } from './amenities.service';
export declare class AmenitiesController {
    private readonly amenitiesService;
    constructor(amenitiesService: AmenitiesService);
    create(createDto: any): Promise<import("./entities/amenity.entity").Amenity[]>;
    findAll(): Promise<import("./entities/amenity.entity").Amenity[]>;
}
