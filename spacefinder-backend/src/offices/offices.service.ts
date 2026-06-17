import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Office } from './entities/office.entity';
import { AmenitiesService } from '../amenities/amenities.service';

@Injectable()
export class OfficesService {
  constructor(
    @InjectRepository(Office)
    private officesRepository: Repository<Office>,
    private amenitiesService: AmenitiesService,
  ) {}

  create(ownerId: string, createDto: any) {
    const office = this.officesRepository.create({ ...createDto, ownerId });
    return this.officesRepository.save(office);
  }

  async findAll(query: any) {
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

  async findOne(id: string) {
    const office = await this.officesRepository.findOne({ 
      where: { id },
      relations: { amenities: true, owner: true, slots: true } 
    });
    if (!office) throw new NotFoundException('Office not found');
    return office;
  }

  async update(id: string, ownerId: string, updateDto: any) {
    const office = await this.findOne(id);
    if (office.ownerId !== ownerId) throw new ForbiddenException('Not allowed');
    Object.assign(office, updateDto);
    return this.officesRepository.save(office);
  }

  async remove(id: string, ownerId: string) {
    const office = await this.findOne(id);
    if (office.ownerId !== ownerId) throw new ForbiddenException('Not allowed');
    await this.officesRepository.softRemove(office);
  }

  async addAmenity(officeId: string, ownerId: string, amenityId: string) {
    const office = await this.findOne(officeId);
    if (office.ownerId !== ownerId) throw new ForbiddenException('Not allowed');
    const amenity = await this.amenitiesService.findById(amenityId);
    
    if (!office.amenities) office.amenities = [];
    if (!office.amenities.find(a => a.id === amenity.id)) {
      office.amenities.push(amenity);
      await this.officesRepository.save(office);
    }
    return office;
  }

  async removeAmenity(officeId: string, ownerId: string, amenityId: string) {
    const office = await this.findOne(officeId);
    if (office.ownerId !== ownerId) throw new ForbiddenException('Not allowed');
    
    if (office.amenities) {
      office.amenities = office.amenities.filter(a => a.id !== amenityId);
      await this.officesRepository.save(office);
    }
    return office;
  }
}
