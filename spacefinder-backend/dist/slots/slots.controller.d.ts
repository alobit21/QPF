import { SlotsService } from './slots.service';
export declare class SlotsController {
    private readonly slotsService;
    constructor(slotsService: SlotsService);
    create(id: string, user: any, createDto: any): Promise<import("./entities/slot.entity").Slot[]>;
    findAvailable(id: string): Promise<import("./entities/slot.entity").Slot[]>;
    update(id: string, user: any, updateDto: any): Promise<import("./entities/slot.entity").Slot>;
    remove(id: string, user: any): Promise<void>;
}
