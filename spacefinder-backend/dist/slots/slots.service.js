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
exports.SlotsService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const slot_entity_1 = require("./entities/slot.entity");
const offices_service_1 = require("../offices/offices.service");
let SlotsService = class SlotsService {
    slotsRepository;
    officesService;
    constructor(slotsRepository, officesService) {
        this.slotsRepository = slotsRepository;
        this.officesService = officesService;
    }
    async create(officeId, ownerId, createDto) {
        const office = await this.officesService.findOne(officeId);
        if (office.ownerId !== ownerId)
            throw new common_1.ForbiddenException('Not allowed');
        const slot = this.slotsRepository.create({ ...createDto, officeId });
        return this.slotsRepository.save(slot);
    }
    async findAvailableByOffice(officeId) {
        return this.slotsRepository.find({
            where: { officeId, isAvailable: true },
            order: { date: 'ASC', startTime: 'ASC' },
        });
    }
    async findOne(id) {
        const slot = await this.slotsRepository.findOne({ where: { id }, relations: { office: true } });
        if (!slot)
            throw new common_1.NotFoundException('Slot not found');
        return slot;
    }
    async update(id, ownerId, updateDto) {
        const slot = await this.findOne(id);
        if (slot.office.ownerId !== ownerId)
            throw new common_1.ForbiddenException('Not allowed');
        Object.assign(slot, updateDto);
        return this.slotsRepository.save(slot);
    }
    async remove(id, ownerId) {
        const slot = await this.findOne(id);
        if (slot.office.ownerId !== ownerId)
            throw new common_1.ForbiddenException('Not allowed');
        await this.slotsRepository.remove(slot);
    }
};
exports.SlotsService = SlotsService;
exports.SlotsService = SlotsService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(slot_entity_1.Slot)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        offices_service_1.OfficesService])
], SlotsService);
//# sourceMappingURL=slots.service.js.map