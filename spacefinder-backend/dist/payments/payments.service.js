"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.PaymentsService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const payment_entity_1 = require("./entities/payment.entity");
const bookings_service_1 = require("../bookings/bookings.service");
let PaymentsService = class PaymentsService {
    paymentsRepository;
    bookingsService;
    constructor(paymentsRepository, bookingsService) {
        this.paymentsRepository = paymentsRepository;
        this.bookingsService = bookingsService;
    }
    async initiate(userId, initiateDto) {
        const booking = await this.bookingsService.findOne(initiateDto.bookingId, { role: 'customer', userId });
        const payment = this.paymentsRepository.create({
            bookingId: booking.id,
            amount: booking.totalPrice,
            currency: 'USD',
            method: initiateDto.method,
            status: payment_entity_1.PaymentStatus.PENDING,
        });
        return this.paymentsRepository.save(payment);
    }
    async handleWebhook(payload) {
        return { success: true };
    }
    async findByBookingId(bookingId) {
        const payment = await this.paymentsRepository.findOne({ where: { bookingId } });
        if (!payment)
            throw new common_1.NotFoundException('Payment not found');
        return payment;
    }
};
exports.PaymentsService = PaymentsService;
exports.PaymentsService = PaymentsService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(payment_entity_1.Payment)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        bookings_service_1.BookingsService])
], PaymentsService);
//# sourceMappingURL=payments.service.js.map