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
exports.ReviewsService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const review_entity_1 = require("./entities/review.entity");
const bookings_service_1 = require("../bookings/bookings.service");
const booking_entity_1 = require("../bookings/entities/booking.entity");
let ReviewsService = class ReviewsService {
    reviewsRepository;
    bookingsService;
    constructor(reviewsRepository, bookingsService) {
        this.reviewsRepository = reviewsRepository;
        this.bookingsService = bookingsService;
    }
    async create(userId, createDto) {
        const booking = await this.bookingsService.findOne(createDto.bookingId, { role: 'customer', userId });
        if (booking.status !== booking_entity_1.BookingStatus.COMPLETED) {
            throw new common_1.BadRequestException('Can only review completed bookings');
        }
        const review = this.reviewsRepository.create({
            ...createDto,
            userId,
            officeId: booking.officeId,
        });
        return this.reviewsRepository.save(review);
    }
    findByOffice(officeId) {
        return this.reviewsRepository.find({
            where: { officeId },
            relations: { user: true },
        });
    }
    findByUser(userId) {
        return this.reviewsRepository.find({
            where: { userId },
            relations: { office: true },
        });
    }
    async remove(id, userId) {
        const review = await this.reviewsRepository.findOne({ where: { id } });
        if (!review)
            throw new common_1.NotFoundException('Review not found');
        if (review.userId !== userId)
            throw new common_1.ForbiddenException('Not allowed');
        return this.reviewsRepository.remove(review);
    }
};
exports.ReviewsService = ReviewsService;
exports.ReviewsService = ReviewsService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(review_entity_1.Review)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        bookings_service_1.BookingsService])
], ReviewsService);
//# sourceMappingURL=reviews.service.js.map