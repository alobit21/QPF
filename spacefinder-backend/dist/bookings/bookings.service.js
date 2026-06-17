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
exports.BookingsService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const booking_entity_1 = require("./entities/booking.entity");
const slots_service_1 = require("../slots/slots.service");
const offices_service_1 = require("../offices/offices.service");
let BookingsService = class BookingsService {
    bookingsRepository;
    slotsService;
    officesService;
    constructor(bookingsRepository, slotsService, officesService) {
        this.bookingsRepository = bookingsRepository;
        this.slotsService = slotsService;
        this.officesService = officesService;
    }
    async create(userId, createDto) {
        const slot = await this.slotsService.findOne(createDto.slotId);
        if (!slot.isAvailable)
            throw new common_1.BadRequestException('Slot is not available');
        const office = await this.officesService.findOne(slot.officeId);
        const duration = createDto.duration || 1;
        const totalPrice = office.pricePerHour * duration;
        const booking = this.bookingsRepository.create({
            userId,
            slotId: slot.id,
            officeId: office.id,
            duration,
            totalPrice,
            status: booking_entity_1.BookingStatus.PENDING,
        });
        slot.isAvailable = false;
        await this.slotsService.update(slot.id, office.ownerId, { isAvailable: false });
        return this.bookingsRepository.save(booking);
    }
    async findAll(user, query) {
        const { page = 1, limit = 10 } = query;
        const skip = (page - 1) * limit;
        const qb = this.bookingsRepository.createQueryBuilder('booking')
            .leftJoinAndSelect('booking.office', 'office')
            .leftJoinAndSelect('booking.slot', 'slot');
        if (user.role === 'customer') {
            qb.where('booking.userId = :userId', { userId: user.userId });
        }
        else if (user.role === 'owner') {
            qb.where('office.ownerId = :ownerId', { ownerId: user.userId });
        }
        const [items, total] = await qb.skip(skip).take(limit).getManyAndCount();
        return { items, total, page, limit };
    }
    async findOne(id, user) {
        const booking = await this.bookingsRepository.findOne({
            where: { id },
            relations: { office: true, slot: true, user: true },
        });
        if (!booking)
            throw new common_1.NotFoundException('Booking not found');
        if (user.role === 'customer' && booking.userId !== user.userId) {
            throw new common_1.ForbiddenException('Not allowed');
        }
        if (user.role === 'owner' && booking.office.ownerId !== user.userId) {
            throw new common_1.ForbiddenException('Not allowed');
        }
        return booking;
    }
    async accept(id, ownerId) {
        const booking = await this.findOne(id, { role: 'owner', userId: ownerId });
        booking.status = booking_entity_1.BookingStatus.ACCEPTED;
        return this.bookingsRepository.save(booking);
    }
    async reject(id, ownerId) {
        const booking = await this.findOne(id, { role: 'owner', userId: ownerId });
        booking.status = booking_entity_1.BookingStatus.REJECTED;
        await this.slotsService.update(booking.slotId, ownerId, { isAvailable: true });
        return this.bookingsRepository.save(booking);
    }
};
exports.BookingsService = BookingsService;
exports.BookingsService = BookingsService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(booking_entity_1.Booking)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        slots_service_1.SlotsService,
        offices_service_1.OfficesService])
], BookingsService);
//# sourceMappingURL=bookings.service.js.map