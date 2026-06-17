import { PaymentsService } from './payments.service';
export declare class PaymentsController {
    private readonly paymentsService;
    constructor(paymentsService: PaymentsService);
    initiate(user: any, initiateDto: any): Promise<import("./entities/payment.entity").Payment>;
    webhook(payload: any): Promise<{
        success: boolean;
    }>;
    findByBookingId(bookingId: string): Promise<import("./entities/payment.entity").Payment>;
}
