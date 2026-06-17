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
exports.OfficesService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const office_entity_1 = require("./entities/office.entity");
const amenities_service_1 = require("../amenities/amenities.service");
let OfficesService = class OfficesService {
    officesRepository;
    amenitiesService;
    constructor(officesRepository, amenitiesService) {
        this.officesRepository = officesRepository;
        this.amenitiesService = amenitiesService;
    }
    create(ownerId, createDto) {
        const office = this.officesRepository.create({ ...createDto, ownerId });
        return this.officesRepository.save(office);
    }
    async findAll(query) {
        const { page = 1, limit = 10, city } = query;
        const skip = (page - 1) * limit;
        const qb = this.officesRepository.createQueryBuilder('office')
            .leftJoinAndSelect('office.amenities', 'amenity')
            .where('office.isActive = :isActive', { isActive: true });
        if (city) {
            qb.andWhere('office.city = :city', { city });
        }
        const [items, total] = await qb.skip(skip).take(limit).getManyAndCount();
        return { items, total, page, limit };
    }
    async findOne(id) {
        const office = await this.officesRepository.findOne({
            where: { id },
            relations: { amenities: true, owner: true, slots: true }
        });
        if (!office)
            throw new common_1.NotFoundException('Office not found');
        return office;
    }
    async update(id, ownerId, updateDto) {
        const office = await this.findOne(id);
        if (office.ownerId !== ownerId)
            throw new common_1.ForbiddenException('Not allowed');
        Object.assign(office, updateDto);
        return this.officesRepository.save(office);
    }
    async remove(id, ownerId) {
        const office = await this.findOne(id);
        if (office.ownerId !== ownerId)
            throw new common_1.ForbiddenException('Not allowed');
        await this.officesRepository.softRemove(office);
    }
    async addAmenity(officeId, ownerId, amenityId) {
        const office = await this.findOne(officeId);
        if (office.ownerId !== ownerId)
            throw new common_1.ForbiddenException('Not allowed');
        const amenity = await this.amenitiesService.findById(amenityId);
        if (!office.amenities)
            office.amenities = [];
        if (!office.amenities.find(a => a.id === amenity.id)) {
            office.amenities.push(amenity);
            await this.officesRepository.save(office);
        }
        return office;
    }
    async removeAmenity(officeId, ownerId, amenityId) {
        const office = await this.findOne(officeId);
        if (office.ownerId !== ownerId)
            throw new common_1.ForbiddenException('Not allowed');
        if (office.amenities) {
            office.amenities = office.amenities.filter(a => a.id !== amenityId);
            await this.officesRepository.save(office);
        }
        return office;
    }
};
exports.OfficesService = OfficesService;
exports.OfficesService = OfficesService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(office_entity_1.Office)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        amenities_service_1.AmenitiesService])
], OfficesService);
//# sourceMappingURL=offices.service.js.map