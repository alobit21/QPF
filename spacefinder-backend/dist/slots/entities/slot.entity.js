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
Object.defineProperty(exports, "__esModule", { value: true });
exports.Slot = void 0;
const typeorm_1 = require("typeorm");
const office_entity_1 = require("../../offices/entities/office.entity");
const booking_entity_1 = require("../../bookings/entities/booking.entity");
let Slot = class Slot {
    id;
    office;
    officeId;
    date;
    startTime;
    endTime;
    roomNumber;
    isAvailable;
    bookings;
    createdAt;
    updatedAt;
};
exports.Slot = Slot;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], Slot.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => office_entity_1.Office, office => office.slots, { onDelete: 'CASCADE' }),
    (0, typeorm_1.JoinColumn)({ name: 'officeId' }),
    __metadata("design:type", office_entity_1.Office)
], Slot.prototype, "office", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Slot.prototype, "officeId", void 0);
__decorate([
    (0, typeorm_1.Column)('date'),
    __metadata("design:type", String)
], Slot.prototype, "date", void 0);
__decorate([
    (0, typeorm_1.Column)('time'),
    __metadata("design:type", String)
], Slot.prototype, "startTime", void 0);
__decorate([
    (0, typeorm_1.Column)('time'),
    __metadata("design:type", String)
], Slot.prototype, "endTime", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Slot.prototype, "roomNumber", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: true }),
    __metadata("design:type", Boolean)
], Slot.prototype, "isAvailable", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => booking_entity_1.Booking, booking => booking.slot),
    __metadata("design:type", Array)
], Slot.prototype, "bookings", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], Slot.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.UpdateDateColumn)(),
    __metadata("design:type", Date)
], Slot.prototype, "updatedAt", void 0);
exports.Slot = Slot = __decorate([
    (0, typeorm_1.Entity)()
], Slot);
//# sourceMappingURL=slot.entity.js.map