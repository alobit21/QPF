import { OfficesService } from './offices.service';
export declare class OfficesController {
    private readonly officesService;
    constructor(officesService: OfficesService);
    create(user: any, createDto: any): Promise<import("./entities/office.entity").Office[]>;
    findAll(query: any): Promise<{
        items: import("./entities/office.entity").Office[];
        total: number;
        page: any;
        limit: any;
    }>;
    findOne(id: string): Promise<import("./entities/office.entity").Office>;
    update(id: string, user: any, updateDto: any): Promise<import("./entities/office.entity").Office>;
    remove(id: string, user: any): Promise<void>;
    addAmenity(id: string, user: any, amenityId: string): Promise<import("./entities/office.entity").Office>;
    removeAmenity(id: string, amenityId: string, user: any): Promise<import("./entities/office.entity").Office>;
    uploadImages(id: string, user: any, files: Array<Express.Multer.File>): {
        message: string;
        files: number;
    };
}
