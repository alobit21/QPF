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
exports.Office = void 0;
const typeorm_1 = require("typeorm");
const user_entity_1 = require("../../users/entities/user.entity");
const amenity_entity_1 = require("../../amenities/entities/amenity.entity");
const slot_entity_1 = require("../../slots/entities/slot.entity");
const booking_entity_1 = require("../../bookings/entities/booking.entity");
let Office = class Office {
    id;
    name;
    description;
    address;
    city;
    latitude;
    longitude;
    pricePerHour;
    size;
    availableRooms;
    images;
    isActive;
    owner;
    ownerId;
    amenities;
    slots;
    bookings;
    createdAt;
    updatedAt;
    deletedAt;
};
exports.Office = Office;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], Office.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Office.prototype, "name", void 0);
__decorate([
    (0, typeorm_1.Column)('text'),
    __metadata("design:type", String)
], Office.prototype, "description", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Office.prototype, "address", void 0);
__decorate([
    (0, typeorm_1.Index)(),
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Office.prototype, "city", void 0);
__decorate([
    (0, typeorm_1.Column)('float', { nullable: true }),
    __metadata("design:type", Number)
], Office.prototype, "latitude", void 0);
__decorate([
    (0, typeorm_1.Column)('float', { nullable: true }),
    __metadata("design:type", Number)
], Office.prototype, "longitude", void 0);
__decorate([
    (0, typeorm_1.Column)('decimal', { precision: 10, scale: 2 }),
    __metadata("design:type", Number)
], Office.prototype, "pricePerHour", void 0);
__decorate([
    (0, typeorm_1.Column)('int'),
    __metadata("design:type", Number)
], Office.prototype, "size", void 0);
__decorate([
    (0, typeorm_1.Column)('int'),
    __metadata("design:type", Number)
], Office.prototype, "availableRooms", void 0);
__decorate([
    (0, typeorm_1.Column)('simple-array', { nullable: true }),
    __metadata("design:type", Array)
], Office.prototype, "images", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: true }),
    __metadata("design:type", Boolean)
], Office.prototype, "isActive", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => user_entity_1.User, user => user.offices),
    (0, typeorm_1.JoinColumn)({ name: 'ownerId' }),
    __metadata("design:type", user_entity_1.User)
], Office.prototype, "owner", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Office.prototype, "ownerId", void 0);
__decorate([
    (0, typeorm_1.ManyToMany)(() => amenity_entity_1.Amenity, amenity => amenity.offices),
    (0, typeorm_1.JoinTable)({ name: 'office_amenities' }),
    __metadata("design:type", Array)
], Office.prototype, "amenities", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => slot_entity_1.Slot, slot => slot.office),
    __metadata("design:type", Array)
], Office.prototype, "slots", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => booking_entity_1.Booking, booking => booking.office),
    __metadata("design:type", Array)
], Office.prototype, "bookings", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], Office.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.UpdateDateColumn)(),
    __metadata("design:type", Date)
], Office.prototype, "updatedAt", void 0);
__decorate([
    (0, typeorm_1.DeleteDateColumn)(),
    __metadata("design:type", Date)
], Office.prototype, "deletedAt", void 0);
exports.Office = Office = __decorate([
    (0, typeorm_1.Entity)()
], Office);
//# sourceMappingURL=office.entity.js.map