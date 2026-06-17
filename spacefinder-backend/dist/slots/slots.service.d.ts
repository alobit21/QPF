import { Repository } from 'typeorm';
import { Slot } from './entities/slot.entity';
import { OfficesService } from '../offices/offices.service';
export declare class SlotsService {
    private slotsRepository;
    private officesService;
    constructor(slotsRepository: Repository<Slot>, officesService: OfficesService);
    create(officeId: string, ownerId: string, createDto: any): Promise<Slot[]>;
    findAvailableByOffice(officeId: string): Promise<Slot[]>;
    findOne(id: string): Promise<Slot>;
    update(id: string, ownerId: string, updateDto: any): Promise<Slot>;
    remove(id: string, ownerId: string): Promise<void>;
}
